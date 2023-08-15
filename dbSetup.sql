CREATE TABLE
    IF NOT EXISTS accounts(
        id VARCHAR(255) NOT NULL primary key COMMENT 'primary key',
        createdAt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Time Created',
        updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Update',
        name varchar(255) COMMENT 'User Name',
        email varchar(255) COMMENT 'User Email',
        picture varchar(255) COMMENT 'User Picture'
    ) default charset utf8 COMMENT '';

-- NOTE creates a new table in your sql database

CREATE TABLE
    capybaras(
        -- NOTE primary key must be unique across each row in your database
        id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(10) NOT NULL COMMENT 'The name of our cute little dudes',
        ownedByGrandma BOOLEAN DEFAULT true COMMENT 'Keeps track of if this cute little dude was owned by a cute little grandma',
        birthday DATE NOT NULL,
        applesEaten SMALLINT UNSIGNED DEFAULT 0,
        livesAtFarm BOOLEAN NOT NULL DEFAULT FALSE
    ) default charset utf8 COMMENT '';

-- NOTE removes the table from our database

DROP TABLE capybaras;

-- NOTE adds columns to our table in the database

ALTER TABLE capybaras
ADD
    livesAtFarm BOOLEAN NOT NULL DEFAULT FALSE;

-- NOTE creates a new row (or piece of data) in our database

INSERT INTO
    capybaras (
        name,
        ownedByGrandma,
        birthday,
        applesEaten
    )
VALUES (
        'Cappy',
        true,
        '1990-12-24',
        5000
    ), (
        'Tippy Toes',
        false,
        '2012-01-01',
        3
    );

-- NOTE selects all of the names from our database

SELECT name FROM capybaras;

-- NOTE selects two columns from our database

SELECT name, applesEaten FROM capybaras;

-- NOTE selects all columns and rows from our database

SELECT * FROM capybaras;

-- NOTE selects all rows and columns where the name is equal to 'Cappy'

SELECT * FROM capybaras WHERE name = 'Cappy';

-- NOTE selects all rows and columns where the name like "cap"

SELECT * FROM capybaras WHERE name LIKE '%cap%';

-- NOTE selects by Id

SELECT * FROM capybaras WHERE id = 3;

-- NOTE selects only the second item in our table

SELECT * FROM capybaras LIMIT 1 OFFSET 1;

-- NOTE delete by id

DELETE FROM capybaras WHERE id = 2 LIMIT 1 ;

-- NOTE edit

UPDATE capybaras SET applesEaten = 9999 WHERE id = 3 LIMIT 1 ;

CREATE TABLE
    cars(
        id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        make VARCHAR(255) NOT NULL,
        model VARCHAR(300) NOT NULL,
        color VARCHAR(100) DEFAULT 'blue',
        year SMALLINT UNSIGNED DEFAULT 1990,
        price DECIMAL NOT NULL,
        ownedByGrandma BOOLEAN DEFAULT FALSE,
        createdAt DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Time Created',
        updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Update'
    ) default charset utf8 COMMENT '';

DROP TABLE cars;

INSERT INTO
    cars (
        make,
        model,
        color,
        year,
        ownedByGrandma,
        price
    )
VALUES (
        'mazda',
        'miata',
        'red',
        1996,
        true,
        6000
    );

-- NOTE select the last created item in the database

SELECT LAST_INSERT_ID();