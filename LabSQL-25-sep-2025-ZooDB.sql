USE master
GO

IF EXISTS(SELECT * FROM sysdatabases WHERE name ='AnimalDB')
    DROP DATABASE AnimalDB
GO

CREATE DATABASE AnimalDB
GO

ALTER DATABASE AnimalDB COLLATE Thai_CI_AS
GO

USE AnimalDB
GO

CREATE TABLE AnimalType (
    animal_type_id INT PRIMARY KEY IDENTITY(1,1),
    type_name NVARCHAR(100) NOT NULL,
    descriptions NVARCHAR(MAX)
)
GO

CREATE TABLE SpeciesInfo (
    species_info_id INT PRIMARY KEY IDENTITY(1,1),
    common_name NVARCHAR(100) NOT NULL,
    scientific_name NVARCHAR(100),
    habitat NVARCHAR (MAX),
    diet NVARCHAR(MAX),
    conservation_status NVARCHAR(100),
    descriptions NVARCHAR(MAX)
)
GO

CREATE TABLE Enclosure (
    enclosure_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    location NVARCHAR(200)
)
GO

CREATE TABLE Keeper (
    keeper_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(50),
    email NVARCHAR(100)
)
GO

CREATE TABLE EnclosureKeeper (
    enclosure_id INT FOREIGN KEY REFERENCES Enclosure(enclosure_id),
    keeper_id INT FOREIGN KEY REFERENCES Keeper(keeper_id),
    PRIMARY KEY(enclosure_id, keeper_id)
)
GO

CREATE TABLE Food (
    food_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    type NVARCHAR(100),
    unit NVARCHAR(50)
)
GO

CREATE TABLE Animal (
    animal_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    gender NVARCHAR(10),
    birth_date DATE,
    enclosure_id INT FOREIGN KEY REFERENCES Enclosure(enclosure_id),
    animal_type_id INT FOREIGN KEY REFERENCES AnimalType(animal_type_id),
    species_info_id INT FOREIGN KEY REFERENCES SpeciesInfo(species_info_id) 
)
GO

CREATE TABLE FeedingSchedule(
    feeding_id INT PRIMARY KEY IDENTITY(1,1),
    animal_id INT FOREIGN KEY REFERENCES Animal(animal_id) NOT NULL,
    food_id INT FOREIGN KEY REFERENCES Food(food_id) NOT NULL,
    amount DECIMAL(10,2),
    feeding_date DATE,
    feeding_time TIME,
    keeper_id INT FOREIGN KEY REFERENCES Keeper(keeper_id)
)
