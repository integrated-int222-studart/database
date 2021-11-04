-- MySQL Script generated by MySQL Workbench
-- Thu Nov  4 12:53:44 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Studart_System
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Studart_System
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Studart_System` DEFAULT CHARACTER SET utf8 ;
USE `Studart_System` ;

-- -----------------------------------------------------
-- Table `Studart_System`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Studart_System`.`users` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `description` VARCHAR(200) NULL,
  `status` VARCHAR(45) NOT NULL,
  `school` VARCHAR(100) NULL,
  `imageData` LONGBLOB NULL,
  `imageName` VARCHAR(45) NULL,
  `imageType` VARCHAR(45) NULL,
  `imageURL` VARCHAR(100) NULL,
  UNIQUE INDEX `UserID_UNIQUE` (`userID` ASC) VISIBLE,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `Email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `Username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Studart_System`.`type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Studart_System`.`type` (
  `typeID` INT NOT NULL AUTO_INCREMENT,
  `typeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`typeID`),
  UNIQUE INDEX `TypeID_UNIQUE` (`typeID` ASC) VISIBLE,
  UNIQUE INDEX `TypeName_UNIQUE` (`typeName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Studart_System`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Studart_System`.`products` (
  `prodID` INT NOT NULL AUTO_INCREMENT,
  `prodName` VARCHAR(50) NOT NULL,
  `manufacDate` DATE NOT NULL,
  `prodDescription` VARCHAR(200) NULL,
  `price` DOUBLE NOT NULL,
  `productType` INT NOT NULL,
  `ownerID` INT NOT NULL,
  PRIMARY KEY (`prodID`),
  UNIQUE INDEX `ProdID_UNIQUE` (`prodID` ASC) VISIBLE,
  INDEX `fk_Products_ProductType1_idx` (`productType` ASC) VISIBLE,
  INDEX `fk_Products_Users1_idx` (`ownerID` ASC) VISIBLE,
  CONSTRAINT `fk_Products_ProductType1`
    FOREIGN KEY (`productType`)
    REFERENCES `Studart_System`.`type` (`typeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_Users1`
    FOREIGN KEY (`ownerID`)
    REFERENCES `Studart_System`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Studart_System`.`collections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Studart_System`.`collections` (
  `userID` INT NOT NULL,
  `prodID` INT NOT NULL,
  `purchaseDate` DATE NOT NULL,
  PRIMARY KEY (`userID`, `prodID`),
  INDEX `fk_Transaction_Products1_idx` (`prodID` ASC) VISIBLE,
  CONSTRAINT `fk_Transaction_Users1`
    FOREIGN KEY (`userID`)
    REFERENCES `Studart_System`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaction_Products1`
    FOREIGN KEY (`prodID`)
    REFERENCES `Studart_System`.`products` (`prodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Studart_System`.`admins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Studart_System`.`admins` (
  `adminID` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`adminID`),
  UNIQUE INDEX `AdminID_UNIQUE` (`adminID` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Studart_System`.`styles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Studart_System`.`styles` (
  `styleID` INT NOT NULL,
  `styleName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`styleID`),
  UNIQUE INDEX `StyleName_UNIQUE` (`styleName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Studart_System`.`images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Studart_System`.`images` (
  `imageID` INT NOT NULL AUTO_INCREMENT,
  `data` LONGBLOB NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `url` VARCHAR(100) NULL,
  `prodID` INT NOT NULL,
  PRIMARY KEY (`imageID`),
  INDEX `fk_ProductImages_Products_idx` (`prodID` ASC) VISIBLE,
  CONSTRAINT `fk_ProductImages_Products`
    FOREIGN KEY (`prodID`)
    REFERENCES `Studart_System`.`products` (`prodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Studart_System`.`productStyles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Studart_System`.`productStyles` (
  `prodID` INT NOT NULL,
  `styleID` INT NOT NULL,
  PRIMARY KEY (`prodID`, `styleID`),
  INDEX `fk_Products_has_ProductStyles_ProductStyles1_idx` (`styleID` ASC) VISIBLE,
  INDEX `fk_Products_has_ProductStyles_Products1_idx` (`prodID` ASC) VISIBLE,
  CONSTRAINT `fk_Products_has_ProductStyles_Products1`
    FOREIGN KEY (`prodID`)
    REFERENCES `Studart_System`.`products` (`prodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_ProductStyles_ProductStyles1`
    FOREIGN KEY (`styleID`)
    REFERENCES `Studart_System`.`styles` (`styleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Studart_System`.`favorite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Studart_System`.`favorite` (
  `userID` INT NOT NULL,
  `prodID` INT NOT NULL,
  PRIMARY KEY (`userID`, `prodID`),
  INDEX `fk_Users_has_Products_Users1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_Cart_Products1_idx` (`prodID` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Products_Users1`
    FOREIGN KEY (`userID`)
    REFERENCES `Studart_System`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cart_Products1`
    FOREIGN KEY (`prodID`)
    REFERENCES `Studart_System`.`products` (`prodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Studart_System`.`userTokens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Studart_System`.`userTokens` (
  `tokensID` INT NOT NULL AUTO_INCREMENT,
  `token` VARCHAR(255) NOT NULL,
  `userID` INT NOT NULL,
  PRIMARY KEY (`tokensID`),
  UNIQUE INDEX `TokensID_UNIQUE` (`tokensID` ASC) VISIBLE,
  INDEX `fk_Tokens_Users1_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `fk_Tokens_Users1`
    FOREIGN KEY (`userID`)
    REFERENCES `Studart_System`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Studart_System`.`adminTokens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Studart_System`.`adminTokens` (
  `tokensID` INT NOT NULL AUTO_INCREMENT,
  `token` VARCHAR(255) NOT NULL,
  `adminID` INT NOT NULL,
  PRIMARY KEY (`tokensID`),
  UNIQUE INDEX `TokensID_UNIQUE` (`tokensID` ASC) VISIBLE,
  INDEX `fk_TokensAdmin_Admins1_idx` (`adminID` ASC) VISIBLE,
  CONSTRAINT `fk_TokensAdmin_Admins1`
    FOREIGN KEY (`adminID`)
    REFERENCES `Studart_System`.`admins` (`adminID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Studart_System`.`approval`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Studart_System`.`approval` (
  `adminID` INT NOT NULL,
  `prodID` INT NOT NULL,
  `status` VARCHAR(30) NOT NULL,
  `approveDate` DATE NOT NULL,
  PRIMARY KEY (`adminID`, `prodID`),
  INDEX `fk_Admins_has_Products_Products1_idx` (`prodID` ASC) VISIBLE,
  INDEX `fk_Admins_has_Products_Admins1_idx` (`adminID` ASC) VISIBLE,
  CONSTRAINT `fk_Admins_has_Products_Admins1`
    FOREIGN KEY (`adminID`)
    REFERENCES `Studart_System`.`admins` (`adminID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Admins_has_Products_Products1`
    FOREIGN KEY (`prodID`)
    REFERENCES `Studart_System`.`products` (`prodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
