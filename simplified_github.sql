-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema suunnittelutehtava2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema suunnittelutehtava2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `suunnittelutehtava2` DEFAULT CHARACTER SET utf8 ;
USE `suunnittelutehtava2` ;

-- -----------------------------------------------------
-- Table `suunnittelutehtava2`.`ticket_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava2`.`ticket_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` ENUM('bug', 'feature') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava2`.`tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava2`.`tickets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `creation_date` DATETIME NOT NULL,
  `ticket_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tickets_ticket_type1_idx` (`ticket_type_id` ASC),
  CONSTRAINT `fk_tickets_ticket_type1`
    FOREIGN KEY (`ticket_type_id`)
    REFERENCES `suunnittelutehtava2`.`ticket_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava2`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava2`.`projects` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` TEXT NULL,
  `name` VARCHAR(255) NOT NULL,
  `creation_date` DATETIME NOT NULL,
  `edit_date` DATETIME NOT NULL,
  `tickets_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_projects_tickets1_idx` (`tickets_id` ASC),
  CONSTRAINT `fk_projects_tickets1`
    FOREIGN KEY (`tickets_id`)
    REFERENCES `suunnittelutehtava2`.`tickets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava2`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava2`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `role` ENUM('admin', 'user') NOT NULL,
  `tickets_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_users_tickets1_idx` (`tickets_id` ASC),
  CONSTRAINT `fk_users_tickets1`
    FOREIGN KEY (`tickets_id`)
    REFERENCES `suunnittelutehtava2`.`tickets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava2`.`ticket_handlers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava2`.`ticket_handlers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `assigned` DATETIME NOT NULL,
  `users_id` INT NOT NULL,
  `working_time_min` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ticket_handlers_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_ticket_handlers_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `suunnittelutehtava2`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava2`.`projects_has_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava2`.`projects_has_users` (
  `projects_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`projects_id`, `users_id`),
  INDEX `fk_projects_has_users_users1_idx` (`users_id` ASC),
  INDEX `fk_projects_has_users_projects_idx` (`projects_id` ASC),
  CONSTRAINT `fk_projects_has_users_projects`
    FOREIGN KEY (`projects_id`)
    REFERENCES `suunnittelutehtava2`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projects_has_users_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `suunnittelutehtava2`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suunnittelutehtava2`.`tickets_has_ticket_handlers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suunnittelutehtava2`.`tickets_has_ticket_handlers` (
  `tickets_id` INT NOT NULL,
  `ticket_handlers_id` INT NOT NULL,
  PRIMARY KEY (`tickets_id`, `ticket_handlers_id`),
  INDEX `fk_tickets_has_ticket_handlers_ticket_handlers1_idx` (`ticket_handlers_id` ASC),
  INDEX `fk_tickets_has_ticket_handlers_tickets1_idx` (`tickets_id` ASC),
  CONSTRAINT `fk_tickets_has_ticket_handlers_tickets1`
    FOREIGN KEY (`tickets_id`)
    REFERENCES `suunnittelutehtava2`.`tickets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tickets_has_ticket_handlers_ticket_handlers1`
    FOREIGN KEY (`ticket_handlers_id`)
    REFERENCES `suunnittelutehtava2`.`ticket_handlers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
