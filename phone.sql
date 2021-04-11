

CREATE TABLE `palm_phone` (
	`id` int NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(50) NOT NULL,
	`profil_resmi` varchar(255) NOT NULL,
	`telefon_paketi` int NOT NULL,
	`arka_plan` int NOT NULL,

	PRIMARY KEY (`id`)
);