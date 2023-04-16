CREATE
    DATABASE PrivateEyeDB;

USE
    PrivateEyeDB

CREATE TABLE PE_Firm
(
    pe_id   int PRIMARY KEY NOT NULL,
    pe_name varchar(50)     NOT NULL,
    state   varchar(50)     NOT NULL,
    aum     int             NOT NULL
);

CREATE TABLE Portfolio
(
    portfolio_id int PRIMARY KEY NOT NULL,
    pe_id        int             NOT NULL,
    fund         float           NOT NULL,
    CONSTRAINT fk_1 FOREIGN KEY (pe_id) REFERENCES PE_Firm (pe_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Industry
(
    industry_id   int PRIMARY KEY,
    size          float         NOT NULL,
    industry_name varchar(1000) NOT NULL
);

CREATE TABLE Ask
(
    ask_id     Integer PRIMARY KEY,
    ask_range  float   NOT NULL,
    ask_price  float   NOT NULL,
    ask_status boolean NOT NULL
);

CREATE TABLE Company
(
    company_id     int PRIMARY KEY    NOT NULL,
    ask_id         int                NOT NULL,
    industry_id    int                NOT NULL,
    portfolio_id   int,
    company_name   varchar(50) UNIQUE NOT NULL,
    state          varchar(50)        NOT NULL,
    company_status boolean            NOT NULL,
    CONSTRAINT fk_2 FOREIGN KEY (industry_id) REFERENCES Industry (industry_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_3 FOREIGN KEY (ask_id) REFERENCES Ask (ask_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_x FOREIGN KEY (portfolio_id) REFERENCES Portfolio (portfolio_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Company_Details
(
    cd_id      int PRIMARY KEY NOT NULL,
    company_id int             NOT NULL,
    margins    float           NOT NULL,
    revenue    int             NOT NULL,
    ceo        varchar(50)     NOT NULL,
    cto        varchar(50)     NOT NULL,
    cio        varchar(50)     NOT NULL,
    CONSTRAINT fk_4 FOREIGN KEY (company_id) REFERENCES Company (company_id) ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE Technician
(
    technician_id    int PRIMARY KEY,
    technician_last  varchar(50) NOT NULL,
    technician_first varchar(50) NOT NULL
);

CREATE TABLE Deal
(
    deal_id       int PRIMARY KEY,
    ask_id        int      NOT NULL,
    feasibility   int      NOT NULL,
    top_5         BOOLEAN  NOT NULL,
    deal_status   BOOLEAN  NOT NULL,
    start_date    DATETIME NOT NULL,
    approval_date DATETIME NOT NULL,
    CONSTRAINT fk_5 FOREIGN KEY (ask_id) REFERENCES
        Ask (ask_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT feasibility_check CHECK (feasibility BETWEEN 0 AND 10)
);


CREATE TABLE Bid
(
    bid_id     Integer PRIMARY KEY,
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

create table Allows
(
    is_visible    boolean NOT NULL,
    company_id    int     NOT NULL,
    technician_id Integer NOT NULL,
    PRIMARY KEY (company_id, technician_id),
    CONSTRAINT fk_8 FOREIGN KEY (company_id) REFERENCES
        Company (company_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_9 FOREIGN KEY (technician_id) REFERENCES
        Technician (technician_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

create table Reviews
(
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

INSERT INTO PE_Firm
VALUES (1, 'Haley Inc', 'Texas', '6888423.31'),
       (2, 'Bauch, Koss and Ritchie', 'Ohio', '7961535.54'),
       (3, 'Stoltenberg-Ernser', 'Ohio', '7639082.71'),
       (4, 'Wisoky Inc', 'Virginia', '2719499.87'),
       (5, 'Leuschke and Sons', 'Mississippi', '4410140.12'),
       (6, 'Green, Marquardt and Balistreri', 'Florida', '4161186.1'),
       (7, 'Murazik LLC', 'Virginia', '3892279.33'),
       (8, 'Johnson LLC', 'Virginia', '8595553.15'),
       (9, 'Huel-Hessel', 'Texas', '7051891.52'),
       (10, 'Hodkiewicz Inc', 'Missouri', '3202273.73'),
       (11, 'DuBuque, Dickinson and Jaskolski', 'Georgia', '8200704.68'),
       (12, 'Kiehn Group', 'California', '7684856.21'),
       (13, 'Smith, O''Hara and Fritsch', 'Indiana', '4140342.09'),
       (14, 'Toy Group', 'Nevada', '8529669.41'),
       (15, 'Homenick-Jerde', 'Florida', '9876080.99'),
       (16, 'Murray Group', 'Iowa', '7007702.92'),
       (17, 'Jaskolski and Sons', 'California', '4363940.13'),
       (18, 'Auer and Sons', 'Texas', '5573170.64'),
       (19, 'Ward, Mayert and Lowe', 'North Carolina', '2628143.91'),
       (20, 'Greenholt-Corkery', 'Kentucky', '8882827.46'),
       (21, 'Schulist LLC', 'California', '3697788.54'),
       (22, 'Windler-Mayer', 'North Carolina', '7765478.0'),
       (23, 'Schowalter, Boyle and Wiza', 'California', '1088966.86'),
       (24, 'Dibbert-Jast', 'New York', '9413596.94'),
       (25, 'Weimann Group', 'Florida', '8177576.62'),
       (26, 'Fisher, Hackett and Lynch', 'Minnesota', '6672718.17'),
       (27, 'Kozey Group', 'North Dakota', '2451934.69'),
       (28, 'Haley Inc', 'North Carolina', '5091157.47'),
       (29, 'Hirthe and Sons', 'Florida', '7658860.68'),
       (30, 'Marquardt-Rath', 'California', '7551886.82'),
       (31, 'Lockman, Jakubowski and Schneider', 'Ohio', '8281230.33'),
       (32, 'Becker-Quitzon', 'Indiana', '9633939.81'),
       (33, 'DuBuque-Turcotte', 'New York', '3913648.55'),
       (34, 'Stroman, Goldner and Collins', 'New York', '6917851.71'),
       (35, 'Barton, Jacobs and Heaney', 'Alaska', '7980231.09'),
       (36, 'Mann Inc', 'Michigan', '6342734.89'),
       (37, 'Connelly-Howell', 'California', '7569885.62'),
       (38, 'Paucek and Sons', 'Illinois', '6080056.03'),
       (39, 'Bode and Sons', 'California', '7959692.87'),
       (40, 'Lowe Group', 'Louisiana', '9880411.11'),
       (41, 'Grant LLC', 'North Carolina', '3113591.09'),
       (42, 'Marvin, Heidenreich and Runte', 'Florida', '5176442.87'),
       (43, 'Franecki, Treutel and Gislason', 'Texas', '5944757.38'),
       (44, 'Bernier, Ondricka and Johnson', 'Florida', '1551925.26'),
       (45, 'Zemlak Inc', 'California', '5611894.15'),
       (46, 'Cormier LLC', 'Tennessee', '4862007.81'),
       (47, 'Greenfelder and Sons', 'Massachusetts', '9768148.99'),
       (48, 'Pouros, Spencer and Ratke', 'California', '4371984.26'),
       (49, 'Leffler, Schultz and Harris', 'California', '2214874.35'),
       (50, 'McLaughlin-Lehner', 'Minnesota', '8019925.07'),
       (51, 'Bergstrom-Ryan', 'California', '8224713.06'),
       (52, 'Goldner Inc', 'Washington', '2947771.0'),
       (53, 'Stroman and Sons', 'New York', '9840454.37'),
       (54, 'Nikolaus, Bins and Franecki', 'Missouri', '3598672.66'),
       (55, 'Corkery Group', 'Massachusetts', '9944055.2'),
       (56, 'Runolfsson and Sons', 'District of Columbia', '7698690.68'),
       (57, 'Gleason Group', 'Connecticut', '7010417.02'),
       (58, 'Kozey, Tillman and Kerluke', 'Texas', '9839905.57'),
       (59, 'Will-Okuneva', 'Utah', '4007736.93'),
       (60, 'O''Hara Group', 'New York', '2289748.0'),
       (61, 'Kulas Group', 'Pennsylvania', '9098541.57'),
       (62, 'Larson, Shields and Hackett', 'Texas', '3015206.56'),
       (63, 'Keebler, Sporer and Douglas', 'Ohio', '4272476.6'),
       (64, 'Gutkowski, Hilpert and Heller', 'Texas', '1177959.92'),
       (65, 'Dare-Waters', 'New York', '2975497.94'),
       (66, 'Collier, Hammes and Kerluke', 'Massachusetts', '5343172.81'),
       (67, 'Mante, Stoltenberg and Mann', 'Utah', '3518818.7'),
       (68, 'Stokes-Johns', 'Arizona', '6612303.94'),
       (69, 'Franecki-Dickinson', 'West Virginia', '2851929.01'),
       (70, 'Harvey-Wuckert', 'North Dakota', '8424376.79'),
       (71, 'Ledner Group', 'Florida', '4455546.02'),
       (72, 'Beier-Sporer', 'California', '9882193.96'),
       (73, 'Blanda, Stamm and Spencer', 'Indiana', '7187664.2'),
       (74, 'Kub, Bruen and Steuber', 'Florida', '5817294.94'),
       (75, 'Mraz, Jacobi and Hauck', 'Texas', '6961155.14'),
       (76, 'Dibbert LLC', 'Georgia', '7675701.71'),
       (77, 'Swaniawski-Schoen', 'Virginia', '8488521.1'),
       (78, 'Schaden, Fadel and Kozey', 'West Virginia', '3696973.0'),
       (79, 'Goodwin-Lemke', 'Colorado', '7295796.09'),
       (80, 'O''Keefe Group', 'Georgia', '9919659.39'),
       (81, 'Gusikowski Group', 'New York', '8544190.7'),
       (82, 'Rice-Strosin', 'Texas', '2418658.79'),
       (83, 'Corkery, O''Kon and Wiza', 'Arizona', '7174519.24'),
       (84, 'Turcotte-Rempel', 'Minnesota', '2060669.19'),
       (85, 'Brakus and Sons', 'Florida', '2091438.56'),
       (86, 'Botsford LLC', 'Mississippi', '2621278.17'),
       (87, 'Kovacek-Gleason', 'Iowa', '8492444.61'),
       (88, 'Wuckert-Moen', 'New York', '5121237.14'),
       (89, 'Sanford Group', 'Montana', '1182527.05'),
       (90, 'Wintheiser Group', 'Ohio', '7837285.99'),
       (91, 'Murazik, Harris and Mitchell', 'California', '8686913.34'),
       (92, 'Blick, Koss and Kertzmann', 'New York', '5559176.63'),
       (93, 'Kreiger-Shields', 'New Mexico', '8993529.17'),
       (94, 'Kub-Donnelly', 'Iowa', '4223266.71'),
       (95, 'Walker and Sons', 'West Virginia', '7314909.51'),
       (96, 'Osinski and Sons', 'Ohio', '7302148.24'),
       (97, 'Kertzmann, Jacobi and Lynch', 'Kentucky', '8875273.76'),
       (98, 'Schamberger, Johnson and Metz', 'Arizona', '3014360.97'),
       (99, 'Bins-Hermann', 'Virginia', '9278790.78'),
       (100, 'Douglas-Rosenbaum', 'Oklahoma', '1688192.07');


INSERT INTO `Industry`
VALUES (1, 260862, 'Business Services'),
       (2, 409462, 'Business Services'),
       (3, 445890, 'Hotels/Resorts'),
       (4, 749296, 'n/a'),
       (5, 152198, 'Clothing/Shoe/Accessory Stores'),
       (6, 270919, 'Major Banks'),
       (7, 434282, 'n/a'),
       (8, 898988, 'Electric Utilities: Central'),
       (9, 571855, 'Medical Specialities'),
       (10, 447954, 'Investment Managers'),
       (11, 194355, 'Computer Communications Equipment'),
       (12, 287019, 'Biotechnology'),
       (13, 639307, 'Environmental Services'),
       (14, 165251, 'Water Supply'),
       (15, 562435, 'n/a'),
       (16, 530431, 'Computer Software: Prepackaged Software'),
       (17, 621229, 'Marine Transportation'),
       (18, 596652, 'Professional Services'),
       (19, 969116, 'n/a'),
       (20, 683252, 'Auto Parts:O.E.M.'),
       (21, 999475, 'Water Supply'),
       (22, 683902, 'Auto Parts:O.E.M.'),
       (23, 529587, 'n/a'),
       (24, 657683, 'Property-Casualty Insurers'),
       (25, 775663, 'Semiconductors'),
       (26, 528236, 'n/a'),
       (27, 498480, 'Building Materials'),
       (28, 512280, 'Oil & Gas Production'),
       (29, 923181, 'Real Estate Investment Trusts'),
       (30, 327516, 'Major Pharmaceuticals'),
       (31, 485054, 'Major Banks'),
       (32, 119450, 'Home Furnishings'),
       (33, 993488, 'Electronics Distribution'),
       (34, 236226, 'Investment Bankers/Brokers/Service'),
       (35, 708049, 'Beverages (Production/Distribution)'),
       (36, 964993, 'Professional Services'),
       (37, 584436, 'Major Banks'),
       (38, 311798, 'Business Services'),
       (39, 828168, 'Oil Refining/Marketing'),
       (40, 367437, 'Commercial Banks'),
       (41, 304468, 'Major Chemicals'),
       (42, 241145, 'Home Furnishings'),
       (43, 719744, 'Major Banks'),
       (44, 467822, 'n/a'),
       (45, 886332, 'Business Services'),
       (46, 942653, 'Life Insurance'),
       (47, 693918, 'n/a'),
       (48, 290775, 'Food Chains'),
       (49, 586157, 'Real Estate Investment Trusts'),
       (50, 580095, 'Food Distributors'),
       (51, 320368, 'Biotechnology'),
       (52, 297759, 'Industrial Machinery/Components'),
       (53, 887470, 'Agricultural Chemicals'),
       (54, 680443, 'Military/Government/Technical'),
       (55, 542645, 'Major Banks'),
       (56, 742447, 'Containers/Packaging'),
       (57, 264722, 'Department/Specialty Retail Stores'),
       (58, 224445, 'Power Generation'),
       (59, 407009, 'Recreational Products/Toys'),
       (60, 995274, 'Major Pharmaceuticals'),
       (61, 708439, 'Savings Institutions'),
       (62, 110092, 'Electric Utilities: Central'),
       (63, 493474, 'Real Estate Investment Trusts'),
       (64, 821265, 'Property-Casualty Insurers'),
       (65, 760568, 'Computer Software: Prepackaged Software'),
       (66, 463553, 'Telecommunications Equipment'),
       (67, 743283, 'Air Freight/Delivery Services'),
       (68, 755126, 'Metal Fabrications'),
       (69, 385843, 'n/a'),
       (70, 289237, 'Major Banks'),
       (71, 326644, 'Major Banks'),
       (72, 425757, 'Industrial Machinery/Components'),
       (73, 387893, 'Homebuilding'),
       (74, 611334, 'Integrated oil Companies'),
       (75, 797050, 'EDP Services'),
       (76, 959930, 'Miscellaneous manufacturing industries'),
       (77, 294824, 'Telecommunications Equipment'),
       (78, 291059, 'Industrial Machinery/Components'),
       (79, 169024, 'Semiconductors'),
       (80, 839748, 'Major Pharmaceuticals'),
       (81, 178352, 'n/a'),
       (82, 731874, 'n/a'),
       (83, 679576, 'n/a'),
       (84, 820117, 'Marine Transportation'),
       (85, 693528, 'EDP Services'),
       (86, 588295, 'Major Banks'),
       (87, 832923, 'Containers/Packaging'),
       (88, 819580, 'n/a'),
       (89, 122823, 'Business Services'),
       (90, 520439, 'n/a'),
       (91, 253764, 'Telecommunications Equipment'),
       (92, 130902, 'n/a'),
       (93, 749454, 'Computer Software: Programming, Data Processing'),
       (94, 988977, 'Biotechnology'),
       (95, 435165, 'Oil Refining/Marketing'),
       (96, 470872, 'n/a'),
       (97, 502517, 'Major Pharmaceuticals'),
       (98, 469717, 'n/a'),
       (99, 678088, 'RETAIL: Building Materials'),
       (100, 186275, 'Computer peripheral equipment');


INSERT INTO `Portfolio`
VALUES (1, 40, '2520529049.82'),
       (2, 19, '164234434.78'),
       (3, 66, '2310624283.76'),
       (4, 94, '3073806713.59'),
       (5, 53, '2979354219.62'),
       (6, 59, '1024133165.87'),
       (7, 1, '786318682.86'),
       (8, 97, '801730424.41'),
       (9, 100, '2559105234.36'),
       (10, 73, '2968405815.85'),
       (11, 30, '3977817962.74'),
       (12, 40, '3557756518.68'),
       (13, 18, '1646039489.65'),
       (14, 24, '3927336787.11'),
       (15, 60, '2708771655.46'),
       (16, 15, '1153720246.52'),
       (17, 90, '575831144.82'),
       (18, 44, '2347330665.7'),
       (19, 67, '4298845104.84'),
       (20, 65, '2545835306.75'),
       (21, 44, '1689479221.93'),
       (22, 29, '4887843392.23'),
       (23, 20, '2142770632.3'),
       (24, 33, '1887225952.77'),
       (25, 70, '1531186394.2'),
       (26, 78, '735457098.52'),
       (27, 54, '154318908.04'),
       (28, 96, '2404631946.95'),
       (29, 75, '860932139.02'),
       (30, 76, '3551061904.13'),
       (31, 81, '4945424307.09'),
       (32, 36, '3116005699.79'),
       (33, 74, '4226352033.83'),
       (34, 91, '441487711.59'),
       (35, 9, '4016100009.14'),
       (36, 29, '2495681979.67'),
       (37, 36, '1112372759.62'),
       (38, 52, '2842454059.79'),
       (39, 88, '3870538355.3'),
       (40, 81, '351715390.72'),
       (41, 31, '4476400875.3'),
       (42, 71, '4570444504.75'),
       (43, 95, '761399774.54'),
       (44, 13, '1664001544.77'),
       (45, 33, '1432115254.9'),
       (46, 57, '1632694614.87'),
       (47, 46, '2074667675.86'),
       (48, 31, '2644488009.56'),
       (49, 11, '2868127399.27'),
       (50, 9, '1473126892.98'),
       (51, 19, '2109294687.12'),
       (52, 42, '1939584022.35'),
       (53, 39, '839181013.27'),
       (54, 54, '3278335678.75'),
       (55, 96, '840480213.46'),
       (56, 85, '1802958102.25'),
       (57, 11, '970933536.38'),
       (58, 66, '1878903575.85'),
       (59, 27, '1017384725.33'),
       (60, 5, '2921251995.31'),
       (61, 57, '1958497117.93'),
       (62, 65, '4534827184.51'),
       (63, 49, '4386802251.9'),
       (64, 59, '3469785150.7'),
       (65, 40, '3577237271.98'),
       (66, 97, '928330570.82'),
       (67, 38, '360106812.32'),
       (68, 61, '1795487529.07'),
       (69, 35, '1973257357.87'),
       (70, 68, '3108175301.68'),
       (71, 91, '3599563796.86'),
       (72, 79, '4189916322.01'),
       (73, 67, '2981038086.21'),
       (74, 75, '3829884864.32'),
       (75, 50, '806493988.05'),
       (76, 99, '4458542238.66'),
       (77, 5, '605012020.79'),
       (78, 46, '1376193638.02'),
       (79, 95, '4632685044.02'),
       (80, 32, '4937183126.63'),
       (81, 59, '522087517.5'),
       (82, 95, '4653897407.72'),
       (83, 64, '3322954896.8'),
       (84, 97, '485074682.47'),
       (85, 11, '395610458.48'),
       (86, 57, '4179942194.46'),
       (87, 30, '748568140.07'),
       (88, 12, '422102788.83'),
       (89, 67, '1997396530.16'),
       (90, 90, '1264214708.89'),
       (91, 84, '1834792784.98'),
       (92, 2, '3619243767.56'),
       (93, 19, '147202963.8'),
       (94, 82, '4208650014.22'),
       (95, 42, '2486404368.0'),
       (96, 72, '422304448.3'),
       (97, 19, '1892510241.03'),
       (98, 22, '259996182.74'),
       (99, 10, '1562233512.18'),
       (100, 81, '1123457982.2');


INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (1, 0.68, 45502960, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (2, 0.44, 65650614, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (3, 0.08, 33596772, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (4, 0.44, 24907131, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (5, 0.67, 49154503, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (6, 0.86, 13823178, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (7, 0.17, 7907360, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (8, 0.62, 10888513, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (9, 0.07, 93233676, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (10, 0.79, 71061107, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (11, 0.91, 26301320, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (12, 0.09, 95577073, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (13, 0.93, 21192709, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (14, 0.54, 46707834, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (15, 0.09, 67020983, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (16, 0.03, 31816502, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (17, 0.53, 61891071, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (18, 0.43, 16917923, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (19, 0.32, 51902164, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (20, 0.36, 21149972, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (21, 0.08, 17741556, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (22, 0.82, 86007144, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (23, 0.33, 21738077, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (24, 0.01, 4200982, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (25, 0.19, 46697442, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (26, 0.25, 33498559, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (27, 0.52, 92060399, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (28, 0.01, 6549544, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (29, 0.42, 98928884, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (30, 0.9, 23017683, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (31, 0.16, 18658291, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (32, 0.46, 73051653, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (33, 0.4, 13213623, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (34, 0.77, 40193811, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (35, 0.19, 13160409, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (36, 0.03, 21850322, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (37, 0.13, 21613995, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (38, 0.63, 84397004, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (39, 0.3, 25501621, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (40, 0.67, 91583145, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (41, 0.58, 61630298, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (42, 0.47, 25254995, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (43, 0.16, 81009151, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (44, 0.96, 39292019, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (45, 0.2, 28012699, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (46, 0.51, 47256856, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (47, 0.4, 15256504, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (48, 0.95, 37348553, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (49, 0.45, 4873918, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (50, 0.32, 92039627, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (51, 0.26, 52551363, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (52, 0.93, 59002675, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (53, 0.7, 58727673, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (54, 0.18, 10599299, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (55, 0.12, 89392471, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (56, 0.26, 55096175, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (57, 0.05, 17785080, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (58, 0.38, 51222875, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (59, 0.82, 70279206, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (60, 0.3, 87019476, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (61, 0.84, 22603045, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (62, 0.79, 28824126, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (63, 0.66, 64368708, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (64, 0.72, 84567106, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (65, 0.72, 47714364, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (66, 0.41, 15900252, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (67, 0.5, 65298363, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (68, 0.7, 56223053, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (69, 0.36, 33608345, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (70, 0.04, 49073207, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (71, 0.06, 80099383, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (72, 0.68, 65886084, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (73, 0.75, 89721882, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (74, 0.91, 36485985, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (75, 0.29, 82113072, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (76, 0.05, 11705853, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (77, 0.7, 64396770, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (78, 0.49, 17090403, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (79, 0.11, 71064415, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (80, 0.99, 3638298, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (81, 0.43, 41378894, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (82, 0.18, 71325846, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (83, 0.33, 42405506, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (84, 0.87, 83413975, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (85, 0.92, 71712005, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (86, 0.18, 13352944, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (87, 0.24, 14366690, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (88, 0.31, 31661267, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (89, 0.81, 77433153, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (90, 0.59, 41047980, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (91, 0.39, 90241033, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (92, 0.69, 46118714, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (93, 0.02, 10203633, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (94, 0.15, 25935850, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (95, 0.74, 74346788, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (96, 0.59, 81250351, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (97, 0.27, 36296175, false);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (98, 0.34, 72270494, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (99, 0.03, 25080571, true);
INSERT INTO Ask(ask_id, ask_range, ask_price, ask_status)
VALUES (100, 0.32, 19539238, true);

INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (1, 29, 47, 89, 'Dicki-Kessler', 'Florida', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (2, 27, 5, 42, 'Schowalter, Ritchie and Cummings', 'Indiana', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (3, 76, 46, 92, 'White, Yost and Howell', 'Georgia', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (4, 63, 86, 70, 'Abernathy-Nitzsche', 'Florida', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (5, 6, 49, 82, 'Cartwright-Kulas', 'California', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (6, 43, 90, 16, 'Krajcik and Sons', 'Arizona', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (7, 99, 48, 9, 'Brekke-Bernier', 'California', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (8, 41, 41, 17, 'Konopelski Group', 'Maryland', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (9, 46, 82, 20, 'Crist-Jast', 'Wisconsin', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (10, 15, 78, 30, 'Rippin LLC', 'California', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (11, 22, 35, 43, 'Reilly-Heathcote', 'Washington', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (12, 1, 75, 25, 'Kemmer-Bartell', 'Nevada', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (13, 51, 27, 1, 'Torphy Inc', 'California', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (14, 75, 9, 63, 'Botsford-Renner', 'Texas', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (15, 97, 72, 8, 'Adams and Sons', 'California', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (16, 10, 43, 84, 'Lind-Wiza', 'Maryland', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (17, 88, 20, 23, 'Medhurst, Marks and Olson', 'California', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (18, 91, 62, 16, 'Hoppe-Huel', 'Florida', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (19, 69, 6, 24, 'Schamberger Group', 'Massachusetts', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (20, 93, 88, 40, 'Carroll Group', 'Indiana', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (21, 87, 12, 60, 'Zboncak, Littel and Homenick', 'Tennessee', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (22, 18, 71, 95, 'Bogan, Herzog and Turcotte', 'North Carolina', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (23, 31, 35, 12, 'Paucek, Anderson and O''Reilly', 'Virginia', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (24, 92, 52, 41, 'Hyatt Inc', 'South Carolina', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (25, 27, 95, 15, 'Berge-Dietrich', 'Pennsylvania', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (26, 48, 16, 56, 'Rohan Inc', 'Hawaii', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (27, 13, 79, 80, 'Schmitt Inc', 'Texas', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (28, 53, 85, 87, 'Rosenbaum and Sons', 'Florida', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (29, 98, 62, 19, 'Kihn and Sons', 'Alaska', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (30, 51, 11, 8, 'Pfeffer, Kassulke and Turner', 'Ohio', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (31, 86, 29, 30, 'Auer Group', 'Florida', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (32, 50, 44, 34, 'Bergnaum, Turcotte and Towne', 'Alabama', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (33, 97, 38, 81, 'McCullough, Fisher and Dare', 'Indiana', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (34, 47, 62, 46, 'Doyle Group', 'North Carolina', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (35, 92, 84, 24, 'Steuber and Sons', 'Arizona', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (36, 49, 92, 8, 'Franecki LLC', 'Missouri', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (37, 11, 85, 96, 'Hoeger-Runolfsson', 'California', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (38, 62, 8, 21, 'Blick-Schultz', 'Louisiana', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (39, 71, 35, 35, 'King, Schiller and Dach', 'New York', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (40, 2, 57, 40, 'Upton LLC', 'California', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (41, 29, 49, 39, 'Hyatt, Zieme and Romaguera', 'Florida', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (42, 10, 98, 37, 'Kuhlman LLC', 'Virginia', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (43, 16, 13, 73, 'Terry Inc', 'Florida', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (44, 5, 96, 11, 'Monahan LLC', 'District of Columbia', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (45, 7, 81, 18, 'Walsh LLC', 'Michigan', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (46, 12, 31, 62, 'Mann-Konopelski', 'District of Columbia', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (47, 13, 11, 47, 'Schneider-Simonis', 'California', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (48, 64, 79, 20, 'Homenick, Bednar and Kutch', 'New York', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (49, 79, 50, 42, 'Mitchell Inc', 'Michigan', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (50, 30, 14, 93, 'Bogan and Sons', 'Virginia', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (51, 99, 39, 18, 'Miller and Sons', 'Maryland', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (52, 74, 99, 94, 'Rempel Inc', 'Washington', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (53, 38, 95, 70, 'Konopelski-Spencer', 'Alabama', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (54, 50, 38, 28, 'Krajcik Inc', 'California', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (55, 15, 47, 25, 'Conn, Luettgen and Lang', 'California', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (56, 70, 76, 28, 'Rohan-Beatty', 'Texas', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (57, 53, 43, 57, 'Maggio-Gibson', 'California', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (58, 46, 15, 97, 'Welch, Hagenes and Prosacco', 'Nevada', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (59, 13, 59, 85, 'Hilpert-Moore', 'Arizona', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (60, 41, 90, 16, 'Hahn, Torphy and O''Connell', 'North Carolina', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (61, 31, 36, 17, 'Haag and Sons', 'Washington', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (62, 12, 46, 3, 'Dach, Barrows and Grimes', 'Florida', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (63, 85, 7, 12, 'Ruecker-Ebert', 'California', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (64, 37, 69, 80, 'Homenick-Torp', 'California', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (65, 6, 10, 49, 'Barrows LLC', 'California', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (66, 32, 84, 18, 'Buckridge LLC', 'Florida', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (67, 80, 49, 28, 'Reynolds-Herzog', 'California', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (68, 50, 39, 73, 'Roberts-Weissnat', 'Florida', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (69, 11, 17, 23, 'Waters, Witting and Thompson', 'Virginia', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (70, 63, 21, 42, 'Bergstrom-Zieme', 'California', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (71, 97, 22, 72, 'Zemlak and Sons', 'Virginia', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (72, 62, 40, 39, 'Gutmann-Kulas', 'Georgia', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (73, 11, 20, 61, 'Mertz-Wolf', 'Massachusetts', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (74, 39, 62, 63, 'Hickle, Hackett and Bosco', 'North Carolina', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (75, 84, 55, 80, 'Glover-Leuschke', 'Louisiana', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (76, 70, 43, 42, 'Connelly Group', 'Florida', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (77, 75, 82, 80, 'Deckow, Parisian and Schaefer', 'Illinois', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (78, 51, 74, 91, 'Romaguera-Jakubowski', 'Connecticut', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (79, 50, 14, 54, 'Torp LLC', 'Washington', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (80, 71, 57, 85, 'Goldner-Maggio', 'Massachusetts', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (81, 21, 64, 24, 'Heathcote-Tromp', 'South Carolina', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (82, 17, 50, 12, 'Bartell Group', 'Pennsylvania', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (83, 83, 53, 51, 'Kling-Shanahan', 'California', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (84, 84, 84, 2, 'Heller Inc', 'Connecticut', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (85, 66, 15, 63, 'Predovic, Bosco and Torp', 'New York', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (86, 5, 25, 25, 'Mayer, Windler and Schiller', 'Alabama', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (87, 50, 89, 52, 'Kohler, Wiegand and Metz', 'Kansas', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (88, 72, 73, 97, 'Ullrich and Sons', 'California', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (89, 22, 100, 75, 'Dicki-Wilkinson', 'Washington', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (90, 17, 84, 92, 'Morar Inc', 'New York', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (91, 11, 93, 35, 'Lakin-Romaguera', 'Alabama', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (92, 94, 30, 20, 'Hilll, Jacobson and Boyer', 'Texas', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (93, 27, 89, 88, 'Jacobi, Hagenes and Hagenes', 'Florida', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (94, 37, 65, 4, 'Gleason Inc', 'Ohio', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (95, 8, 46, 99, 'Beatty-Walsh', 'New York', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (96, 52, 91, 45, 'Klein-Schuster', 'Florida', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (97, 89, 52, 94, 'Denesik Inc', 'California', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (98, 50, 88, 58, 'Morar LLC', 'Nevada', true);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (99, 87, 85, 83, 'Bins, Olson and Ziemann', 'Georgia', false);
INSERT INTO Company(company_id, ask_id, industry_id, portfolio_id, company_name, state, company_status)
VALUES (100, 99, 22, 100, 'Hudson-Lowe', 'Florida', false);



INSERT INTO `Company_Details`
VALUES (1, 88, '46.55', 149250384, 'Udall Quimby', 'Malena Osinin', 'Carlynn Bigrigg'),

       (2, 43, '36.42', 587588153, 'Madelin Ost', 'Arleta Houseman', 'Helene Mayston'),
       (3, 31, '44.76', 193592580, 'Debbie Gaspard', 'Hildegarde O''Farrell', 'Cleve Venners'),
       (4, 94, '32.25', 167575679, 'Sally Middle', 'Jacintha Petters', 'Bernie Milby'),
       (5, 37, '85.72', 251420102, 'Serena Jorger', 'Bartram Bartram', 'Jyoti Jeens'),
       (6, 54, '42.12', 651506639, 'Idette Navan', 'Alison Hawney', 'Astra Hambleton'),
       (7, 67, '25.43', 278521797, 'Cammie Thying', 'Jeni Kestin', 'Tami Brandham'),
       (8, 15, '50.92', 615762458, 'Gleda McKeady', 'Minda Lineen', 'Virginia Killshaw'),
       (9, 97, '24.9', 819851879, 'Merrilee Dummett', 'Spike Juggings', 'Erna Olivia'),
       (10, 68, '42.45', 376278504, 'Candis Dummett', 'Sonny Blakeney', 'Beatrice Duferie'),
       (11, 12, '82.72', 665123006, 'Robbyn McKim', 'Barrie Kohring', 'Franz Marousek'),
       (12, 56, '62.33', 484455070, 'Arlen Tomasz', 'Melitta Furmonger', 'Ana Batters'),
       (13, 97, '76.93', 425364200, 'Mona Blaker', 'Conney Lomb', 'Elsy Raff'),
       (14, 10, '67.6', 474616044, 'Sophronia Clayson', 'Bryana Christley', 'Robbert Jesson'),
       (15, 3, '95.62', 976068259, 'Brandea Gilberthorpe', 'Jayme Castaneda', 'Davie Westgate'),
       (16, 91, '48.21', 346922575, 'Devonne Nevet', 'Wanda Gritten', 'Townie Blondell'),
       (17, 74, '34.07', 545153531, 'Les Bontoft', 'Minta Makiver', 'Maisie Geaveny'),
       (18, 62, '5.44', 534160868, 'Meara Lethlay', 'Calypso Rhule', 'Stinky Dominelli'),
       (19, 12, '85.22', 855986274, 'Caty Davidsen', 'Olympia Samples', 'Lamond Hammarberg'),
       (20, 11, '3.06', 171759317, 'Sylvester Fullick', 'Janeta Lympany', 'Renelle Robeson'),
       (21, 60, '20.11', 275827543, 'Rog Januszkiewicz', 'Zondra Bentje', 'Huntley Hunston'),
       (22, 87, '37.43', 890956911, 'Marylynne Hindrick', 'Branden Habron', 'Clemmie Tugman'),
       (23, 34, '49.7', 163915682, 'Mendel Alkins', 'Gilli Rivard', 'Agathe Terrett'),
       (24, 98, '69.75', 751033130, 'Isaak Furmenger', 'Tye Elflain', 'Jelene Bog'),
       (25, 53, '54.46', 393642476, 'Cami Slesser', 'Teresina Scrauniage', 'Chen Syalvester'),
       (26, 44, '69.1', 193706202, 'Ashil Whitney', 'Taylor Tackes', 'Rosalinde Basso'),
       (27, 21, '13.91', 15544952, 'Tobi Adshede', 'Stormy Ventam', 'Ernestine Kinnen'),
       (28, 72, '61.65', 2973164, 'Osbourne Topaz', 'Lance Fullbrook', 'Ebeneser MacCoveney'),
       (29, 59, '38.94', 1727137, 'Tania Pettie', 'Lavena Pavlitschek', 'Godwin Marie'),
       (30, 40, '13.95', 506093183, 'Davidson Summerson', 'Avril Tongue', 'Noland Pashby'),
       (31, 29, '86.02', 844893981, 'Cami Riddett', 'Marybeth Lutman', 'Eunice Olle'),
       (32, 73, '75.56', 818710127, 'Terese Pickover', 'Dyanna Aronson', 'Annice Fearick'),
       (33, 83, '45.91', 127409422, 'Krystalle Looby', 'Pip Cobain', 'Drusy Meace'),
       (34, 76, '33.95', 123411380, 'Matty Dartnell', 'Nixie Duffree', 'Esdras Olenchenko'),
       (35, 85, '93.38', 990330400, 'Patty Satyford', 'Happy Dryden', 'Roby Cobello'),
       (36, 18, '31.03', 270255141, 'Wake Washbrook', 'Donnie Colclough', 'Violante Ruxton'),
       (37, 97, '77.29', 22578226, 'Nadine Montgomery', 'Kenny McCawley', 'Teresita Rostron'),
       (38, 80, '33.87', 262815514, 'Rubie Gerrad', 'Chancey Duinbleton', 'Armand Evenett'),
       (39, 45, '91.76', 450462743, 'Monti Toll', 'Dorene Poletto', 'Waneta Lerego'),
       (40, 96, '53.7', 558163634, 'Corliss Gutcher', 'Corby Mowat', 'Raf Masserel'),
       (41, 13, '13.02', 438379067, 'Jeth Nuccitelli', 'Vincenz Oiseau', 'Lexy Burnyeat'),
       (42, 92, '70.8', 567187268, 'Tamarra McAllaster', 'Lodovico Maffucci', 'Ford Baroche'),
       (43, 46, '24.13', 86506467, 'Jan Brangan', 'Corrie Vigurs', 'Devonne Stollenbeck'),
       (44, 29, '97.35', 817629885, 'Lance O''Rafferty', 'Bobby Edards', 'Nertie Barg'),
       (45, 72, '5.09', 839306037, 'Walt Caramuscia', 'Emelina Di Biagi', 'Jamison Descroix'),
       (46, 85, '53.38', 129138866, 'Valentijn Surmeir', 'Sutton Bierman', 'Aleece Gurden'),
       (47, 62, '74.52', 295153058, 'Garvy Roads', 'Gran Mebs', 'Lanita Dowdney'),
       (48, 52, '67.98', 189373088, 'Teodora Jeffery', 'Ford Stritton', 'Gerti Tripony'),
       (49, 74, '72.36', 426341166, 'Lindy Botright', 'Byrle Thormann', 'Christin Karslake'),
       (50, 98, '25.11', 497601807, 'Joshua Cram', 'Francoise Rontsch', 'Roselin Emslie'),
       (51, 99, '89.5', 159605556, 'Milzie Klimowski', 'Alejandro Chase', 'Jerrylee Spat'),
       (52, 67, '15.83', 158714561, 'Clemmy Muckley', 'Cherry Matic', 'Vikky Wildsmith'),
       (53, 50, '94.39', 842659724, 'Allyn Volleth', 'Alwin Rumble', 'Dario Riolfi'),
       (54, 65, '3.53', 688876027, 'Demeter Petronis', 'Janela Coggon', 'Casandra Iddens'),
       (55, 84, '38.29', 455481655, 'Patsy Dmitrichenko', 'Frank Ravens', 'Obed Stollen'),
       (56, 52, '65.52', 829867655, 'Fields Lingner', 'Kirbie Fyfe', 'Marita Sparsholt'),
       (57, 86, '81.26', 725631629, 'Stan Pickworth', 'Theresita Benner', 'Ofella Childs'),
       (58, 59, '41.03', 834636863, 'Kakalina Pedlingham', 'Thomas Vallender', 'Staffard Diemer'),
       (59, 63, '42.17', 796474789, 'Janaye Feasey', 'Muffin Franseco', 'Rochette Tobias'),
       (60, 77, '88.25', 479667141, 'Joane Nulty', 'Christophorus Cockill', 'Natalee Proudman'),
       (61, 83, '35.54', 846079893, 'Amber Capp', 'Carolus Chainey', 'Basile Harbach'),
       (62, 30, '65.87', 228791160, 'Carilyn Di Matteo', 'Jerrie Borit', 'Brad Dewdney'),
       (63, 63, '77.6', 83337097, 'Dennis Oxx', 'Lorens Griswaite', 'Norry Castangia'),
       (64, 76, '95.83', 350444659, 'Garfield Maleby', 'Virginia Stapylton', 'Camila Muino'),
       (65, 29, '45.14', 620500327, 'Valera McGowing', 'Xylina Clemett', 'Lorna Martinie'),
       (66, 77, '63.5', 214238232, 'Kirbee Dimitrescu', 'Wernher Kenen', 'Burl Brunton'),
       (67, 52, '82.59', 271399514, 'Marcellina Leroux', 'Dulci Chanders', 'Conan Wandrey'),
       (68, 7, '41.08', 963683054, 'Webb Puzey', 'Prinz Pylkynyton', 'Garland Jeannon'),
       (69, 17, '61.56', 350935229, 'Trude Askew', 'Netti Dahmel', 'Arlena Gerant'),
       (70, 47, '33.44', 670310951, 'Eada Stirzaker', 'Burt Olesen', 'Meagan Bahia'),
       (71, 12, '41.18', 337099737, 'Ancell Ulyatt', 'Caprice Esson', 'Neal Steers'),
       (72, 34, '16.46', 90188036, 'Brunhilde Sackur', 'Chantal Wattins', 'Augie Tyce'),
       (73, 46, '57.5', 588431791, 'Amil Garnham', 'Berte Banke', 'Ellie Chetwynd'),
       (74, 91, '52.06', 788340273, 'Billy Thistleton', 'Alejoa Livesey', 'Humfrey Zeplin'),
       (75, 84, '43.94', 949478958, 'Alvie Wemyss', 'Emanuele Jestico', 'Lexie Fenney'),
       (76, 61, '54.64', 734121138, 'Juliann Annion', 'Carly Gludor', 'Balduin Rigmond'),
       (77, 2, '93.05', 907590063, 'Zorana Wentworth', 'Rodrigo Pawden', 'Dexter Bowdler'),
       (78, 66, '1.07', 277042631, 'Lemmy Ivankov', 'Yulma Lunck', 'Catlin Curton'),
       (79, 90, '77.62', 381489365, 'Brandi Breslin', 'Casper Slym', 'Sauveur Reavey'),
       (80, 17, '70.51', 865250520, 'Penny Pietron', 'Stormie Balme', 'Adrian Firminger'),
       (81, 92, '45.3', 496390975, 'Josefa Vakhlov', 'Junia Beakes', 'Meridith Timpany'),
       (82, 27, '52.4', 315501071, 'Gratia Culter', 'Anne-marie Charsley', 'Kaylee Burnitt'),
       (83, 50, '51.11', 373663503, 'Bard Ruddoch', 'Creighton Keemer', 'Zsa zsa Phelan'),
       (84, 23, '5.11', 142180353, 'Monica Skittrell', 'Giffard Sentance', 'Matilda Smees'),
       (85, 15, '24.63', 100684403, 'Tades Profit', 'Vallie Lindsley', 'Adore Laird-Craig'),
       (86, 36, '50.91', 508113474, 'Candida Prandi', 'Kial Ruff', 'Loreen Baskett'),
       (87, 2, '9.37', 675598580, 'Bert Franzewitch', 'Shanta Crottagh', 'Chancey Wisker'),
       (88, 43, '1.38', 720070802, 'Eirena Mollen', 'Orran Kenningham', 'Violante Godlonton'),
       (89, 3, '15.17', 74308555, 'Barnabas Kwietak', 'Alvira Clere', 'Carolan Gunby'),
       (90, 4, '76.04', 974313687, 'Carlynne Frondt', 'Blair Essam', 'Nels Egell'),
       (91, 1, '34.11', 777555828, 'Elberta Lowman', 'Shoshana Torrie', 'Gerek Beckham'),
       (92, 12, '6.54', 881060804, 'Aline Streeten', 'Mariele Aldersley', 'Ted Smiz'),
       (93, 67, '41.55', 273949323, 'Sonny Harewood', 'Berte Hampson', 'Malanie Hoggetts'),
       (94, 41, '77.24', 703823041, 'Benedikt Bubb', 'Man Pirkis', 'Esta Justun'),
       (95, 84, '67.02', 888229231, 'Wenda Izkovicz', 'Burlie Jensen', 'Reta Priestman'),
       (96, 90, '13.42', 685210006, 'Dorris Richardeau', 'Cobb McAteer', 'Sharia Robrow'),
       (97, 16, '61.88', 778422156, 'Jordon Bartlam', 'Margette Treend', 'Benton Belchem'),
       (98, 3, '73.98', 593694064, 'Tiffi Ansill', 'Kylie Tregust', 'Guglielma Gaskoin'),
       (99, 18, '71.86', 812554877, 'Juline Cousin', 'Noah Style', 'Jeri Hockell'),
       (100, 36, '8.82', 667445801, 'Jasper Minto', 'Vina Hotchkin', 'Bel Dyball');

INSERT INTO `Technician`
VALUES (1, 'Aronin', 'Modestia'),
       (2, 'O''Scannill', 'Pauli'),
       (3, 'Geikie', 'Bessie'),
       (4, 'Cool', 'Blair'),
       (5, 'Wakeley', 'Kim'),
       (6, 'Howlin', 'Ethe'),
       (7, 'Skyram', 'Cindra'),
       (8, 'Joberne', 'Jarred'),
       (9, 'Manthorpe', 'Stearne'),
       (10, 'Izhakov', 'Quint'),
       (11, 'Prator', 'Rogerio'),
       (12, 'Hungerford', 'Salomon'),
       (13, 'Jerzykiewicz', 'Alva'),
       (14, 'Pietrusiak', 'Reece'),
       (15, 'MacNelly', 'Elroy'),
       (16, 'Quibell', 'Kippar'),
       (17, 'Heed', 'Kendra'),
       (18, 'Joll', 'Teresina'),
       (19, 'Kieran', 'Tiler'),
       (20, 'Larn', 'Warden'),
       (21, 'Duthy', 'Kissie'),
       (22, 'Mayall', 'Gusty'),
       (23, 'Windebank', 'Caleb'),
       (24, 'Earlam', 'Garrick'),
       (25, 'David', 'Bell'),
       (26, 'Pursglove', 'Kesley'),
       (27, 'Simononsky', 'Lilias'),
       (28, 'Murdoch', 'Helenka'),
       (29, 'Durn', 'Ediva'),
       (30, 'Corley', 'Alexandro'),
       (31, 'Holligan', 'Giulia'),
       (32, 'Abyss', 'Mahalia'),
       (33, 'Milmo', 'Toby'),
       (34, 'Camelin', 'Hildagarde'),
       (35, 'Rawet', 'Missie'),
       (36, 'Lafflin', 'Bondon'),
       (37, 'Scholig', 'Sonni'),
       (38, 'Odde', 'Seamus'),
       (39, 'Wilcott', 'Fredi'),
       (40, 'Drysdall', 'Lynnette'),
       (41, 'Howsden', 'Bax'),
       (42, 'Minchenton', 'Anthea'),
       (43, 'Rollin', 'Vance'),
       (44, 'Dyet', 'Patsy'),
       (45, 'Hegel', 'Malvin'),
       (46, 'Wildblood', 'Archer'),
       (47, 'Masding', 'Ellene'),
       (48, 'Lesurf', 'Regan'),
       (49, 'Caldero', 'Britta'),
       (50, 'Orrick', 'Sunny'),
       (51, 'Rayson', 'Claiborn'),
       (52, 'Siemandl', 'Barton'),
       (53, 'Spikings', 'Peggie'),
       (54, 'Lismer', 'Electra'),
       (55, 'Bareham', 'Sande'),
       (56, 'Castellani', 'Brannon'),
       (57, 'Halbord', 'Vera'),
       (58, 'Vinau', 'Lucas'),
       (59, 'Iltchev', 'Humberto'),
       (60, 'McConnell', 'Helaine'),
       (61, 'Deville', 'Alverta'),
       (62, 'Ors', 'Fancy'),
       (63, 'Zanassi', 'Celestyn'),
       (64, 'Maclaine', 'Larisa'),
       (65, 'Cayley', 'Rutter'),
       (66, 'Klassmann', 'Teodoor'),
       (67, 'Sudddard', 'Ophelie'),
       (68, 'Buessen', 'Pen'),
       (69, 'Paoli', 'Brunhilda'),
       (70, 'Hargate', 'Giavani'),
       (71, 'Gransden', 'Babs'),
       (72, 'Duce', 'Lissie'),
       (73, 'Bode', 'Freddy'),
       (74, 'Walshe', 'Erek'),
       (75, 'Isley', 'Albert'),
       (76, 'Sangster', 'Alys'),
       (77, 'Blenkinship', 'Biron'),
       (78, 'Somersett', 'Ailsun'),
       (79, 'Culwen', 'Candace'),
       (80, 'Jeal', 'Nina'),
       (81, 'Gregson', 'Avril'),
       (82, 'Crone', 'Hannah'),
       (83, 'O''Canavan', 'Salomone'),
       (84, 'Tinn', 'Krisha'),
       (85, 'Quaife', 'Vanni'),
       (86, 'Mullins', 'Vallie'),
       (87, 'Braun', 'Maryl'),
       (88, 'Labroue', 'Ofilia'),
       (89, 'Mc Corley', 'Iggie'),
       (90, 'Townend', 'Griffin'),
       (91, 'Tarbert', 'Cecil'),
       (92, 'Orchard', 'Sherwynd'),
       (93, 'Brennenstuhl', 'Olwen'),
       (94, 'Cowhig', 'Arabela'),
       (95, 'Ticic', 'Les'),
       (96, 'Edgington', 'Serena'),
       (97, 'Bursnell', 'Galina'),
       (98, 'Olsen', 'Joly'),
       (99, 'Alway', 'Carry'),
       (100, 'Manger', 'Kira');



INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (8, 5, 3, true, true, '2022-01-29 23:32:49', '2023-02-09 11:06:17');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (9, 99, 6, true, false, '2021-09-03 10:07:47', '2023-02-02 02:54:20');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (10, 91, 5, true, true, '2022-09-07 11:26:08', '2023-03-20 21:12:03');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (11, 77, 10, true, false, '2021-09-14 08:44:05', '2023-02-24 15:30:00');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (1, 85, 7, true, true, '2023-01-18 01:25:44', '2023-02-28 10:34:41');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (2, 62, 7, false, false, '2022-12-08 15:44:33', '2023-03-28 23:59:32');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (3, 7, 1, true, true, '2021-09-06 14:34:17', '2023-03-21 04:10:32');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (4, 42, 0, true, false, '2021-10-28 04:30:27', '2023-03-09 06:06:20');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (5, 57, 4, true, false, '2022-06-23 16:45:04', '2023-02-15 11:03:18');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (6, 65, 2, true, true, '2022-06-26 23:01:04', '2023-03-29 06:03:34');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (7, 15, 9, true, false, '2021-09-17 03:02:30', '2023-03-26 04:13:41');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (12, 16, 3, false, false, '2022-08-08 19:34:52', '2023-03-23 22:42:57');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (13, 86, 6, true, false, '2022-03-21 13:04:53', '2023-03-14 00:08:05');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (14, 49, 2, true, true, '2022-07-10 02:42:36', '2023-02-10 08:30:13');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (15, 62, 3, false, false, '2022-10-31 23:14:53', '2023-03-21 01:13:51');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (16, 42, 1, true, true, '2022-04-20 10:24:04', '2023-03-14 16:59:31');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (17, 65, 7, true, true, '2021-09-02 18:46:25', '2023-02-08 15:14:38');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (18, 9, 1, false, true, '2022-11-20 21:32:55', '2023-02-09 06:32:48');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (19, 66, 6, true, true, '2021-09-29 15:16:25', '2023-02-12 06:48:04');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (20, 14, 1, true, false, '2022-04-02 06:32:02', '2023-03-05 00:12:08');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (21, 43, 1, true, true, '2022-05-24 22:28:12', '2023-02-06 00:36:18');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (22, 30, 4, true, false, '2022-11-14 18:33:45', '2023-02-20 05:00:07');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (23, 60, 2, true, false, '2022-10-08 11:02:23', '2023-02-27 07:07:33');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (24, 35, 6, true, true, '2021-10-01 13:09:39', '2023-02-27 21:55:40');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (25, 40, 5, false, false, '2022-08-09 01:33:38', '2023-02-06 04:00:38');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (26, 22, 10, true, true, '2022-07-10 08:39:25', '2023-03-25 23:44:26');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (27, 33, 10, false, true, '2022-11-17 21:22:30', '2023-03-09 18:55:45');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (28, 72, 1, false, false, '2022-05-19 19:15:22', '2023-03-11 22:19:36');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (29, 16, 4, false, false, '2022-07-02 20:36:30', '2023-03-24 17:40:54');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (30, 12, 5, false, false, '2021-12-28 07:01:56', '2023-03-01 15:05:42');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (31, 84, 10, false, false, '2021-11-09 21:05:58', '2023-03-19 22:19:17');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (32, 76, 2, true, false, '2022-08-08 20:00:28', '2023-02-07 18:58:51');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (33, 73, 3, false, true, '2022-04-20 00:12:06', '2023-03-03 07:48:11');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (34, 44, 3, false, false, '2021-09-04 23:53:24', '2023-02-23 06:10:12');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (35, 85, 6, false, false, '2022-01-14 20:02:50', '2023-02-09 03:55:39');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (36, 77, 2, false, false, '2021-09-26 07:56:46', '2023-02-09 03:06:46');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (37, 10, 4, true, true, '2022-10-23 16:57:41', '2023-03-03 13:07:32');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (38, 39, 2, true, true, '2021-08-20 19:48:02', '2023-03-10 23:06:16');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (39, 64, 5, false, true, '2023-01-15 14:43:20', '2023-02-06 21:35:44');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (40, 53, 5, false, true, '2021-12-31 23:09:29', '2023-03-20 14:15:16');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (41, 56, 2, true, false, '2022-09-06 05:17:47', '2023-04-01 20:46:27');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (42, 46, 2, true, true, '2022-03-10 08:32:13', '2023-02-25 20:46:45');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (43, 8, 8, false, true, '2022-09-25 15:08:40', '2023-03-05 07:08:09');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (44, 86, 1, true, false, '2022-01-06 07:21:23', '2023-03-30 23:55:11');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (45, 95, 9, false, false, '2021-08-28 18:47:04', '2023-02-23 18:45:21');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (46, 10, 4, false, false, '2022-09-03 09:59:45', '2023-03-30 20:27:12');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (47, 65, 10, false, false, '2022-07-09 06:34:15', '2023-02-17 18:48:37');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (48, 11, 8, false, true, '2022-03-23 13:11:17', '2023-03-10 20:46:22');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (49, 83, 2, false, false, '2022-08-07 13:37:15', '2023-03-30 18:11:14');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (50, 12, 10, false, true, '2022-06-08 03:48:49', '2023-02-24 09:43:01');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (51, 15, 10, true, false, '2022-11-28 22:13:19', '2023-03-01 22:26:26');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (52, 22, 1, true, false, '2022-04-01 10:47:59', '2023-03-25 17:06:57');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (53, 96, 7, false, true, '2021-10-13 20:14:14', '2023-03-25 09:56:32');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (54, 50, 9, true, false, '2021-10-04 10:29:06', '2023-03-19 12:07:04');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (55, 53, 2, true, false, '2022-02-23 11:44:08', '2023-03-03 07:03:33');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (56, 95, 8, true, true, '2021-11-27 17:32:27', '2023-04-01 18:46:04');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (57, 26, 1, false, false, '2022-07-17 05:49:30', '2023-02-06 15:15:06');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (58, 96, 7, false, false, '2021-10-03 20:45:51', '2023-03-15 02:17:02');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (59, 19, 2, true, true, '2022-08-09 20:16:25', '2023-03-14 08:31:10');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (60, 80, 8, false, true, '2022-01-02 06:17:58', '2023-02-08 14:26:50');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (61, 25, 3, true, true, '2022-02-16 11:19:08', '2023-03-17 00:33:32');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (62, 56, 2, false, true, '2022-07-03 21:58:43', '2023-02-12 14:51:16');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (63, 46, 10, true, false, '2022-03-09 12:32:33', '2023-04-03 21:51:50');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (64, 72, 6, true, false, '2021-07-25 05:28:22', '2023-03-10 21:45:05');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (65, 1, 7, true, true, '2022-03-14 11:14:29', '2023-03-05 12:57:52');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (66, 58, 2, true, false, '2022-02-17 12:50:02', '2023-02-05 22:15:13');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (67, 61, 4, false, false, '2022-06-24 12:11:01', '2023-03-11 01:47:16');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (68, 45, 10, true, false, '2021-07-17 11:52:13', '2023-03-21 14:15:57');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (69, 29, 7, true, true, '2022-09-16 00:01:07', '2023-02-06 01:14:58');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (70, 10, 10, true, false, '2022-07-18 04:17:36', '2023-03-22 08:28:06');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (71, 56, 6, false, false, '2022-07-04 14:17:49', '2023-02-21 04:58:39');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (72, 7, 3, false, false, '2022-11-23 23:39:59', '2023-02-23 23:46:13');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (73, 77, 5, false, false, '2022-08-18 16:06:07', '2023-04-03 20:48:46');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (74, 33, 2, true, false, '2022-09-10 09:38:14', '2023-02-19 18:41:13');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (75, 43, 2, false, true, '2022-08-10 07:05:16', '2023-02-07 14:08:11');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (76, 57, 8, true, false, '2021-10-04 11:49:42', '2023-03-31 23:46:41');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (77, 79, 9, true, false, '2022-11-26 23:46:00', '2023-02-04 14:10:25');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (78, 86, 2, true, false, '2021-10-10 20:16:49', '2023-02-11 08:33:00');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (79, 36, 7, false, false, '2022-09-04 00:42:38', '2023-02-26 07:40:38');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (80, 58, 1, false, true, '2022-02-20 07:19:59', '2023-02-24 19:31:04');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (81, 82, 10, true, false, '2022-02-23 20:24:18', '2023-03-03 03:12:52');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (82, 46, 7, true, true, '2021-11-10 19:00:16', '2023-03-27 13:11:41');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (83, 73, 5, true, false, '2021-09-30 20:31:30', '2023-02-09 11:48:49');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (84, 99, 3, true, true, '2022-06-23 12:52:57', '2023-02-11 13:29:56');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (85, 40, 7, false, false, '2022-06-01 22:35:07', '2023-03-30 13:40:57');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (86, 50, 3, true, false, '2022-12-09 22:42:54', '2023-03-01 11:25:04');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (87, 26, 5, false, false, '2022-12-10 02:28:36', '2023-03-28 23:49:48');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (88, 66, 6, true, true, '2022-12-29 20:50:34', '2023-02-19 19:11:32');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (89, 80, 7, false, false, '2022-08-20 23:28:52', '2023-03-29 22:11:33');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (90, 40, 8, false, false, '2022-11-05 17:11:46', '2023-03-11 04:02:50');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (91, 2, 3, false, true, '2022-01-20 17:06:29', '2023-04-02 13:16:13');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (92, 11, 2, true, false, '2022-04-15 14:36:22', '2023-02-08 23:22:23');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (93, 5, 4, false, true, '2021-07-07 01:17:46', '2023-02-22 23:13:45');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (94, 37, 2, false, true, '2022-03-31 16:18:21', '2023-03-24 09:40:08');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (95, 40, 5, true, false, '2021-07-30 20:31:41', '2023-02-03 23:59:56');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (96, 43, 3, false, false, '2022-08-20 17:14:18', '2023-04-01 21:41:20');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (97, 79, 9, false, true, '2022-01-27 10:59:12', '2023-03-30 16:50:04');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (98, 59, 9, false, true, '2021-07-12 14:33:02', '2023-02-11 09:08:18');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (99, 23, 10, false, true, '2021-10-04 10:31:20', '2023-03-30 20:05:09');
INSERT INTO Deal(deal_id, ask_id, feasibility, top_5, deal_status, start_date, approval_date)
VALUES (100, 11, 8, true, true, '2022-06-13 01:42:45', '2023-02-21 20:48:43');

INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (1, 80, 30, 0.68, 43453376, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (2, 92, 12, 0.06, 96467808, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (3, 81, 45, 0.62, 95655899, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (4, 9, 51, 0.67, 16743283, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (5, 59, 56, 0.32, 38129674, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (6, 72, 80, 0.9, 79780857, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (7, 96, 87, 0.44, 41757900, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (8, 28, 46, 0.84, 16026374, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (9, 36, 27, 0.03, 47183208, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (10, 77, 55, 0.58, 30368984, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (11, 28, 17, 1.0, 51342262, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (12, 9, 84, 0.55, 7470489, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (13, 52, 55, 0.23, 74132988, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (14, 35, 8, 0.94, 97546178, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (15, 62, 25, 0.7, 79714545, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (16, 59, 67, 0.07, 59798557, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (17, 90, 100, 0.08, 63398378, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (18, 100, 40, 0.05, 40921642, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (19, 46, 86, 0.43, 95683626, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (20, 28, 49, 0.83, 29441056, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (21, 64, 22, 0.77, 98263403, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (22, 82, 7, 0.34, 73733673, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (23, 99, 77, 0.88, 1328677, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (24, 29, 31, 0.41, 18319495, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (25, 92, 70, 0.49, 33814694, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (26, 15, 1, 0.24, 10177963, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (27, 13, 56, 0.6, 7964034, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (28, 82, 95, 0.25, 5884725, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (29, 17, 82, 0.63, 61120291, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (30, 89, 12, 0.73, 54471083, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (31, 75, 68, 0.06, 62320119, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (32, 22, 42, 0.88, 46470708, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (33, 69, 81, 0.11, 1225913, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (34, 67, 31, 0.56, 40840978, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (35, 24, 36, 0.69, 25515204, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (36, 85, 1, 0.14, 11171369, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (37, 23, 37, 0.88, 64195330, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (38, 28, 43, 0.97, 20775497, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (39, 27, 7, 0.43, 93629008, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (40, 34, 61, 0.15, 8602098, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (41, 66, 82, 0.02, 10156411, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (42, 27, 2, 0.16, 15080560, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (43, 50, 83, 0.58, 15539447, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (44, 86, 94, 0.66, 69282191, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (45, 6, 72, 0.12, 16558093, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (46, 81, 83, 0.18, 93831219, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (47, 5, 90, 0.3, 52765036, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (48, 60, 37, 0.45, 42214385, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (49, 2, 15, 0.63, 22110752, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (50, 97, 40, 0.81, 45267897, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (51, 63, 40, 0.61, 1267532, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (52, 44, 3, 0.65, 40042457, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (53, 4, 56, 0.07, 21147825, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (54, 13, 31, 0.1, 97728257, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (55, 82, 35, 0.14, 18089670, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (56, 52, 91, 0.26, 9202423, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (57, 70, 7, 0.64, 44865732, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (58, 30, 97, 0.92, 19014046, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (59, 20, 39, 0.79, 22168143, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (60, 41, 22, 0.31, 95849874, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (61, 91, 33, 0.85, 3627171, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (62, 8, 60, 0.57, 58563017, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (63, 26, 100, 0.7, 1957323, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (64, 92, 9, 0.42, 84090840, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (65, 25, 64, 0.26, 26124726, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (66, 41, 4, 0.36, 27088260, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (67, 1, 93, 0.31, 68445653, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (68, 25, 76, 0.74, 25924796, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (69, 95, 34, 0.33, 79721005, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (70, 70, 90, 0.43, 18124610, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (71, 84, 78, 0.05, 4072531, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (72, 79, 37, 0.81, 74052535, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (73, 5, 35, 0.92, 20111355, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (74, 83, 5, 0.41, 33379374, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (75, 73, 73, 0.91, 51641758, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (76, 11, 38, 0.37, 58078308, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (77, 4, 85, 0.9, 86916240, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (78, 62, 19, 0.01, 13440179, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (79, 41, 66, 0.59, 81422443, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (80, 99, 52, 0.04, 41846229, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (81, 77, 18, 0.15, 85723494, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (82, 80, 61, 0.03, 55505759, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (83, 1, 86, 0.77, 3290061, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (84, 12, 2, 0.84, 86969924, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (85, 67, 64, 0.28, 76609032, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (86, 73, 17, 0.22, 20493179, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (87, 45, 19, 0.19, 37654914, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (88, 58, 37, 0.31, 95264763, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (89, 62, 28, 0.76, 25362956, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (90, 12, 90, 0.39, 24184733, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (91, 5, 53, 0.58, 98605647, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (92, 35, 52, 0.8, 54799836, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (93, 66, 90, 0.51, 65548460, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (94, 31, 73, 0.84, 1498910, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (95, 99, 30, 0.45, 10145316, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (96, 59, 87, 0.4, 95139836, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (97, 27, 7, 0.9, 71727796, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (98, 7, 6, 0.93, 22478871, true);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (99, 82, 69, 0.65, 24551098, false);
INSERT INTO Bid(bid_id, pe_id, deal_id, bid_range, bid_price, bid_status)
VALUES (100, 19, 11, 0.34, 47584744, false);



INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (48, 90, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (53, 40, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (22, 88, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (78, 22, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (43, 33, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (11, 91, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (88, 23, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (15, 38, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (23, 72, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (16, 1, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (72, 25, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (15, 93, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (83, 62, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (19, 12, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (10, 73, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (47, 82, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (16, 30, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (63, 55, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (77, 96, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (18, 61, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (21, 27, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (75, 28, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (77, 8, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (85, 59, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (19, 25, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (52, 58, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (62, 11, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (50, 95, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (64, 97, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (91, 52, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (90, 8, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (32, 88, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (19, 4, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (64, 49, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (29, 96, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (100, 25, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (97, 37, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (76, 52, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (17, 13, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (5, 10, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (66, 63, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (85, 7, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (72, 88, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (18, 8, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (93, 23, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (59, 92, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (58, 72, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (88, 11, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (67, 89, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (57, 83, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (80, 64, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (33, 73, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (1, 2, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (69, 8, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (70, 61, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (29, 22, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (45, 48, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (5, 19, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (47, 97, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (26, 9, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (94, 52, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (11, 72, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (88, 80, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (57, 74, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (78, 32, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (14, 8, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (95, 65, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (3, 12, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (54, 20, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (51, 61, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (3, 67, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (82, 81, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (40, 89, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (29, 15, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (31, 49, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (94, 44, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (62, 2, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (20, 80, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (64, 89, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (87, 61, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (94, 2, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (59, 98, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (18, 14, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (51, 44, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (60, 11, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (48, 43, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (54, 4, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (97, 41, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (20, 12, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (66, 67, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (27, 42, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (16, 21, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (17, 43, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (68, 100, false);


INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (94, 8, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (3, 7, true);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (76, 80, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (79, 48, false);
INSERT INTO Allows(technician_id, company_id, is_visible)
VALUES (69, 46, false);

INSERT INTO `Reviews`
VALUES (83, 21, 'Wuckert-Gislason', 'Kreiger, Conroy and Huels', 'Dibbert, Funk and Collier',
        'Dicki, Kuphal and Legros', 'Olson Group'),
       (61, 64, 'Dietrich, Toy and Sawayn', 'Jakubowski, Rowe and Kutch', 'Abernathy, Nikolaus and Koss',
        'Huel, Mante and Tromp', 'Bayer LLC'),
       (20, 96, 'Bins, Schiller and Rippin', 'Monahan, Hintz and Dach', 'Lehner Inc', 'Cole, Christiansen and Hintz',
        'Dickens Group'),
       (77, 52, 'Bernier-Boehm', 'Lockman Inc', 'Gutmann, Smitham and Okuneva', 'Kling Inc', 'Turcotte-Gorczany'),
       (70, 59, 'Padberg Group', 'Rohan, Halvorson and Kirlin', 'Barton and Sons', 'Howe, DuBuque and Daugherty',
        'Jerde LLC'),
       (93, 84, 'Hilpert, Kling and Reynolds', 'Heller Group', 'Cormier and Sons', 'Gutkowski Inc', 'Bradtke Group'),
       (89, 44, 'Block-Weber', 'Champlin-Cormier', 'Sauer-West', 'Becker Inc', 'Pacocha, Kerluke and Hackett'),
       (86, 74, 'Boyle Inc', 'Cremin and Sons', 'Osinski Group', 'Tromp, West and Haag', 'Green, Jast and Bradtke'),
       (43, 56, 'Kiehn-Okuneva', 'Stoltenberg-Tromp', 'Lockman, Carroll and Willms', 'Hirthe and Sons',
        'Tillman, Mann and Lowe'),
       (54, 94, 'Leuschke-Davis', 'Prohaska-Rempel', 'Boehm and Sons', 'Hermiston LLC', 'Rath and Sons'),
       (92, 62, 'Collier, Hane and Smitham', 'Kreiger-Kerluke', 'Schuppe, Heathcote and Zemlak',
        'Satterfield, Reichel and Kerluke', 'Klocko and Sons'),
       (1, 31, 'Labadie-Lesch', 'Pollich, Littel and Labadie', 'Will-West', 'Rice-Satterfield', 'Yost-Hammes'),
       (59, 97, 'Pfannerstill-Doyle', 'Turner-Larkin', 'Williamson-Pfannerstill', 'Jacobson, Kohler and Gerlach',
        'Fahey-Hayes'),
       (57, 8, 'Wyman, Price and Rowe', 'Kuhic Group', 'Kautzer-Kreiger', 'Lindgren-Murazik', 'Nicolas-Dickinson'),
       (38, 61, 'Mertz-Botsford', 'Tillman-Ondricka', 'Kessler-Reichert', 'Bernhard, Mertz and Zboncak',
        'Vandervort-Hansen'),
       (48, 55, 'Pouros-Lockman', 'Hintz-Dickinson', 'Lubowitz, Graham and Wolff', 'Frami, Halvorson and Crona',
        'Cronin, Hahn and Hartmann'),
       (40, 14, 'Mosciski, Keebler and Wolf', 'Dickens LLC', 'Torp-Grant', 'Kessler, Trantow and Wisoky',
        'Lynch Group'),
       (94, 21, 'Dietrich, McKenzie and Conn', 'Kilback, Willms and McDermott', 'Blick-Cummerata', 'Koelpin and Sons',
        'Kemmer, Funk and Christiansen'),
       (44, 66, 'Witting-Rutherford', 'Wyman, Lemke and Herzog', 'Jast-Schulist', 'Rutherford-Gusikowski',
        'McClure-Franecki'),
       (59, 17, 'Barton Group', 'Murray, Heaney and Moen', 'Erdman-Smith', 'Lowe Inc',
        'Kshlerin, Ruecker and Balistreri'),
       (21, 90, 'Jerde-Langworth', 'Grady-Hyatt', 'Boyle Inc', 'Orn, Hoeger and Kilback', 'Wunsch and Sons'),
       (64, 12, 'Deckow, Farrell and Corwin', 'Kohler Group', 'Blanda Inc', 'Schmidt and Sons', 'Fadel Group'),
       (27, 64, 'Torp-Boyer', 'Bailey, Botsford and Deckow', 'Goyette LLC', 'Beier-Mayert', 'Renner and Sons'),
       (76, 75, 'Tillman, Rau and Moen', 'Hansen Group', 'Brekke LLC', 'Bauch-Senger', 'Stoltenberg-Murazik'),
       (72, 55, 'Ebert Group', 'Schultz-Sporer', 'Douglas-Mante', 'Jenkins Group', 'Hane Group'),
       (41, 40, 'Runolfsdottir-Quigley', 'Kautzer-Carroll', 'Mertz-Mueller', 'Wilkinson-Brown',
        'Ortiz, Hamill and Connelly'),
       (80, 100, 'Dickinson-Kessler', 'Auer, Reinger and Klein', 'Steuber and Sons', 'Marks-Kuhlman', 'Hahn Inc'),
       (36, 22, 'Gorczany, Blick and Dibbert', 'Wiza-Schiller', 'Lockman LLC', 'Reynolds-Rosenbaum',
        'Streich, Prohaska and Nitzsche'),
       (15, 6, 'Davis-Kirlin', 'Ondricka, Bahringer and Nitzsche', 'Huel-Sauer', 'Schumm-Fadel',
        'Zulauf, Shields and Boyle'),
       (8, 50, 'Zieme, Hilll and Green', 'Champlin-Okuneva', 'Hodkiewicz-Schamberger', 'Murphy-Thiel',
        'Veum, Wilkinson and Willms'),
       (31, 44, 'Tremblay-Heathcote', 'Welch and Sons', 'Prohaska, Stokes and Orn', 'Denesik and Sons',
        'Reinger-Ledner'),
       (52, 53, 'Marquardt-Kerluke', 'Thiel-Crooks', 'Mayer-Casper', 'Braun LLC', 'Ziemann, Jacobi and Dickinson'),
       (87, 45, 'Schuppe, Feil and Koss', 'McClure Group', 'Bins Group', 'Waters Inc', 'Hackett-Stokes'),
       (9, 62, 'Skiles, Olson and Green', 'Hahn, Fay and Reichert', 'Beahan, Kilback and Heller', 'Romaguera-Hills',
        'Rippin, Mueller and Quitzon'),
       (42, 82, 'Hane, Sawayn and Feil', 'Jast-Hickle', 'Maggio and Sons', 'Kunze, Altenwerth and Jacobi',
        'Greenholt-Hills'),
       (24, 44, 'Ullrich Group', 'Schmitt Inc', 'Grant-O''Kon', 'Ortiz-Stoltenberg', 'White, Jakubowski and Lehner'),
       (87, 70, 'Morar and Sons', 'Bednar-Stoltenberg', 'Dickens-Pagac', 'Wisozk-O''Reilly',
        'Dicki, Renner and Nienow'),
       (39, 9, 'Yundt Inc', 'Kassulke, Maggio and Lesch', 'Pouros LLC', 'Prosacco-Jones', 'Dare LLC'),
       (43, 76, 'Larson, Heidenreich and Kunde', 'Luettgen LLC', 'Donnelly-Johnson', 'McCullough-Quigley', 'Howe LLC'),
       (61, 28, 'Rowe LLC', 'Rippin and Sons', 'Nader, O''Connell and Bradtke', 'D''Amore, Lind and Turcotte',
        'Little, Hills and Gottlieb'),
       (71, 80, 'Spencer, McLaughlin and Bechtelar', 'Mayer, O''Connell and Vandervort', 'Bernier-Torphy',
        'Considine LLC', 'Green, Kilback and Feest'),
       (75, 56, 'Larkin, Casper and Ward', 'Kuphal and Sons', 'Stokes-Moore', 'Stark and Sons',
        'Conn, Bartoletti and Lueilwitz'),
       (57, 28, 'McLaughlin-Reichert', 'Parker and Sons', 'Muller-Hermann', 'Boyer Inc', 'Oberbrunner Inc'),
       (79, 74, 'Murazik Group', 'Fritsch-O''Keefe', 'Marquardt-Klocko', 'Bins, Reichel and Jacobi', 'Kuhn-O''Kon'),
       (25, 15, 'Schmidt-Runolfsdottir', 'Wisozk, Kris and Graham', 'Cronin Inc', 'Gerhold-Rodriguez',
        'White, O''Hara and Dicki'),
       (83, 40, 'Emmerich, Boyer and Watsica', 'Mueller Inc', 'Wuckert, Williamson and Goodwin',
        'Dickinson, Kuhic and Wilkinson', 'Mante, Funk and Kuhlman'),
       (98, 73, 'Berge LLB', 'Rodriguez, Monahan and Pfeffer', 'Tremblay-Bradtke', 'O''Conner and Sons',
        'Harvey and Sons'),
       (23, 68, 'Block, Sawayn and Bednar', 'Heidenreich Group', 'Lindgren-Braun', 'Runolfsdottir, MacGyver and Bednar',
        'Simonis, Steuber and Turner'),
       (85, 31, 'Berge LLC', 'Lynch-Ferry', 'Parisian, Nikolaus and Reinger', 'Hudson, Grady and Hilll',
        'Jast-Rolfson'),
       (88, 98, 'Friesen, Bosco and Walter', 'Beatty, Braun and Ziemann', 'Hagenes-Hyatt', 'Hoppe and Sons',
        'Rice, Gusikowski and Casper'),
       (99, 41, 'Schmitt Inc', 'Nicolas-Parker', 'Rohan, Koch and McKenzie', 'Jast and Sons',
        'Schmidt, Hettinger and DuBuque'),
       (80, 62, 'Kovacek-Mann', 'Wehner-Nikolaus', 'Cruickshank, Stamm and Von', 'O''Connell-MacGyver',
        'Christiansen Group'),
       (88, 12, 'Doyle, Gleichner and Kirlin', 'King Group', 'Walker-Auer', 'Huels LLC', 'Mertz, Kautzer and Koss'),
       (39, 42, 'Farrell and Sons', 'Cremin-Bradtke', 'Wilderman LLC', 'Jenkins Inc', 'Koch, Koss and Boyle'),
       (40, 48, 'Blick-Kirlin', 'Monahan, Parker and Conn', 'Feest, Bins and Hegmann', 'Stanton and Sons',
        'Corkery Inc'),
       (54, 7, 'Kozey, Senger and Littel', 'Hickle-Spinka', 'Gleason LLC', 'Schoen-Durgan', 'Wehner, Price and Kihn'),
       (76, 25, 'Nicolas-Borer', 'Rogahn-Schinner', 'Feil-Dach', 'Simonis-Volkman', 'Mosciski-Swaniawski'),
       (94, 46, 'Lindgren Inc', 'Tromp-Muller', 'Heathcote-Mitchell', 'Thompson LLC', 'Braun-Jacobi'),
       (84, 91, 'Rosenbaum and Sons', 'Rowe-Kunde', 'McCullough, Cassin and Jerde', 'Strosin, Veum and Welch',
        'Friesen, Murray and Farrell'),
       (64, 25, 'Howe and Sons', 'Konopelski-Hane', 'Kulas-Hoeger', 'Cummerata, Towne and Jenkins', 'Koepp-Schuppe'),
       (84, 57, 'Becker-Murazik', 'Kreiger-Halvorson', 'Paucek-Hickle', 'Renner-Beer', 'Tremblay LLC'),
       (21, 77, 'Kling-Schiller', 'Russel-Wehner', 'Bahringer Group', 'Walsh, Bartoletti and Becker', 'Koss Inc'),
       (73, 35, 'Schumm, Dicki and Bernhard', 'Reinger, Cormier and Aufderhar', 'Lynch-Witting',
        'Heidenreich, Grimes and Kerluke', 'Ortiz, Langosh and Simonis'),
       (38, 4, 'Keebler, Balistreri and Connelly', 'Breitenberg Group', 'Nienow, Kunde and Heller', 'Schumm Group',
        'Effertz-White'),
       (79, 38, 'Wisoky-Feeney', 'Harris, Cronin and Considine', 'Abbott-Romaguera', 'Cummerata Inc', 'Parisian Group'),
       (99, 81, 'Will Group', 'Hauck-Yost', 'Leuschke Group', 'Goldner LLC', 'Luettgen, Watsica and Baumbach'),
       (13, 12, 'VonRueden-Welch', 'Mitchell-Corwin', 'Leffler-Gleason', 'Kertzmann, Balistreri and Okuneva',
        'Kertzmann-Lockman'),
       (39, 50, 'Breitenberg, Kulas and Ernser', 'Koch, Fisher and Jaskolski', 'Wiegand LLC', 'Konopelski Inc',
        'Bernhard, Bergstrom and Hessel'),
       (66, 56, 'Emmerich, Koch and Emard', 'Mosciski-Schaden', 'Lemke-Stracke', 'West LLC', 'O''Keefe and Sons'),
       (9, 77, 'Vandervort, Luettgen and Roob', 'Rogahn-DuBuque', 'Friesen, Kunze and Reichert', 'Connelly Inc',
        'Hackett-Nitzsche'),
       (22, 29, 'Gerhold-Grimes', 'Bartoletti, Cummerata and Kuhic', 'Mohr-Lemke', 'Witting Group', 'Jast-Tromp'),
       (67, 87, 'Keebler, Vandervort and Heller', 'Christiansen and Sons', 'Kuhn Inc', 'Waters-Watsica',
        'Feil-Osinski'),
       (76, 32, 'Nicolas-Klocko', 'Weber, Kohler and Gleichner', 'Bode-Brakus', 'Medhurst-Kub', 'Morissette and Sons'),
       (55, 48, 'DuBuque and Sons', 'Durgan-Parker', 'Hegmann, Boehm and Fay', 'Shields, Mayert and Goyette',
        'Purdy-Kessler'),
       (92, 97, 'Cartwright LLC', 'Deckow-Schamberger', 'Gleason, Hudson and Parker', 'Haley Group',
        'Cruickshank, Carter and Prohaska'),
       (22, 42, 'Quitzon, Kunze and Wiza', 'Bogisich, Halvorson and Prohaska', 'Shields-Bernier',
        'Greenholt, Cruickshank and Emard', 'Wisozk Inc'),
       (79, 55, 'Fahey-Gusikowski', 'Hessel and Sons', 'Nikolaus-Auer', 'Wilkinson-Stracke', 'Goldner Inc'),
       (21, 39, 'Thiel, Kiehn and Mayert', 'Roob LLC', 'Stroman-Simonis', 'Romaguera-Wyman', 'Russel-Gutmann'),
       (45, 84, 'Spencer, Mann and Kertzmann', 'Reichert-Smith', 'Gutmann, Harvey and Parisian', 'Kemmer-Koss',
        'Nolan Group'),
       (45, 61, 'Marvin, Bogan and Schumm', 'Russel and Sons', 'Koepp-Bartell', 'Ratke-Barton', 'Abshire LLC'),
       (85, 62, 'Runolfsdottir-Metz', 'Robel-Kunze', 'Schowalter-Nienow', 'Fisher-Pagac',
        'Skiles, Kilback and Effertz'),
       (27, 99, 'Stoltenberg-Deckow', 'Cummings, Weimann and Reichel', 'Gulgowski LLC', 'Murphy, Mitchell and Walsh',
        'Bergnaum-Feest'),
       (71, 25, 'Emmerich-Predovic', 'Walter Inc', 'Cole-Rau', 'Hayes-Wuckert', 'Stiedemann LLC'),
       (36, 56, 'Wyman-Orn', 'Flatley, Rutherford and Sawayn', 'Kunde-Lehner', 'Denesik Group', 'Waelchi-Kirlin'),
       (63, 70, 'Beahan, Nicolas and Johns', 'Moore Inc', 'Mosciski-Wuckert', 'Steuber, Steuber and Green',
        'Kautzer Group'),
       (70, 29, 'Kulas-West', 'Schulist, McKenzie and Klocko', 'Ward Group', 'Senger-Waelchi', 'Monahan Group'),
       (11, 66, 'Reichert LLC', 'Gusikowski, Schmidt and Becker', 'Mayer Inc', 'White-Cassin',
        'Stehr, Ullrich and Beatty'),
       (82, 8, 'Bogisich, Koepp and Stanton', 'Grant Group', 'Bechtelar Group', 'Doyle Group',
        'Pollich, Schuster and Shanahan'),
       (77, 9, 'Little, Doyle and Leffler', 'Bashirian Group', 'Grimes Inc', 'Ferry Inc', 'Schoen, Roob and Kautzer'),
       (80, 48, 'Heller and Sons', 'Jacobson-Bernhard', 'Corkery-Walker', 'Becker, Mraz and Brown',
        'Heathcote, Koss and Zemlak'),
       (53, 22, 'DuBuque, Heathcote and Maggio', 'Waters, Ruecker and Towne', 'Simonis Group', 'Lueilwitz-Frami',
        'Murray, Sanford and Corkery'),
       (19, 49, 'Bernier, Farrell and Zieme', 'Wyman-Douglas', 'Renner-Mitchell', 'Treutel, Parisian and Bruen',
        'Ebert LLC'),
       (31, 97, 'Breitenberg-Carroll', 'Toy Group', 'Greenholt, Veum and Kemmer', 'Wunsch, Purdy and Herzog',
        'Walsh Group'),
       (72, 29, 'Botsford LLC', 'Stiedemann Group', 'Beatty Inc', 'Little and Sons', 'Gibson-Crist'),
       (30, 28, 'Hoppe LLC', 'Berge and Sons', 'McLaughlin Inc', 'Stroman Inc', 'Pagac, Predovic and Friesen'),
       (46, 32, 'Jaskolski and Sons', 'Ferry, Lehner and Lowe', 'Roberts-Littel', 'Haag LLC',
        'Kemmer, Glover and Turcotte'),
       (1, 57, 'Mueller-Welch', 'Aufderhar and Sons', 'Bartell-Crist', 'Rodriguez and Sons',
        'Rutherford, Hills and Pacocha'),
       (80, 74, 'Roberts-Stokes', 'Rodriguez, O''Hara and Lemke', 'Stiedemann and Sons', 'Shanahan, Zieme and Bernier',
        'Lemke, Hagenes and Toy'),
       (25, 96, 'Wolf and Sons', 'Johns Inc', 'Zboncak Group', 'Kessler, Sauer and Kertzmann',
        'Halvorson, Schmitt and Ziemann');

