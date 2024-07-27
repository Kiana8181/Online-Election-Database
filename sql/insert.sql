-- Inserting candidate data into the CANDIDATE table
INSERT INTO CANDIDATE (CNATIONALID, FNAME, LNAME, BDATE, CPAPER, PHISTORY, PHNUMBER)
VALUES
    ('C1', 'John', 'Doe', '1990-05-10', TRUE, 'Political science graduate', '1234567890'), -- Candidate 1
    ('C2', 'Jane', 'Smith', '1985-12-15', FALSE, 'Business administration degree', '9876543210'), -- Candidate 2
    ('C3', 'Michael', 'Johnson', '1988-08-20', TRUE, 'Human rights activist', '5555555555'), -- Candidate 3
    ('C4', 'Emily', 'Brown', '1992-03-25', FALSE, 'Environmental advocate', '6666666666'), -- Candidate 4
    ('C5', 'Daniel', 'Wilson', '1987-07-05', TRUE, 'Economist', '7777777777'), -- Candidate 5
    ('C6', 'Olivia', 'Anderson', '1991-09-30', FALSE, 'Lawyer', '8888888888'), -- Candidate 6
    ('C7', 'Matthew', 'Taylor', '1989-04-12', TRUE, 'Healthcare professional', '9999999999'), -- Candidate 7
    ('C8', 'Sophia', 'Martin', '1994-01-18', FALSE, 'Computer engineer', '1111111111'), -- Candidate 8
    ('C9', 'Andrew', 'Lee', '1986-06-22', TRUE, 'Educator', '2222222222'), -- Candidate 9
    ('C10', 'Ava', 'Walker', '1993-11-27', FALSE, 'Social worker', '3333333333'); -- Candidate 10

-- Inserting election data into the ELECTION table
INSERT INTO ELECTION (INTERPERIOD, PERIODNUM, PERIOD, TYPE)
VALUES
    (TRUE, 'a2023', '1', 'Riasat Jomhori'), -- Election 1
    (FALSE, 'b2022', '3', 'Majles KHobregan'), -- Election 2
    (TRUE, 'c2024', '2', 'Shoray Eslami'), -- Election 3
    (FALSE, 'd2025', '1', 'Shahr va Rosta'), -- Election 4
    (TRUE, 'a2026', '4', 'Riasat Jomhori'), -- Election 5
    (FALSE, 'b2027', '2', 'Majles KHobregan'), -- Election 6
    (TRUE, 'c2028', '3', 'Shoray Eslami'), -- Election 7
    (FALSE, 'd2029', '2', 'Shahr va Rosta'), -- Election 8
    (TRUE, 'a2030', '2', 'Riasat Jomhori'), -- Election 9
    (TRUE, 'b2031', '1', 'Majles KHobregan'); -- Election 10

-- Inserting council data into the SCOUNCIL table
INSERT INTO SCOUNCIL (SID, SNATIONALID, FNAME, LNAME, TYPE)
VALUES
    (1, 'S1', 'Adam', 'Williams', 'Shorey Negahban'), -- Council member 1
    (2, 'S2', 'Eva', 'Johnson', 'Majless Eslami'), -- Council member 2
    (3, 'S3', 'Liam', 'Davis', 'Shorey Negahban'), -- Council member 3
    (4, 'S4', 'Isabella', 'Anderson', 'Majless Eslami'), -- Council member 4
    (5, 'S5', 'Noah', 'Smith', 'Shorey Negahban'), -- Council member 5
    (6, 'S6', 'Mia', 'Martinez', 'Majless Eslami'), -- Council member 6
    (7, 'S7', 'Lucas', 'Brown', 'Shorey Negahban'), -- Council member 7
    (8, 'S8', 'Aria', 'Garcia', 'Majless Eslami'), -- Council member 8
    (9, 'S9', 'Benjamin', 'Taylor', 'Shorey Negahban'), -- Council member 9
    (10, 'S10', 'Charlotte', 'Lee', 'Majless Eslami'); -- Council member 10

-- Inserting data into the ECS table
INSERT INTO ECS (CNATIONALID, PERIODNUM, PERIOD, SID, SNATIONALID, CQUALIFICATION)
VALUES
    ('C1', 'a2023', '1', 1, 'S1', TRUE), -- Candidate 1 for Election 1, Council member 1
    ('C2', 'a2023', '1', 1, 'S1', TRUE), -- Candidate 2 for Election 1, Council member 1
    ('C2', 'b2022', '3', 2, 'S2', FALSE), -- Candidate 2 for Election 2, Council member 2
    ('C3', 'c2024', '2', 3, 'S3', TRUE), -- Candidate 3 for Election 3, Council member 3
    ('C4', 'd2025', '1', 4, 'S4', FALSE), -- Candidate 4 for Election 4, Council member 4
    ('C5', 'a2026', '4', 5, 'S5', TRUE), -- Candidate 5 for Election 5, Council member 5
    ('C6', 'b2027', '2', 6, 'S6', FALSE), -- Candidate 6 for Election 6, Council member 6
    ('C7', 'c2028', '3', 7, 'S7', TRUE), -- Candidate 7 for Election 7, Council member 7
    ('C8', 'd2029', '2', 8, 'S8', FALSE), -- Candidate 8 for Election 8, Council member 8
    ('C9', 'a2030', '2', 9, 'S9', TRUE), -- Candidate 9 for Election 9, Council member 9
    ('C10', 'b2031', '1', 10, 'S10', FALSE); -- Candidate 10 for Election 10, Council member 10

-- Inserting data into the VOTE table
INSERT INTO VOTE (NATIONALID, FNAME, LNAME)
VALUES
    ('V1', 'Sarah', 'Miller'), -- Voter 1
    ('V2', 'James', 'Wilson'), -- Voter 2
    ('V3', 'Emma', 'Anderson'), -- Voter 3
    ('V4', 'William', 'Thomas'), -- Voter 4
    ('V5', 'Ava', 'Clark'), -- Voter 5
    ('V6', 'Alexander', 'Jackson'), -- Voter 6
    ('V7', 'Sophia', 'White'), -- Voter 7
    ('V8', 'Ethan', 'Taylor'), -- Voter 8
    ('V9', 'Olivia', 'Harris'), -- Voter 9
    ('V10', 'Daniel', 'Moore'); -- Voter 10

-- Inserting data into the ZONE table
INSERT INTO ZONE (ZID)
VALUES
    (1), -- Zone 1
    (2), -- Zone 2
    (3), -- Zone 3
    (4), -- Zone 4
    (5), -- Zone 5
    (6), -- Zone 6
    (7), -- Zone 7
    (8), -- Zone 8
    (9), -- Zone 9
    (10); -- Zone 10

-- Inserting data into the PMEMBER table
INSERT INTO PMEMBER (PMNATIONALID, ZID, FNAME, LNAME, PHNUMBER)
VALUES
    ('P1', 1, 'Liam', 'Brown', '1111111111'), -- Political member 1 in Zone 1
    ('P2', 2, 'Olivia', 'Johnson', '2222222222'), -- Political member 2 in Zone 2
    ('P3', 3, 'Noah', 'Martinez', '3333333333'), -- Political member 3 in Zone 3
    ('P4', 4, 'Emma', 'Davis', '4444444444'), -- Political member 4 in Zone 4
    ('P5', 5, 'Liam', 'Anderson', '5555555555'), -- Political member 5 in Zone 5
    ('P6', 6, 'Ava', 'Wilson', '6666666666'), -- Political member 6 in Zone 6
    ('P7', 7, 'Noah', 'Miller', '7777777777'), -- Political member 7 in Zone 7
    ('P8', 8, 'Emma', 'Jones', '8888888888'), -- Political member 8 in Zone 8
    ('P9', 9, 'Mia', 'Taylor', '9999999999'), -- Political member 9 in Zone 9
    ('P10', 10, 'Ethan', 'Moore', '0000000000'); -- Political member 10 in Zone 10

-- Inserting data into the BOX table
INSERT INTO BOX (BID, ZID, RNATIONALID, RFNAME, RLNAME)
VALUES
    (1, 1, 'R1', 'Emily', 'Davis'), -- Box 1 in Zone 1, Reserved for Election 1
    (2, 2, 'R2', 'Oliver', 'Johnson'), -- Box 2 in Zone 2, Reserved for Election 2
    (3, 3, 'R3', 'Emma', 'Martinez'), -- Box 3 in Zone 3, Reserved for Election 3
    (4, 4, 'R4', 'Liam', 'Wilson'), -- Box 4 in Zone 4, Reserved for Election 4
    (5, 5, 'R5', 'Sophia', 'Anderson'), -- Box 5 in Zone 5, Reserved for Election 5
    (6, 6, 'R6', 'Noah', 'Smith'), -- Box 6 in Zone 6, Reserved for Election 6
    (7, 7, 'R7', 'Isabella', 'Brown'), -- Box 7 in Zone 7, Reserved for Election 7
    (8, 8, 'R8', 'Ava', 'Taylor'), -- Box 8 in Zone 8, Reserved for Election 8
    (9, 9, 'R9', 'Lucas', 'Miller'), -- Box 9 in Zone 9, Reserved for Election 9
    (10, 10, 'R10', 'Mia', 'Thomas'); -- Box 10 in Zone 10, Reserved for Election 10

-- Inserting data into the SCB table
INSERT INTO SCB (SID, SNATIONALID, BID)
VALUES
    (1, 'S1', 1), -- Council member 1 in Box 1
    (2, 'S2', 2), -- Council member 2 in Box 2
    (3, 'S3', 3), -- Council member 3 in Box 3
    (4, 'S4', 4), -- Council member 4 in Box 4
    (5, 'S5', 5), -- Council member 5 in Box 5
    (6, 'S6', 6), -- Council member 6 in Box 6
    (7, 'S7', 7), -- Council member 7 in Box 7
    (8, 'S8', 8), -- Council member 8 in Box 8
    (9, 'S9', 9), -- Council member 9 in Box 9
    (10, 'S10', 10); -- Council member 10 in Box 10

-- Inserting data into the EVZ table
INSERT INTO EVZ (PERIODNUM, PERIOD, NATIONALID, ZID, VOTE, DATE)
VALUES
    ('a2023', '1', 'V1', 1, 'C1', '2023-06-01'), -- Election vote for Voter 1 in Zone 1 for Election 1
    ('a2023', '1', 'V2', 2, 'C1', '2023-06-01'), -- Election vote for Voter 2 in Zone 2 for Election 1
    ('a2023', '1', 'V3', 3, 'C1', '2023-06-01'), -- Election vote for Voter 3 in Zone 3 for Election 1
    ('a2023', '1', 'V4', 4, 'C2', '2023-06-01'), -- Election vote for Voter 4 in Zone 4 for Election 2
    ('b2022', '3', 'V2', 2, 'C2', '2022-09-12'), -- Election vote for Voter 2 in Zone 2 for Election 3
    ('c2024', '2', 'V3', 3, 'C3', '2024-04-25'), -- Election vote for Voter 3 in Zone 3 for Election 2
    ('d2025', '1', 'V4', 4, 'C4', '2025-02-08'), -- Election vote for Voter 4 in Zone 4 for Election 1
    ('a2026', '4', 'V5', 5, 'C5', '2026-11-15'), -- Election vote for Voter 5 in Zone 5 for Election 4
    ('b2027', '2', 'V6', 6, 'C6', '2027-07-23'), -- Election vote for Voter 6 in Zone 6 for Election 2
    ('c2028', '3', 'V7', 7, 'C7', '2028-09-30'), -- Election vote for Voter 7 in Zone 7 for Election 3
    ('d2029', '2', 'V8', 8, 'C8', '2029-03-04'), -- Election vote for Voter 8 in Zone 8 for Election 2
    ('a2030', '2', 'V9', 9, 'C9', '2030-06-19'), -- Election vote for Voter 9 in Zone 9 for Election 2
    ('b2031', '1', 'V10', 10, 'C10', '2031-01-11'), -- Election vote for Voter 10 in Zone 10 for Election 1
    ('a2023', '1', 'V4', 4, 'C3', '2023-06-01'); -- Election vote for Voter 4 in Zone 4 for Election 1 (duplicate entry)
