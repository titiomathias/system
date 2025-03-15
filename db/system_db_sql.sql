CREATE SCHEMA IF NOT EXISTS `system` DEFAULT CHARACTER SET utf8 ;
USE `system` ;

-- -----------------------------------------------------
-- Table `system`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system`.`users` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
;


-- -----------------------------------------------------
-- Table `system`.`aims`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system`.`aims` (
  `id` INT NOT NULL,
  `type` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(90) NOT NULL,
  `limit` DATE NOT NULL,
  `status` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_aims_users_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_aims_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `system`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `system`.`character`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system`.`character` (
  `id` INT NOT NULL,
  `legend` VARCHAR(45) NOT NULL,
  `level` INT NOT NULL,
  `xp` BIGINT NOT NULL,
  `gold` INT NOT NULL,
  `strong` INT NOT NULL,
  `dexterity` INT NOT NULL,
  `constituition` INT NOT NULL,
  `wisdom` INT NOT NULL,
  `intelligence` INT NOT NULL,
  `charisma` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_character_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_character_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `system`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `system`.`tasks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system`.`tasks` (
  `id` INT NOT NULL,
  `type` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(90) NOT NULL,
  `monitoring` TINYINT NOT NULL,
  `status` INT NOT NULL,
  `xp` BIGINT NOT NULL,
  `character_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tasks_character1_idx` (`character_id` ASC) VISIBLE,
  CONSTRAINT `fk_tasks_character1`
    FOREIGN KEY (`character_id`)
    REFERENCES `system`.`character` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `system`.`talents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system`.`talents` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `requirements` JSON NOT NULL,
  `buff` JSON NOT NULL,
  PRIMARY KEY (`id`))
;


-- -----------------------------------------------------
-- Table `system`.`character_has_talents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system`.`character_has_talents` (
  `character_id` INT NOT NULL,
  `talents_id` INT NOT NULL,
  PRIMARY KEY (`character_id`, `talents_id`),
  INDEX `fk_character_has_talents_talents1_idx` (`talents_id` ASC) VISIBLE,
  INDEX `fk_character_has_talents_character1_idx` (`character_id` ASC) VISIBLE,
  CONSTRAINT `fk_character_has_talents_character1`
    FOREIGN KEY (`character_id`)
    REFERENCES `system`.`character` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_character_has_talents_talents1`
    FOREIGN KEY (`talents_id`)
    REFERENCES `system`.`talents` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `system`.`achievements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system`.`achievements` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `rarity` INT NOT NULL,
  PRIMARY KEY (`id`))
;


-- -----------------------------------------------------
-- Table `system`.`users_has_achievements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system`.`users_has_achievements` (
  `users_id` INT NOT NULL,
  `achievements_id` INT NOT NULL,
  PRIMARY KEY (`users_id`, `achievements_id`),
  INDEX `fk_users_has_achievements_achievements1_idx` (`achievements_id` ASC) VISIBLE,
  INDEX `fk_users_has_achievements_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_achievements_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `system`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_achievements_achievements1`
    FOREIGN KEY (`achievements_id`)
    REFERENCES `system`.`achievements` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
