--1 Mettez à jour les prix unitaires des lignes de commande.
UPDATE ligne l
JOIN produit p
USING(id_produit)
SET l.pu = p.pu;

--2 Mettez à jour les totaux des commandes.
UPDATE commande c
SET c.total = (
	SELECT SUM(l.pu * l.quantite)
	FROM ligne l
	WHERE c.id_commande = l.id_commande
);

--3 Sélectionnez les noms complets des utilisateurs avec le nom en majuscules suivi du prénom séparés par un espace (alias NOM_Prenom). Tri dans l'ordre alphabétique.
SELECT CONCAT(UPPER(nom), ' ', prenom) NOM_prenom
FROM user
ORDER BY nom, prenom;

--4 Dénombrez les utilisateurs dont le nom ne contient pas la lettre A (alias nb).
SELECT COUNT(*) nb
FROM user
WHERE nom NOT LIKE '%A%';

--5 Pour les utilisateurs dont le mot de passe comporte strictement moins de 6 caractères, sélectionnez l'email et le nombre de caractères du mot de passe (alias longueur_mdp). Tri sur la longueur du mot de passe en ordre descendant.
SELECT email, CHAR_LENGTH(mdp) longueur_mdp
FROM user
HAVING longueur_mdp < 6
ORDER BY longueur_mdp DESC;

--6 Dénombrez les produits archivés (alias nb).
SELECT COUNT(*) nb
FROM produit
WHERE archive;

--7 Sélectionnez la valeur du stock (alias valeur_stock).
SELECT SUM(pu * stock) valeur_stock
FROM produit;

--8 Sélectionnez le montant du panier moyen (alias panier_moyen).
SELECT AVG(total) panier_moyen
FROM commande;

--9 Pour chaque catégorie, sélectionnez le nom et le nombre de produits (alias nb). Tri par nom et nombre de produits.
SELECT c.nom, COUNT(p.id_produit) nb
FROM categorie
LEFT JOIN produit
USING(id_categorie)
GROUP BY c.nom
ORDER BY c.nom, nb;

--10 Dénombrer les utilisateurs ayant commandé (alias nb).
SELECT COUNT(DISTINCT id_user) nb
FROM commande;

--11 Sélectionnez le nom et le prénom des utilisateurs n'ayant jamais commandé.
SELECT u.nom, u.prenom
FROM user u
LEFT JOIN commande c
USING(id_user)
WHERE ISNULL(c.id_user);

--12 Sélectionnez les noms et quantités (alias ventes) des 2 produits les plus vendus.
SELECT p.nom, SUM(l.quantite) ventes
FROM produit p
JOIN ligne l
USING(id_produit)
GROUP BY l.id_produit
ORDER BY ventes DESC
LIMIT 2;

--13 Sélectionnez la référence des produits n'ayant jamais été commandés. Tri par référence.
SELECT p.ref
FROM produit p
LEFT JOIN ligne l
USING(id_produit)
WHERE ISNULL(l.id_produit)
ORDER BY p.ref;

--14 Sélectionnez le nom de la catégorie dont aucun produit n'a été commandé.
SELECT c.nom
FROM categorie c
LEFT JOIN produit p USING(id_categorie)
LEFT JOIN ligne l USING(id_produit)
GROUP BY c.id_categorie
HAVING COUNT(l.id_produit) = 0;

--15 Sélectionnez le nom et le prénom des utilisateurs, l'id_commande et la date de commande des commandes remontant strictement à plus de 3 jours. Tri par nom puis prénom.
-- Approximativement 3 jours :
SELECT u.nom, u.prenom, c.id_commande, c.date_commande
FROM user u
JOIN commande c
USING(id_user)
WHERE DATEDIFF(NOW(), c.date_commande) > 3
ORDER BY u.nom, u.prenom;
-- Précisément 72 heures :
SELECT u.nom, u.prenom, c.id_commande, c.date_commande
FROM user u
JOIN commande c
USING(id_user)
WHERE DATE_ADD(c.date_commande, INTERVAL 3 DAY) < NOW()
ORDER BY u.nom, u.prenom;

--16 Sélectionnez le nom et le prénom des utilisateurs (sans doublon) ayant commandé avant 08h00 exclus ou après 20h00 exclus.
SELECT DISTINCT u.nom, u.prenom
FROM user u
JOIN commande c
USING(id_user)
WHERE HOUR(c.date_commande) NOT BETWEEN 8 AND 20;

--17 Sélectionnez le nom de la catégorie (alias cat), le nom du produit, le prix unitaire, la quantité et le sous-total (alias sous_total) de chaque ligne de commande de l'utilisateur dont l'id_user est 3. Tri par nom de produit. Le produit sans catégorie doit apparaître.
SET @ID_USER = 3;
SELECT c.nom cat,
       p.nom,
       l.pu,
       l.quantite,
       l.pu * l.quantite sous_total
FROM produit p
LEFT JOIN categorie c
USING(id_categorie)
JOIN ligne l
USING(id_produit)
JOIN commande com
USING(id_commande)
WHERE com.id_user = @ID_USER
ORDER BY produit.nom;

--18 Sélectionnez le nom et le stock des produits dont le stock est inférieur à la moyenne des stocks.
SELECT p1.nom, p1.stock
FROM produit p1
JOIN produit p2
GROUP BY p1.id_produit
HAVING p1.stock < AVG(p2.stock);

--19 Supprimez les utilisateurs n'ayant pas commandé.
DELETE user
FROM user
LEFT JOIN commande USING(id_user)
WHERE commande.id_user IS NULL;

--20 Supprimez le produit le moins cher.
DELETE FROM produit
ORDER BY pu
LIMIT 1;


