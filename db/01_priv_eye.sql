CREATE DATABASE PrivateEyeDB;

USE PrivateEyeDB;

CREATE TABLE PE_Firm (
    pe_id    int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    pe_name  varchar(50)     NOT NULL,
    pe_state varchar(50)     NOT NULL,
    aum      int             NOT NULL
);

CREATE TABLE Portfolio (
    portfolio_id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    pe_id        int             NOT NULL,
    fund         float           NOT NULL,
    CONSTRAINT fk_1 FOREIGN KEY (pe_id) REFERENCES PE_Firm (pe_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Industry (
    industry_id   int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    size          float         NOT NULL,
    industry_name varchar(1000) NOT NULL
);

CREATE TABLE Ask (
    ask_id     Integer PRIMARY KEY AUTO_INCREMENT NOT NULL,
    ask_range  float   NOT NULL,
    ask_price  float   NOT NULL,
    ask_status boolean NOT NULL
);

CREATE TABLE Company (
    company_id     int PRIMARY KEY  AUTO_INCREMENT  NOT NULL,
    ask_id         int                NOT NULL,
    industry_id    int                NOT NULL,
    portfolio_id   int,
    company_name   varchar(50) UNIQUE NOT NULL,
    company_state  varchar(50)        NOT NULL,
    company_status boolean            NOT NULL,
    CONSTRAINT fk_2 FOREIGN KEY (industry_id) REFERENCES Industry (industry_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_3 FOREIGN KEY (ask_id) REFERENCES Ask (ask_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_x FOREIGN KEY (portfolio_id) REFERENCES Portfolio (portfolio_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Company_Details (
    cd_id      int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    company_id int             NOT NULL,
    margins    float           NOT NULL,
    revenue    int             NOT NULL,
    ceo        varchar(50)     NOT NULL,
    cto        varchar(50)     NOT NULL,
    cio        varchar(50)     NOT NULL,
    CONSTRAINT fk_4 FOREIGN KEY (company_id) REFERENCES Company (company_id) ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE Technician (
    technician_id    int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    technician_last  varchar(50) NOT NULL,
    technician_first varchar(50) NOT NULL
);

CREATE TABLE Deal (
    deal_id         int PRIMARY KEY AUTO_INCREMENT,
    ask_id          int      NOT NULL,
    feasibility     int      NOT NULL,
    top_5           BOOLEAN  NOT NULL,
    deal_status     BOOLEAN  NOT NULL,
    deal_start_date DATETIME NOT NULL,
    approval_date   DATETIME NOT NULL,
    CONSTRAINT fk_5 FOREIGN KEY (ask_id) REFERENCES
        Ask (ask_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT feasibility_check CHECK (feasibility BETWEEN 0 AND 10)
);


CREATE TABLE Bid (
    bid_id     Integer PRIMARY KEY AUTO_INCREMENT,
    pe_id      int     NOT NULL,
    deal_id    int     NOT NULL,
    bid_range  float   NOT NULL,
    bid_price  float   NOT NULL,
    bid_status boolean NOT NULL,
    CONSTRAINT fk_6 FOREIGN KEY (deal_id) REFERENCES
        Deal (deal_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_7 FOREIGN KEY (pe_id) REFERENCES
        PE_Firm (pe_id) ON UPDATE CASCADE ON DELETE CASCADE
);

create table Allows (
    is_visible    boolean NOT NULL,
    company_id    int     NOT NULL,
    technician_id Integer NOT NULL,
    PRIMARY KEY (company_id, technician_id),
    CONSTRAINT fk_8 FOREIGN KEY (company_id) REFERENCES
        Company (company_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_9 FOREIGN KEY (technician_id) REFERENCES
        Technician (technician_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table Reviews (
    company_id    int     NOT NULL,
    technician_id Integer NOT NULL,
    rank_1        varchar(50) UNIQUE,
    rank_2        varchar(50) UNIQUE,
    rank_3        varchar(50) UNIQUE,
    rank_4        varchar(50) UNIQUE,
    rank_5        varchar(50) UNIQUE,
    PRIMARY KEY (company_id, technician_id),
    CONSTRAINT fk_10 FOREIGN KEY (company_id) REFERENCES
        Company (company_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_11 FOREIGN KEY (technician_id) REFERENCES
        Technician (technician_id) ON UPDATE CASCADE ON DELETE CASCADE
);
