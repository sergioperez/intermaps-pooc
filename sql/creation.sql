DROP DATABASE intermaps_db_dev;
CREATE DATABASE intermaps_db_dev;

\c intermaps_db_dev;

CREATE TABLE imports (
	id		SERIAL		PRIMARY KEY	NOT NULL,
	year		SMALLINT	NOT NULL,
	month		SMALLINT	NOT NULL,
	country_from	VARCHAR(2)	NOT NULL,
	article		VARCHAR(6)	NOT NULL,
	weight_unit	VARCHAR(2)	NOT NULL,
	country_to	VARCHAR(2)	NOT NULL,
	val		INT		NOT NULL,
	quantity	INT		NOT NULL
);

CREATE TABLE imports_collisions (
	hash		VARCHAR(10)	PRIMARY KEY	NOT NULL
);

CREATE TABLE exports (
        id              SERIAL          PRIMARY KEY     NOT NULL,
        year            SMALLINT        NOT NULL,
        month           SMALLINT        NOT NULL,
        country_from    VARCHAR(2)      NOT NULL,
        article         VARCHAR(6)      NOT NULL,
        weight_unit     VARCHAR(2)      NOT NULL,
        country_to      VARCHAR(2)      NOT NULL,
        val             INT             NOT NULL,
        quantity        INT             NOT NULL
);

CREATE TABLE exports_collisions (
	hash		VARCHAR(10)	PRIMARY KEY	NOT NULL
);
