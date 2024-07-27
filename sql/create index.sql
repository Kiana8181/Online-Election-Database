-- Create indexes on the CANDIDATE table
CREATE INDEX candidate_fname_index ON candidate (fname);
CREATE INDEX candidate_lname_index ON candidate (lname);

-- Create indexes on the ECS table
CREATE INDEX ecs_cnationalid_index ON ecs (cnationalid);
CREATE INDEX ecs_period_periodnum_index ON ecs (period, periodnum);
CREATE INDEX ecs_sid_snationalid_index ON ecs (sid, snationalid);

-- Create indexes on the PMEMBER table
CREATE INDEX pmember_zid_index ON pmember (zid);
CREATE INDEX pmember_phnumber_index ON pmember (phnumber);

-- Create an index on the BOX table
CREATE INDEX box_zid_index ON box (zid);

-- Create indexes on the SCB table
CREATE INDEX scb_sid_snationalid_index ON scb (sid, snationalid);
CREATE INDEX scb_bid_index ON scb (bid);

-- Create indexes on the EVZ table
CREATE INDEX evz_period_periodnum_index ON evz (period, periodnum);
CREATE INDEX evz_nationalid_index ON evz (nationalid);
CREATE INDEX evz_zid_index ON evz (zid);
CREATE INDEX evz_vote_index ON evz (vote);
