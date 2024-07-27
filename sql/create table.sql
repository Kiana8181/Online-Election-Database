-- Table for storing candidate information
CREATE TABLE CANDIDATE (
    CNATIONALID CHAR(10),        -- Candidate's national ID
    FNAME VARCHAR(50),           -- First name
    LNAME VARCHAR(50),           -- Last name
    BDATE DATE,                  -- Birth date
    CPAPER BOOLEAN,              -- Whether candidate has submitted necessary papers
    PHISTORY VARCHAR(1000),      -- Political history information
    PHNUMBER VARCHAR(20),        -- Phone number
    PRIMARY KEY (CNATIONALID)    -- Primary key constraint
);

-- Table for storing election information
CREATE TABLE ELECTION (
    INTERPERIOD BOOLEAN,         -- Whether it's an intermediate period election
    PERIOD VARCHAR(50),          -- Election period
    PERIODNUM VARCHAR(50),       -- Election period number
    TYPE VARCHAR(50),            -- Type of election
    PRIMARY KEY (PERIOD, PERIODNUM)    -- Primary key constraint
);

-- Table for storing council member information
CREATE TABLE SCOUNCIL (
    SID INT,                     -- Council member's ID
    SNATIONALID CHAR(10),        -- Council member's national ID
    FNAME VARCHAR(50),           -- First name
    LNAME VARCHAR(50),           -- Last name
    TYPE VARCHAR(50),            -- Type of council member
    PRIMARY KEY (SID, SNATIONALID)    -- Primary key constraint
);

-- Table for storing candidate election council information
CREATE TABLE ECS (
    CNATIONALID CHAR(10),        -- Candidate's national ID
    PERIOD VARCHAR(50),          -- Election period
    PERIODNUM VARCHAR(50),       -- Election period number
    SID INT,                     -- Council member's ID
    SNATIONALID CHAR(10),        -- Council member's national ID
    CQUALIFICATION BOOLEAN DEFAULT false,    -- Whether candidate meets qualifications
    PRIMARY KEY (CNATIONALID, PERIOD, PERIODNUM, SID, SNATIONALID),    -- Primary key constraint
    FOREIGN KEY (CNATIONALID) REFERENCES CANDIDATE (CNATIONALID) ON UPDATE CASCADE ON DELETE CASCADE,       -- Foreign key constraints
    FOREIGN KEY (PERIOD, PERIODNUM) REFERENCES ELECTION (PERIOD, PERIODNUM) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (SID, SNATIONALID) REFERENCES SCOUNCIL (SID, SNATIONALID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Table for storing vote information
CREATE TABLE VOTE (
    NATIONALID CHAR(10),         -- Voter's national ID
    FNAME VARCHAR(50),           -- First name
    LNAME VARCHAR(50),           -- Last name
    PRIMARY KEY (NATIONALID)     -- Primary key constraint
);

-- Table for storing zone information
CREATE TABLE ZONE (
    ZID INT,                     -- Zone ID
    PRIMARY KEY (ZID)            -- Primary key constraint
);

-- Table for storing political member information
CREATE TABLE PMEMBER (
    PMNATIONALID CHAR(10),       -- Political member's national ID
    ZID INT,                     -- Zone ID
    FNAME VARCHAR(50),           -- First name
    LNAME VARCHAR(50),           -- Last name
    PHNUMBER VARCHAR(20),        -- Phone number
    PRIMARY KEY (PMNATIONALID),  -- Primary key constraint
    FOREIGN KEY (ZID) REFERENCES ZONE (ZID) ON UPDATE CASCADE ON DELETE CASCADE    -- Foreign key constraint
);

-- Table for storing box information
CREATE TABLE BOX (
    BID INT,                     -- Box ID
    ZID INT,                     -- Zone ID
    RNATIONALID CHAR(10),        -- Responsible person's national ID
    RFNAME VARCHAR(50),          -- Responsible person's first name
    RLNAME VARCHAR(50),          -- Responsible person's last name
    PRIMARY KEY (BID),           -- Primary key constraint
    FOREIGN KEY (ZID) REFERENCES ZONE (ZID) ON UPDATE CASCADE ON DELETE CASCADE    -- Foreign key constraint
);

-- Table for storing council member assigned boxes information
CREATE TABLE SCB (
    SID INT,                     -- Council member's ID
    SNATIONALID CHAR(10),        -- Council member's national ID
    BID INT,                     -- Box ID
    PRIMARY KEY (SID, SNATIONALID, BID),    -- Primary key constraint
    FOREIGN KEY (SID, SNATIONALID) REFERENCES SCOUNCIL (SID, SNATIONALID) ON UPDATE CASCADE ON DELETE CASCADE,    -- Foreign key constraints
    FOREIGN KEY (BID) REFERENCES BOX (BID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Table for storing election voting zone information
CREATE TABLE EVZ (
    PERIOD VARCHAR(50),          -- Election period
    PERIODNUM VARCHAR(50),       -- Election period number
    NATIONALID CHAR(10),         -- Voter's national ID
    ZID INT,                     -- Zone ID
    VOTE CHAR(10),               -- Candidate voted for
    DATE DATE,                   -- Date of voting
    PRIMARY KEY (PERIOD, PERIODNUM, NATIONALID, ZID, VOTE),    -- Primary key constraint
    FOREIGN KEY (PERIOD, PERIODNUM) REFERENCES ELECTION (PERIOD, PERIODNUM) ON UPDATE CASCADE ON DELETE CASCADE,    -- Foreign key constraints
    FOREIGN KEY (NATIONALID) REFERENCES VOTE (NATIONALID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ZID) REFERENCES ZONE (ZID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (VOTE) REFERENCES CANDIDATE (CNATIONALID) ON UPDATE CASCADE ON DELETE CASCADE
);
