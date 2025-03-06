CREATE TABLE Persons (
    ID int NOT NULL,
    FirstName varchar(255) NOT NULL,
    LastName varchar(255),
    Age int,
    PRIMARY KEY (ID)
);


INSERT INTO Persons (ID, FirstName, LastName, Age)
VALUES (1, 'John', 'Goh', 21);