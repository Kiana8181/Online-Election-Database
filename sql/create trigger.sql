-- Create a trigger function
CREATE OR REPLACE FUNCTION prevent_duplicate_vote()
RETURNS TRIGGER AS $$
BEGIN
  -- Check if a duplicate vote with the same national ID already exists in the EVZ table
  IF EXISTS (
    SELECT 1
    FROM EVZ
    WHERE NATIONALID = NEW.NATIONALID AND VOTE = NEW.VOTE
    LIMIT 1
  ) THEN
    -- Raise an exception if a duplicate vote is found
    RAISE EXCEPTION 'A duplicate vote with the same national ID already exists.';
  END IF;

  -- Return the new row
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger on the EVZ table
CREATE TRIGGER check_duplicate_vote
BEFORE INSERT OR UPDATE ON EVZ
FOR EACH ROW
EXECUTE FUNCTION prevent_duplicate_vote();



-- Create a trigger function to prevent duplicate CNATIONALID in ECS table
CREATE FUNCTION check_duplicate_cnationalid_in_election()
RETURNS TRIGGER AS $$
BEGIN
  -- Check if a duplicate CNATIONALID with the same PERIOD and PERIODNUM type already exists in ECS table
  IF EXISTS (
    SELECT 1
    FROM ECS
    WHERE CNATIONALID = NEW.CNATIONALID AND PERIOD = NEW.PERIOD 
	  AND (SUBSTRING(PERIODNUM,1,1) <> SUBSTRING(NEW.PERIODNUM,1,1) AND SUBSTRING(PERIODNUM,2,50) = SUBSTRING(NEW.PERIODNUM,2,50))
    AND (NEW.CNATIONALID, NEW.PERIOD, NEW.PERIODNUM) IS DISTINCT FROM (CNATIONALID, PERIOD, PERIODNUM)
  ) THEN
    -- Raise an exception if a duplicate CNATIONALID is found
    RAISE EXCEPTION 'A duplicate CNATIONALID with the same PERIOD and PERIODNUM type already exists in ECS table.';
  END IF;

  -- Return the new row
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger on the ECS table
CREATE TRIGGER prevent_duplicate_cnationalid_trigger
BEFORE INSERT OR UPDATE ON ECS
FOR EACH ROW
WHEN (pg_trigger_depth() = 0)
EXECUTE FUNCTION check_duplicate_cnationalid_in_election();




-- Create or replace a function to check the vote count
CREATE OR REPLACE FUNCTION check_vote_count()
RETURNS TRIGGER AS $$
DECLARE
    election_type CHAR(1);
    vote_count INTEGER;
BEGIN
    -- Get the election type from the PERIODNUM substring
    election_type := SUBSTRING(NEW.PERIODNUM, 1, 1);

    -- Count the number of rows with the same NationalID in EVZ table based on the election type
    SELECT COUNT(*)
    INTO vote_count
    FROM EVZ
    WHERE NATIONALID = NEW.NATIONALID
    AND SUBSTRING(PERIODNUM, 1, 1) = election_type;

    -- Check the election type and the vote count to enforce the condition
    IF (election_type = 'a' AND vote_count >= 1) OR (election_type IN ('b', 'c', 'd') AND vote_count >= 5) THEN
        -- Raise an exception if the maximum number of votes has been reached for the NationalID and election type
        RAISE EXCEPTION 'The maximum number of votes for NationalID % and election type % has been reached.', NEW.NATIONALID, election_type;
    END IF;

    -- Return the new row
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to prevent duplicate votes
CREATE TRIGGER prevent_duplicate_votes
BEFORE INSERT ON EVZ
FOR EACH ROW
EXECUTE FUNCTION check_vote_count();




-- Create a trigger function to enforce constraint on the VOTE column in the EVZ table
CREATE FUNCTION check_cqualification_vote()
RETURNS TRIGGER AS $$
BEGIN
  -- Check if the VOTE value is not null and refers to a candidate in the ECS table with CQUALIFICATION = false
  IF NEW.VOTE IS NOT NULL AND EXISTS (
    SELECT 1
    FROM CANDIDATE c
    JOIN ECS e ON c.CNATIONALID = e.CNATIONALID
    WHERE c.CNATIONALID = NEW.VOTE AND e.CQUALIFICATION = 'f'::BOOLEAN
  ) THEN
    -- Raise an exception if the VOTE value is invalid
    RAISE EXCEPTION 'Invalid VOTE value % in EVZ table. The CNATIONALID refers to a candidate in ECS table with CQUALIFICATION = 0.', NEW.vote;
  END IF;

  -- Return the new row
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger on the EVZ table
CREATE TRIGGER enforce_cqualification_vote_trigger
BEFORE INSERT OR UPDATE ON EVZ
FOR EACH ROW
WHEN (pg_trigger_depth() = 0)
EXECUTE FUNCTION check_cqualification_vote();




-- Create the trigger function
CREATE FUNCTION check_election_relation_function() RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM ECS
        WHERE CNATIONALID = NEW.NATIONALID
        AND PERIOD = NEW.PERIOD
        AND PERIODNUM = NEW.PERIODNUM
    )
    THEN
        RAISE EXCEPTION 'The vote does not have a relation with the specified period in ECS.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger
CREATE TRIGGER check_election_relation
BEFORE INSERT ON EVZ
FOR EACH ROW
EXECUTE FUNCTION check_election_relation_function();



