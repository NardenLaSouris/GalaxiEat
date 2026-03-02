-- ===============================
-- SUPPRESSION DES TABLES SI ELLES EXISTENT
-- Permet d'éviter une erreur si on relance le script
-- L'ordre est important à cause des clés étrangères
-- ===============================

DROP TABLE IF EXISTS DishIngredients;
DROP TABLE IF EXISTS Ingredients;
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS CustomerOrders;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Dishes;
DROP TABLE IF EXISTS Restaurants;

-- ===============================
-- CREATION DES TABLES
-- ===============================

-- Table des restaurants
CREATE TABLE Restaurants (
    IdRestaurant INT PRIMARY KEY, -- Identifiant unique du restaurant
    Name VARCHAR(100) NOT NULL,   -- Nom du restaurant (obligatoire)
    Planet VARCHAR(100) NOT NULL, -- Planète où il se situe
    Opening_year INT              -- Année d’ouverture
);

-- Table des employés
CREATE TABLE Employees (
    IdEmployees INT PRIMARY KEY, -- Identifiant unique employé
    Firstname VARCHAR(100) NOT NULL,
    Lastname VARCHAR(100) NOT NULL,
    Role VARCHAR(100),           -- Poste (Manager, Serveur, etc.)
    IdRestaurant INT,            -- Restaurant auquel il est rattaché
    hire_date DATE,              -- Date d’embauche
    FOREIGN KEY (IdRestaurant) REFERENCES Restaurants(IdRestaurant) 
    -- Clé étrangère vers Restaurants
);

-- Table des plats
CREATE TABLE Dishes (
    IdDishes INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2), -- Prix avec 2 décimales
    Category VARCHAR(100),
    is_vegan BOOLEAN NULL -- TRUE / FALSE / NULL (inconnu)
);

-- Table des commandes clients
CREATE TABLE CustomerOrders (
    IdOrders INT PRIMARY KEY,
    IdRestaurant INT,
    Total_amount DECIMAL(10,2),
    Customer_name VARCHAR(100),
    FOREIGN KEY (IdRestaurant) REFERENCES Restaurants(IdRestaurant)
);

-- Table intermédiaire entre commandes et plats
-- Une commande peut contenir plusieurs plats
CREATE TABLE OrderItems (
    IdOrderItems INT PRIMARY KEY,
    IdOrders INT,
    IdDishes INT,
    Quantity INT,
    FOREIGN KEY (IdOrders) REFERENCES CustomerOrders(IdOrders),
    FOREIGN KEY (IdDishes) REFERENCES Dishes(IdDishes)
);

-- ===============================
-- INSERTION DES DONNEES
-- ===============================

-- Ajout de restaurants
INSERT INTO Restaurants (Name, Planet, Opening_year) VALUES
(...);

-- Ajout des employés
INSERT INTO Employees (Firstname, Lastname, Role, IdRestaurant, hire_date) VALUES
(...);

-- Ajout des plats
INSERT INTO Dishes (Name, Price, Category, is_vegan) VALUES
(...);

-- Ajout des commandes
INSERT INTO CustomerOrders (IdRestaurant, Total_amount, Customer_name) VALUES
(...);

-- Ajout des lignes de commande
INSERT INTO OrderItems (IdOrders, IdDishes, Quantity) VALUES
(...);

-- ===============================
-- REQUETES SIMPLES
-- ===============================

SELECT * FROM Restaurants; 
-- Affiche tous les restaurants

SELECT * FROM Dishes ORDER BY Price DESC;
-- Trie les plats du plus cher au moins cher

SELECT * FROM Employees ORDER BY Role;
-- Trie les employés par rôle

SELECT * FROM Dishes WHERE is_vegan = TRUE;
-- Affiche uniquement les plats végan

SELECT * FROM Dishes WHERE Price > (SELECT AVG(Price) FROM Dishes);
-- Plats plus chers que la moyenne

SELECT * FROM Dishes WHERE is_vegan IS NULL;
-- Plats dont on ne connaît pas le statut végan

SELECT * FROM Employees WHERE hire_date IS NULL;
-- Employés sans date d'embauche

-- ===============================
-- REQUETE AVEC JOINS ET AGRÉGATION
-- ===============================

SELECT
    co.IdOrders,
    SUM(oi.Quantity) AS Total_articles, -- Total d’articles par commande
    SUM(oi.Quantity * d.Price) AS Total_calculated -- Total recalculé
FROM CustomerOrders co
JOIN OrderItems oi ON co.IdOrders = oi.IdOrders
JOIN Dishes d ON oi.IdDishes = d.IdDishes
GROUP BY co.IdOrders;

-- ===============================
-- AUTRES JOINS
-- ===============================

SELECT e.Firstname, e.Lastname, e.Role, r.Name AS Restaurant
FROM Employees e
JOIN Restaurants r ON e.IdRestaurant = r.IdRestaurant;
-- Associe chaque employé à son restaurant

SELECT
    d.Name AS Dish,
    co.Customer_name,
    r.Planet
FROM OrderItems oi
JOIN Dishes d ON oi.IdDishes = d.IdDishes
JOIN CustomerOrders co ON oi.IdOrders = co.IdOrders
JOIN Restaurants r ON co.IdRestaurant = r.IdRestaurant;
-- Montre quel client a commandé quel plat et sur quelle planète

-- ===============================
-- COUNT + LEFT JOIN
-- ===============================

SELECT
    r.Name,
    COUNT(e.IdEmployees) AS Nombre_employes
FROM Restaurants r
LEFT JOIN Employees e ON r.IdRestaurant = e.IdRestaurant
GROUP BY r.Name;
-- Compte les employés par restaurant (même ceux sans employés)

-- ===============================
-- UPDATE avec CASE
-- ===============================

UPDATE Dishes
SET Price =
    CASE
        WHEN Price > 12 THEN Price * 0.90 -- -10%
        ELSE Price * 0.95                 -- -5%
    END;
-- Applique une réduction selon le prix

-- ===============================
-- DELETE
-- ===============================

DELETE FROM Dishes WHERE Price IS NULL;
-- Supprime les plats sans prix

DELETE FROM CustomerOrders WHERE Total_amount < 5;
-- Supprime les petites commandes

-- ===============================
-- GROUP BY + AGRÉGATS
-- ===============================

SELECT Category, AVG(Price) AS Prix_moyen
FROM Dishes
GROUP BY Category;
-- Prix moyen par catégorie

SELECT SUM(Total_amount) AS Total_ventes
FROM CustomerOrders;
-- Total des ventes

SELECT * FROM Dishes ORDER BY Price DESC LIMIT 3;
-- Top 3 plats les plus chers

SELECT * FROM Employees
WHERE Lastname LIKE '%a%' OR Firstname LIKE '%a%';
-- Employés contenant la lettre "a"

-- ===============================
-- TABLES POUR LES INGREDIENTS
-- ===============================

CREATE TABLE Ingredients (
    IdIngredient INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL
);
-- Table des ingrédients

CREATE TABLE DishIngredients (
    IdDishes INT,
    IdIngredient INT,
    PRIMARY KEY (IdDishes, IdIngredient),
    FOREIGN KEY (IdDishes) REFERENCES Dishes(IdDishes),
    FOREIGN KEY (IdIngredient) REFERENCES Ingredients(IdIngredient)
);
-- Table de liaison plat / ingrédient (relation N-N)

-- ===============================
-- REQUETES FINALES
-- ===============================

SELECT * FROM Dishes WHERE is_vegan = TRUE;
-- Vérification plats végan

SELECT * FROM Restaurants ORDER BY Opening_year ASC;
-- Restaurants du plus ancien au plus récent

SELECT * FROM CustomerOrders ORDER BY Total_amount DESC LIMIT 1;
-- Plus grosse commande