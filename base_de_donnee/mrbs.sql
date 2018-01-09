-- phpMyAdmin SQL Dump
-- version 4.7.5
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le :  lun. 08 jan. 2018 à 16:12
-- Version du serveur :  5.7.19
-- Version de PHP :  7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `mrbs`
--

-- --------------------------------------------------------

--
-- Structure de la table `mrbs_area`
--

CREATE TABLE `mrbs_area` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `area_name` varchar(30) DEFAULT NULL,
  `sort_key` varchar(30) NOT NULL DEFAULT '',
  `timezone` varchar(50) DEFAULT NULL,
  `area_admin_email` text,
  `resolution` int(11) DEFAULT NULL,
  `default_duration` int(11) DEFAULT NULL,
  `default_duration_all_day` tinyint(1) NOT NULL DEFAULT '0',
  `morningstarts` int(11) DEFAULT NULL,
  `morningstarts_minutes` int(11) DEFAULT NULL,
  `eveningends` int(11) DEFAULT NULL,
  `eveningends_minutes` int(11) DEFAULT NULL,
  `private_enabled` tinyint(1) DEFAULT NULL,
  `private_default` tinyint(1) DEFAULT NULL,
  `private_mandatory` tinyint(1) DEFAULT NULL,
  `private_override` varchar(32) DEFAULT NULL,
  `min_create_ahead_enabled` tinyint(1) DEFAULT NULL,
  `min_create_ahead_secs` int(11) DEFAULT NULL,
  `max_create_ahead_enabled` tinyint(1) DEFAULT NULL,
  `max_create_ahead_secs` int(11) DEFAULT NULL,
  `min_delete_ahead_enabled` tinyint(1) DEFAULT NULL,
  `min_delete_ahead_secs` int(11) DEFAULT NULL,
  `max_delete_ahead_enabled` tinyint(1) DEFAULT NULL,
  `max_delete_ahead_secs` int(11) DEFAULT NULL,
  `max_per_day_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_day` int(11) NOT NULL DEFAULT '0',
  `max_per_week_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_week` int(11) NOT NULL DEFAULT '0',
  `max_per_month_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_month` int(11) NOT NULL DEFAULT '0',
  `max_per_year_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_year` int(11) NOT NULL DEFAULT '0',
  `max_per_future_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_future` int(11) NOT NULL DEFAULT '0',
  `max_duration_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_duration_secs` int(11) NOT NULL DEFAULT '0',
  `max_duration_periods` int(11) NOT NULL DEFAULT '0',
  `custom_html` text,
  `approval_enabled` tinyint(1) DEFAULT NULL,
  `reminders_enabled` tinyint(1) DEFAULT NULL,
  `enable_periods` tinyint(1) DEFAULT NULL,
  `confirmation_enabled` tinyint(1) DEFAULT NULL,
  `confirmed_default` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `mrbs_area`
--

INSERT INTO `mrbs_area` (`id`, `disabled`, `area_name`, `sort_key`, `timezone`, `area_admin_email`, `resolution`, `default_duration`, `default_duration_all_day`, `morningstarts`, `morningstarts_minutes`, `eveningends`, `eveningends_minutes`, `private_enabled`, `private_default`, `private_mandatory`, `private_override`, `min_create_ahead_enabled`, `min_create_ahead_secs`, `max_create_ahead_enabled`, `max_create_ahead_secs`, `min_delete_ahead_enabled`, `min_delete_ahead_secs`, `max_delete_ahead_enabled`, `max_delete_ahead_secs`, `max_per_day_enabled`, `max_per_day`, `max_per_week_enabled`, `max_per_week`, `max_per_month_enabled`, `max_per_month`, `max_per_year_enabled`, `max_per_year`, `max_per_future_enabled`, `max_per_future`, `max_duration_enabled`, `max_duration_secs`, `max_duration_periods`, `custom_html`, `approval_enabled`, `reminders_enabled`, `enable_periods`, `confirmation_enabled`, `confirmed_default`) VALUES
(1, 0, 'UHA 4.0', 'UHA 4.0', 'Europe/Paris', '', 1800, 1800, 0, 9, 0, 16, 30, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 0, 0, 604800, 0, 1, 0, 5, 0, 10, 0, 50, 0, 100, 0, 7200, 2, '', 0, 1, 0, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `mrbs_entry`
--

CREATE TABLE `mrbs_entry` (
  `id` int(11) NOT NULL,
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `entry_type` int(11) NOT NULL DEFAULT '0',
  `repeat_id` int(11) DEFAULT NULL,
  `room_id` int(11) NOT NULL DEFAULT '1',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(80) NOT NULL DEFAULT '',
  `modified_by` varchar(80) NOT NULL DEFAULT '',
  `name` varchar(20) NOT NULL DEFAULT '',
  `type` char(1) NOT NULL DEFAULT 'E',
  `description` varchar(150) DEFAULT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `reminded` int(11) DEFAULT NULL,
  `info_time` int(11) DEFAULT NULL,
  `info_user` varchar(80) DEFAULT NULL,
  `info_text` text,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0',
  `ical_recur_id` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `mrbs_repeat`
--

CREATE TABLE `mrbs_repeat` (
  `id` int(11) NOT NULL,
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `rep_type` int(11) NOT NULL DEFAULT '0',
  `end_date` int(11) NOT NULL DEFAULT '0',
  `rep_opt` varchar(32) NOT NULL DEFAULT '',
  `room_id` int(11) NOT NULL DEFAULT '1',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(80) NOT NULL DEFAULT '',
  `modified_by` varchar(80) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `type` char(1) NOT NULL DEFAULT 'E',
  `description` text,
  `rep_num_weeks` smallint(6) DEFAULT NULL,
  `month_absolute` smallint(6) DEFAULT NULL,
  `month_relative` varchar(4) DEFAULT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `reminded` int(11) DEFAULT NULL,
  `info_time` int(11) DEFAULT NULL,
  `info_user` varchar(80) DEFAULT NULL,
  `info_text` text,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `mrbs_room`
--

CREATE TABLE `mrbs_room` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `area_id` int(11) NOT NULL DEFAULT '0',
  `room_name` varchar(25) NOT NULL DEFAULT '',
  `sort_key` varchar(25) NOT NULL DEFAULT '',
  `description` varchar(60) DEFAULT NULL,
  `capacity` int(11) NOT NULL DEFAULT '0',
  `room_admin_email` text,
  `custom_html` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `mrbs_room`
--

INSERT INTO `mrbs_room` (`id`, `disabled`, `area_id`, `room_name`, `sort_key`, `description`, `capacity`, `room_admin_email`, `custom_html`) VALUES
(7, 0, 1, 'Salle Bartholdi', 'Salle Bartholdi', '', 0, 'florent.bourgeois@uha.fr', NULL),
(8, 0, 1, 'Salle Conf', 'Salle Conf', '', 0, 'florent.bourgeois@uha.fr', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `mrbs_users`
--

CREATE TABLE `mrbs_users` (
  `id` int(11) NOT NULL,
  `level` smallint(6) NOT NULL DEFAULT '0',
  `name` varchar(17) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `email` varchar(75) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `mrbs_users`
--

INSERT INTO `mrbs_users` (`id`, `level`, `name`, `password_hash`, `email`) VALUES
(6, 2, 'etrit', '$2y$10$jI3OH5OgFtf4vhRFM9k5Oek5Q/kmFtnZVaZASYR/EpdRZN7uo9pV2', 'etrithalili@gmail.com'),
(7, 2, 'florent', '$2y$10$MHz533rWRV7b7UBE49Sw.ehXiydZHvWbOi4Xmuy/FbFOZno0j7/sC', 'florent.bourgeois@uha.fr');

-- --------------------------------------------------------

--
-- Structure de la table `mrbs_variables`
--

CREATE TABLE `mrbs_variables` (
  `id` int(11) NOT NULL,
  `variable_name` varchar(80) DEFAULT NULL,
  `variable_content` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `mrbs_variables`
--

INSERT INTO `mrbs_variables` (`id`, `variable_name`, `variable_content`) VALUES
(1, 'db_version', '49'),
(2, 'local_db_version', '1');

-- --------------------------------------------------------

--
-- Structure de la table `mrbs_zoneinfo`
--

CREATE TABLE `mrbs_zoneinfo` (
  `id` int(11) NOT NULL,
  `timezone` varchar(255) NOT NULL DEFAULT '',
  `outlook_compatible` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `vtimezone` text,
  `last_updated` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `mrbs_zoneinfo`
--

INSERT INTO `mrbs_zoneinfo` (`id`, `timezone`, `outlook_compatible`, `vtimezone`, `last_updated`) VALUES
(1, 'Europe/Paris', 1, 'BEGIN:VTIMEZONE\r\nTZID:Europe/Paris\r\nTZURL:http://tzurl.org/zoneinfo-outlook/Europe/Paris\r\nX-LIC-LOCATION:Europe/Paris\r\nBEGIN:DAYLIGHT\r\nTZOFFSETFROM:+0100\r\nTZOFFSETTO:+0200\r\nTZNAME:CEST\r\nDTSTART:19700329T020000\r\nRRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU\r\nEND:DAYLIGHT\r\nBEGIN:STANDARD\r\nTZOFFSETFROM:+0200\r\nTZOFFSETTO:+0100\r\nTZNAME:CET\r\nDTSTART:19701025T030000\r\nRRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU\r\nEND:STANDARD\r\nEND:VTIMEZONE', 1515407297);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `mrbs_area`
--
ALTER TABLE `mrbs_area`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_area_name` (`area_name`);

--
-- Index pour la table `mrbs_entry`
--
ALTER TABLE `mrbs_entry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `repeat_id` (`repeat_id`),
  ADD KEY `idxStartTime` (`start_time`),
  ADD KEY `idxEndTime` (`end_time`);

--
-- Index pour la table `mrbs_repeat`
--
ALTER TABLE `mrbs_repeat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`);

--
-- Index pour la table `mrbs_room`
--
ALTER TABLE `mrbs_room`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_room_name` (`area_id`,`room_name`),
  ADD KEY `idxSortKey` (`sort_key`);

--
-- Index pour la table `mrbs_users`
--
ALTER TABLE `mrbs_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_name` (`name`);

--
-- Index pour la table `mrbs_variables`
--
ALTER TABLE `mrbs_variables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_variable_name` (`variable_name`);

--
-- Index pour la table `mrbs_zoneinfo`
--
ALTER TABLE `mrbs_zoneinfo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_timezone` (`timezone`,`outlook_compatible`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `mrbs_area`
--
ALTER TABLE `mrbs_area`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `mrbs_entry`
--
ALTER TABLE `mrbs_entry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=287;

--
-- AUTO_INCREMENT pour la table `mrbs_repeat`
--
ALTER TABLE `mrbs_repeat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `mrbs_room`
--
ALTER TABLE `mrbs_room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `mrbs_users`
--
ALTER TABLE `mrbs_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `mrbs_variables`
--
ALTER TABLE `mrbs_variables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `mrbs_zoneinfo`
--
ALTER TABLE `mrbs_zoneinfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `mrbs_entry`
--
ALTER TABLE `mrbs_entry`
  ADD CONSTRAINT `mrbs_entry_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `mrbs_room` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `mrbs_entry_ibfk_2` FOREIGN KEY (`repeat_id`) REFERENCES `mrbs_repeat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `mrbs_repeat`
--
ALTER TABLE `mrbs_repeat`
  ADD CONSTRAINT `mrbs_repeat_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `mrbs_room` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `mrbs_room`
--
ALTER TABLE `mrbs_room`
  ADD CONSTRAINT `mrbs_room_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `mrbs_area` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
