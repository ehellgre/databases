-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema suunnittelutehtava1_emil_hellgren
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema suunnittelutehtava1_emil_hellgren
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `suunnittelutehtava1_emil_hellgren` DEFAULT CHARACTER SET utf8 ;
USE `suunnittelutehtava1_emil_hellgren` ;

-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`customers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`phone_numbers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`phone_numbers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `phone_number` VARCHAR(45) NOT NULL,
  `customers_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC),
  INDEX `fk_phone_numbers_customers_idx` (`customers_id` ASC),
  CONSTRAINT `fk_phone_numbers_customers`
    FOREIGN KEY (`customers_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`countries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `country_name_UNIQUE` (`country_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`cities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NOT NULL,
  `countries_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cities_countries1_idx` (`countries_id` ASC),
  CONSTRAINT `fk_cities_countries1`
    FOREIGN KEY (`countries_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`zip_codes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`zip_codes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `zip_code` VARCHAR(45) NOT NULL,
  `cities_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `zip_code_UNIQUE` (`zip_code` ASC),
  INDEX `fk_zip_codes_cities1_idx` (`cities_id` ASC),
  CONSTRAINT `fk_zip_codes_cities1`
    FOREIGN KEY (`cities_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`addresses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street_address` VARCHAR(45) NOT NULL,
  `customers_id` INT NOT NULL,
  `zip_codes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_addresses_customers1_idx` (`customers_id` ASC),
  UNIQUE INDEX `customers_id_UNIQUE` (`customers_id` ASC),
  INDEX `fk_addresses_zip_codes1_idx` (`zip_codes_id` ASC),
  CONSTRAINT `fk_addresses_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addresses_zip_codes1`
    FOREIGN KEY (`zip_codes_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`zip_codes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`cars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`cars` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `brand` VARCHAR(45) NOT NULL,
  `hourly_price` FLOAT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`rentals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`rentals` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customers_id` INT NOT NULL,
  `cars_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_rentals_customers1_idx` (`customers_id` ASC) VISIBLE,
  INDEX `fk_rentals_cars1_idx` (`cars_id` ASC) VISIBLE,
  CONSTRAINT `fk_rentals_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rentals_cars1`
    FOREIGN KEY (`cars_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`cars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`system_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`system_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `role` ENUM('customer_service', 'management') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`transmission_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`transmission_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `transmission` ENUM('automatic', 'manual') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`registration_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`registration_year` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `year` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`models`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`models` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(45) NOT NULL,
  `cars_id` INT NOT NULL,
  `transmission_type_id` INT NOT NULL,
  `registration_year_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_models_cars1_idx` (`cars_id` ASC) VISIBLE,
  INDEX `fk_models_transmission_type1_idx` (`transmission_type_id` ASC),
  INDEX `fk_models_registration_year1_idx` (`registration_year_id` ASC),
  CONSTRAINT `fk_models_cars1`
    FOREIGN KEY (`cars_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`cars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_models_transmission_type1`
    FOREIGN KEY (`transmission_type_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`transmission_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_models_registration_year1`
    FOREIGN KEY (`registration_year_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`registration_year` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`system_users_has_customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`system_users_has_customers` (
  `system_users_id` INT NOT NULL,
  `customers_id` INT NOT NULL,
  PRIMARY KEY (`system_users_id`, `customers_id`),
  INDEX `fk_system_users_has_customers_customers1_idx` (`customers_id` ASC),
  INDEX `fk_system_users_has_customers_system_users1_idx` (`system_users_id` ASC),
  CONSTRAINT `fk_system_users_has_customers_system_users1`
    FOREIGN KEY (`system_users_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`system_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_system_users_has_customers_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`system_users_has_rentals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`system_users_has_rentals` (
  `system_users_id` INT NOT NULL,
  `rentals_id` INT NOT NULL,
  PRIMARY KEY (`system_users_id`, `rentals_id`),
  INDEX `fk_system_users_has_rentals_rentals1_idx` (`rentals_id` ASC),
  INDEX `fk_system_users_has_rentals_system_users1_idx` (`system_users_id` ASC),
  CONSTRAINT `fk_system_users_has_rentals_system_users1`
    FOREIGN KEY (`system_users_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`system_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_system_users_has_rentals_rentals1`
    FOREIGN KEY (`rentals_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`rentals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava1_emil_hellgren`.`credentials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava1_emil_hellgren`.`credentials` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `system_users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_credentials_system_users1_idx` (`system_users_id` ASC),
  CONSTRAINT `fk_credentials_system_users1`
    FOREIGN KEY (`system_users_id`)
    REFERENCES `suunnittelutehtava1_emil_hellgren`.`system_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
