-- Creating a view named "APPROVEDCANDIDATES" to store approved candidates' information

CREATE VIEW APPROVEDCANDIDATES AS
-- Selecting the necessary columns from the candidate, ecs, and election tables
SELECT C.CNATIONALID, C.FNAME, C.LNAME, E.INTERPERIOD, E.PERIOD, E.PERIODNUM, E.TYPE
FROM CANDIDATE C
-- Joining the candidate table with ecs table using the CNATIONALID column
JOIN ECS ON C.CNATIONALID = ECS.CNATIONALID
-- Joining the ecs table with election table using the PERIOD and PERIODNUM columns
JOIN ELECTION E ON ECS.PERIOD = E.PERIOD AND ECS.PERIODNUM = E.PERIODNUM
-- Filtering the candidates based on their qualification status
WHERE ECS.CQUALIFICATION = TRUE;


-- Creating a view named "CANDIDATESQUALIFICATIONSTATUS" to store candidates' qualification status information

CREATE VIEW CANDIDATESQUALIFICATIONSTATUS AS
-- Selecting the necessary columns from the candidate, ecs, and election tables
SELECT C.CNATIONALID, C.FNAME, C.LNAME, C.BDATE, C.CPAPER, C.PHISTORY, C.PHNUMBER, E.INTERPERIOD, E.PERIOD, E.PERIODNUM, ECS.CQUALIFICATION, E.TYPE
FROM CANDIDATE C
-- Joining the candidate table with ecs table using the CNATIONALID column
INNER JOIN ECS ON C.CNATIONALID = ECS.CNATIONALID
-- Joining the ecs table with election table using the PERIOD and PERIODNUM columns
INNER JOIN ELECTION E ON ECS.PERIOD = E.PERIOD AND ECS.PERIODNUM = E.PERIODNUM;


-- Creating a view named "VOTECOUNT" to store the vote count for each candidate

CREATE VIEW VOTECOUNT AS
-- Selecting the necessary columns from the candidate, ecs, election, and evz tables
SELECT
    C.CNATIONALID,
    C.FNAME,
    C.LNAME,
    E.INTERPERIOD,
    E.PERIOD,
    E.PERIODNUM,
    E.TYPE,
    COUNT(EV.NATIONALID) AS TOTAL_VOTES
FROM
    CANDIDATE C
    -- Joining the candidate table with ecs table using the CNATIONALID column
    JOIN ECS ON C.CNATIONALID = ECS.CNATIONALID
    -- Joining the ecs table with election table using the PERIOD and PERIODNUM columns
    JOIN ELECTION E ON ECS.PERIOD = E.PERIOD AND ECS.PERIODNUM = E.PERIODNUM
    -- Left joining the evz table with candidate, election using the VOTE, PERIOD, and PERIODNUM columns
    LEFT JOIN EVZ EV ON C.CNATIONALID = EV.VOTE AND E.PERIOD = EV.PERIOD AND E.PERIODNUM = EV.PERIODNUM
-- Filtering the candidates based on their qualification status
WHERE
    ECS.CQUALIFICATION = TRUE
-- Grouping the results by the selected columns
GROUP BY
    C.CNATIONALID,
    C.FNAME,
    C.LNAME,
    E.INTERPERIOD,
    E.PERIOD,
    E.PERIODNUM,
    E.TYPE;


-- Creating a view named "FUNDINFORMATION" to store fund information for each box

CREATE VIEW FUNDINFORMATION AS
-- Selecting the distinct columns from the box, evz, and election tables
SELECT DISTINCT 
    BOX.BID, 
    BOX.ZID, 
    BOX.RNATIONALID, 
    BOX.RFNAME, 
    BOX.RLNAME, 
    ELECTION.INTERPERIOD, 
    ELECTION.PERIOD, 
    ELECTION.PERIODNUM, 
    ELECTION.TYPE
FROM 
    BOX
    -- Joining the evz table with the box table using the ZID column
    JOIN EVZ ON EVZ.ZID = BOX.ZID
    -- Joining the election table with the evz table using the PERIOD and PERIODNUM columns
    JOIN ELECTION ON ELECTION.PERIOD = EVZ.PERIOD AND ELECTION.PERIODNUM = EVZ.PERIODNUM;


-- Creating a view named "ELECTIONRESULT_A" to store the election results for period names starting with 'a'

CREATE VIEW ELECTIONRESULT_A AS
-- Selecting the necessary columns from the VOTECOUNT view
SELECT vc.CNATIONALID, vc.FNAME, vc.LNAME, vc.INTERPERIOD, vc.PERIOD, vc.PERIODNUM, vc.TYPE, vc.TOTAL_VOTES
FROM VOTECOUNT vc
-- Joining the VOTECOUNT view with a subquery to get the maximum votes for each period and periodnum with the PERIOD starting with 'a'
INNER JOIN (
    SELECT PERIOD, PERIODNUM, MAX(TOTAL_VOTES) AS MAX_VOTES
    FROM VOTECOUNT
    WHERE PERIODNUM LIKE 'a%'
    GROUP BY PERIOD, PERIODNUM
) t ON vc.PERIOD = t.PERIOD AND vc.PERIODNUM = t.PERIODNUM AND vc.TOTAL_VOTES = t.MAX_VOTES;


-- Creating a view named "ELECTIONRESULT" to store the overall election results

CREATE VIEW ELECTIONRESULT AS
-- Selecting the necessary columns from the VOTECOUNT view
SELECT vc.CNATIONALID, vc.FNAME, vc.LNAME, vc.INTERPERIOD, vc.PERIOD, vc.PERIODNUM, vc.TYPE, vc.TOTAL_VOTES
FROM VOTECOUNT vc
-- Joining the VOTECOUNT view with a subquery to get the maximum votes for each period and periodnum
INNER JOIN (
    SELECT PERIOD, PERIODNUM, MAX(TOTAL_VOTES) AS MAX_VOTES
    FROM VOTECOUNT
    GROUP BY PERIOD, PERIODNUM
) t ON vc.PERIOD = t.PERIOD AND vc.PERIODNUM = t.PERIODNUM AND vc.TOTAL_VOTES = t.MAX_VOTES;


-- Creating a view named "VOTERCONTACTINFO" to store the contact information of voters

CREATE VIEW VOTERCONTACTINFO AS
-- Selecting the necessary columns from the vote, evz, ecs, election, and candidate tables
SELECT
    V.NATIONALID,
    V.FNAME AS V_FNAME,
    V.LNAME AS V_LNAME,
    C.CNATIONALID,
    C.FNAME AS C_FNAME,
    C.LNAME AS C_LNAME,
    E.INTERPERIOD,
    E.PERIOD,
    E.PERIODNUM,
    E.TYPE,
    Z.DATE
FROM
    VOTE V
    -- Joining the evz table with the vote table using the NATIONALID column
    JOIN EVZ Z ON V.NATIONALID = Z.NATIONALID
    -- Joining the ecs table with the evz table using the PERIOD, PERIODNUM, and CNATIONALID columns
    JOIN ECS S ON Z.PERIOD = S.PERIOD AND Z.PERIODNUM = S.PERIODNUM AND S.CNATIONALID = Z.VOTE
    -- Joining the election table with the evz table using the PERIOD and PERIODNUM columns
    JOIN ELECTION E ON Z.PERIOD = E.PERIOD AND Z.PERIODNUM = E.PERIODNUM
    -- Joining the candidate table with the evz table using the VOTE column
    JOIN CANDIDATE C ON Z.VOTE = C.CNATIONALID;


