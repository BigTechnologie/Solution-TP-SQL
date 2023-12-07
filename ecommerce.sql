-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 07 déc. 2023 à 07:42
-- Version du serveur : 8.0.31
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ecommerce`
--

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `id_categorie` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`id_categorie`, `nom`) VALUES
(1, 'Romans'),
(2, 'BD'),
(3, 'Voyages'),
(4, 'Sport');

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `id_commande` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` int UNSIGNED DEFAULT NULL,
  `date_commande` datetime DEFAULT NULL,
  `total` decimal(8,2) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id_commande`),
  KEY `fk_commande_user1_idx` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`id_commande`, `id_user`, `date_commande`, `total`) VALUES
(1, 2, '2019-04-29 09:00:00', '25.99'),
(2, 3, '2019-04-01 23:00:00', '102.30'),
(3, 3, '2019-04-10 07:00:00', '83.00');

-- --------------------------------------------------------

--
-- Structure de la table `ligne`
--

DROP TABLE IF EXISTS `ligne`;
CREATE TABLE IF NOT EXISTS `ligne` (
  `id_ligne` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_commande` int UNSIGNED DEFAULT NULL,
  `id_produit` int UNSIGNED DEFAULT NULL,
  `quantite` mediumint UNSIGNED DEFAULT NULL,
  `pu` decimal(6,2) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id_ligne`),
  KEY `fk_ligne_commande1_idx` (`id_commande`),
  KEY `fk_ligne_produit1_idx` (`id_produit`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ligne`
--

INSERT INTO `ligne` (`id_ligne`, `id_commande`, `id_produit`, `quantite`, `pu`) VALUES
(1, 1, 3, 1, '25.99'),
(2, 2, 1, 3, '21.50'),
(3, 2, 4, 2, '18.90'),
(4, 3, 4, 2, '18.90'),
(5, 3, 5, 1, '45.20');

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

DROP TABLE IF EXISTS `produit`;
CREATE TABLE IF NOT EXISTS `produit` (
  `id_produit` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_categorie` int UNSIGNED DEFAULT NULL,
  `ref` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pu` decimal(6,2) UNSIGNED DEFAULT NULL,
  `stock` int UNSIGNED DEFAULT NULL,
  `archive` tinyint UNSIGNED DEFAULT '0',
  PRIMARY KEY (`id_produit`),
  KEY `fk_produit_categorie_idx` (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id_produit`, `id_categorie`, `ref`, `nom`, `pu`, `stock`, `archive`) VALUES
(1, 1, 'ROMWDN', 'Watership Down', '21.50', 4, 0),
(2, 3, 'ROMBNW', 'The Brave New World', '9.10', 12, 0),
(3, 2, 'BDSMN', 'Sand Man', '25.99', 20, 0),
(4, 2, 'BDLVF', 'Les Vieux Fourneaux', '18.90', 250, 0),
(5, NULL, 'LCPLN', 'La Compta Pour Les Nuls', '45.20', 1, 0),
(6, 2, 'MON', 'Monstres', '30.00', 2, 1);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prenom` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mdp` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id_user`, `nom`, `prenom`, `email`, `mdp`) VALUES
(1, 'Jean', 'Leon', 'jean.leon@free.fr', 'coucou'),
(2, 'EL Barbary', 'Farid', 'el.barbary.farid@gmail.com', 'lee'),
(3, 'Ibrahima', 'Diallo', 'ibra.diallo@wanadoo.fr', '1234'),
(4, 'Maxime', 'Boutry', 'maxime.boutry@dawan.fr', 'azerty');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `fk_commande_user1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`);

--
-- Contraintes pour la table `ligne`
--
ALTER TABLE `ligne`
  ADD CONSTRAINT `fk_ligne_commande1` FOREIGN KEY (`id_commande`) REFERENCES `commande` (`id_commande`),
  ADD CONSTRAINT `fk_ligne_produit1` FOREIGN KEY (`id_produit`) REFERENCES `produit` (`id_produit`);

--
-- Contraintes pour la table `produit`
--
ALTER TABLE `produit`
  ADD CONSTRAINT `fk_produit_categorie` FOREIGN KEY (`id_categorie`) REFERENCES `categorie` (`id_categorie`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
