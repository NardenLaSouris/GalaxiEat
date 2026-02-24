DROP TABLE IF EXISTS DishIngredients;
DROP TABLE IF EXISTS Ingredients;
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS CustomerOrders;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Dishes;
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    IdRestaurant INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Planet VARCHAR(100) NOT NULL,
    Opening_year INT
);

CREATE TABLE Employees (
    IdEmployees INT PRIMARY KEY,
    Firstname VARCHAR(100) NOT NULL,
    Lastname VARCHAR(100) NOT NULL,
    Role VARCHAR(100),
    IdRestaurant INT,
    hire_date DATE,
    FOREIGN KEY (IdRestaurant) REFERENCES Restaurants(IdRestaurant)
);

CREATE TABLE Dishes (
    IdDishes INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2),
    Category VARCHAR(100),
    is_vegan BOOLEAN NULL
);

CREATE TABLE CustomerOrders (
    IdOrders INT PRIMARY KEY,
    IdRestaurant INT,
    Total_amount DECIMAL(10,2),
    Customer_name VARCHAR(100),
    FOREIGN KEY (IdRestaurant) REFERENCES Restaurants(IdRestaurant)
);

CREATE TABLE OrderItems (
    IdOrderItems INT PRIMARY KEY,
    IdOrders INT,
    IdDishes INT,
    Quantity INT,
    FOREIGN KEY (IdOrders) REFERENCES CustomerOrders(IdOrders),
    FOREIGN KEY (IdDishes) REFERENCES Dishes(IdDishes)
);

INSERT INTO Restaurants (Name, Planet, Opening_year) VALUES
('Milky Way Diner', 'Terre', 2450),
('Nebula Express', 'Mars', 2460),
('Andromeda Bites', 'Venus', 2475),
('Cosmic Grill Prime', 'Jupiter', 2430),
('Saturn Rings BBQ', 'Saturne', 2425),
('Black Hole Bistro', 'Pluton', 2410),
('Supernova Snacks', 'Mercure', 2468),
('Galaxy Fusion Hub', 'Neptune', 2472),
('Quantum Tacos', 'Uranus', 2465),
('Dark Matter Kitchen', 'Alpha Centauri', 2478),
('Astro Burger Factory', 'Proxima B', 2480),
('Meteorite Palace', 'Titan', 2458),
('Orbit Express', 'Europa', 2463),
('Infinity Bites', 'Kepler-22b', 2482),
('Solar Flare Diner', 'Vega IX', 2470),
('Nebula Supreme', 'Betelgeuse', 2444),
('Hyperdrive Eatery', 'Andromeda Prime', 2469),
('Stellar Cantina', 'Orion', 2438),
('Galactic Supreme Hub', 'Zeta Reticuli', 2484),
('Planet X Food Court', 'Planet X', 2451),
('Comet Crash Café', 'Ganymède', 2466),
('Asteroid Alley', 'Callisto', 2459),
('Warp Speed Burgers', 'Tau Ceti', 2486);

INSERT INTO Employees (Firstname, Lastname, Role, IdRestaurant, hire_date) VALUES
('Zorglub','Xen','Chef cuisinier',1,'2480-01-01'),
('Luna','Star','Manager',2,NULL),
('Atlas','Nova','Serveur',1,'2485-06-12'),
('Nova','Zenith','Manager',4,'2475-03-10'),
('Orion','Blaze','Chef cuisinier',4,'2476-07-22'),
('Lyra','Quark','Serveur',5,'2478-11-02'),
('Vega','Pulse','Serveur',6,'2481-01-19'),
('Atlas','Flux','Manager',7,'2473-05-30'),
('Nebulon','Prime','Chef cuisinier',7,'2474-02-14'),
('Stella','Nova','Serveur',8,'2482-06-06'),
('Cosmo','Ray','Serveur',9,NULL),
('Titan','Storm','Manager',10,'2479-09-12'),
('Aurora','Beam','Chef cuisinier',11,'2483-04-01'),
('Zen','Void','Serveur',12,'2484-08-15'),
('Loki','Comet','Serveur',13,'2477-12-21'),
('Helios','Drift','Manager',14,'2470-03-03'),
('Phoenix','Ash','Chef cuisinier',15,'2469-05-17'),
('Astra','Core','Serveur',16,'2485-02-25'),
('Quasar','Light','Manager',17,'2471-10-10'),
('Meteor','Flash','Serveur',18,'2486-01-01'),
('Echo','Shadow','Chef cuisinier',19,'2472-07-07'),
('Solaris','Wave','Serveur',20,'2484-03-09'),
('Drako','Inferno','Chef cuisinier',21,'2486-04-04'),
('Zara','Nebula','Serveur',22,'2486-06-18'),
('Alpha','Core','Serveur',4,'2485-01-01'),
('Beta','Core','Serveur',5,'2485-01-02'),
('Gamma','Core','Serveur',6,'2485-01-03'),
('Delta','Core','Serveur',7,'2485-01-04'),
('Epsilon','Core','Serveur',8,'2485-01-05'),
('Zeta','Core','Serveur',9,'2485-01-06'),
('Eta','Core','Serveur',10,'2485-01-07'),
('Theta','Core','Serveur',11,'2485-01-08'),
('Iota','Core','Serveur',12,'2485-01-09'),
('Kappa','Core','Serveur',13,'2485-01-10'),
('Lambda','Core','Serveur',14,'2485-01-11'),
('Mu','Core','Serveur',15,'2485-01-12'),
('Nu','Core','Serveur',16,'2485-01-13'),
('Xi','Core','Serveur',17,'2485-01-14'),
('Omicron','Core','Serveur',18,'2485-01-15'),
('Pi','Core','Serveur',19,'2485-01-16'),
('Rho','Core','Serveur',20,'2485-01-17'),
('Sigma','Core','Serveur',21,'2485-01-18'),
('Tau','Core','Serveur',22,'2485-01-19'),
('Upsilon','Core','Serveur',23,'2485-01-20'),
('Rémy','Bamas','Chef cuisinier',24,'2485-01-21');

INSERT INTO Dishes (Name, Price, Category, is_vegan) VALUES
('Burger d Asteroide',12.50,'Burgers',FALSE),
('Pizza Antimatiere',15.00,'Pizzas',NULL),
('Smoothie Nebuleuse',8.00,'Boissons',TRUE),
('Salade Cosmique',10.00,'Salades',TRUE),
('Taco Quantique',13.00,'Tacos',FALSE),
('Soupe Stellaire',9.50,'Soupes',TRUE),
('Wrap Meteorite',11.00,'Wraps',FALSE),
('Dessert Galactique',14.00,'Desserts',NULL);

INSERT INTO CustomerOrders (IdRestaurant, Total_amount, Customer_name) VALUES
(1,25.00,'Thor'),
(2,40.00,'Leia'),
(3,18.00,'Spock'),
(4,52.00,'Neo'),
(5,4.00,'TestClient');

INSERT INTO OrderItems (IdOrders, IdDishes, Quantity) VALUES
(1,1,2),
(2,2,2),
(3,3,2),
(4,5,4),
(5,3,1);

SELECT * FROM Restaurants;
SELECT * FROM Dishes ORDER BY Price DESC;
SELECT * FROM Employees ORDER BY Role;
SELECT * FROM Dishes WHERE is_vegan = TRUE;
SELECT * FROM Dishes WHERE Price > (SELECT AVG(Price) FROM Dishes);
SELECT * FROM Dishes WHERE is_vegan IS NULL;
SELECT * FROM Employees WHERE hire_date IS NULL;

SELECT
    co.IdOrders,
    SUM(oi.Quantity) AS Total_articles,
    SUM(oi.Quantity * d.Price) AS Total_calculated
FROM CustomerOrders co
JOIN OrderItems oi ON co.IdOrders = oi.IdOrders
JOIN Dishes d ON oi.IdDishes = d.IdDishes
GROUP BY co.IdOrders;

SELECT * FROM CustomerOrders ORDER BY Total_amount DESC;

SELECT e.Firstname, e.Lastname, e.Role, r.Name AS Restaurant
FROM Employees e
JOIN Restaurants r ON e.IdRestaurant = r.IdRestaurant;

SELECT
    d.Name AS Dish,
    co.Customer_name,
    r.Planet
FROM OrderItems oi
JOIN Dishes d ON oi.IdDishes = d.IdDishes
JOIN CustomerOrders co ON oi.IdOrders = co.IdOrders
JOIN Restaurants r ON co.IdRestaurant = r.IdRestaurant;

SELECT
    r.Name,
    COUNT(e.IdEmployees) AS Nombre_employes
FROM Restaurants r
LEFT JOIN Employees e ON r.IdRestaurant = e.IdRestaurant
GROUP BY r.Name;

UPDATE Dishes
SET Price =
    CASE
        WHEN Price > 12 THEN Price * 0.90
        ELSE Price * 0.95
    END;

DELETE FROM Dishes WHERE Price IS NULL;
DELETE FROM CustomerOrders WHERE Total_amount < 5;

SELECT Category, AVG(Price) AS Prix_moyen
FROM Dishes
GROUP BY Category;

SELECT SUM(Total_amount) AS Total_ventes
FROM CustomerOrders;

SELECT * FROM Dishes ORDER BY Price DESC LIMIT 3;

SELECT * FROM Employees
WHERE Lastname LIKE '%a%' OR Firstname LIKE '%a%';

CREATE TABLE Ingredients (
    IdIngredient INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE DishIngredients (
    IdDishes INT,
    IdIngredient INT,
    PRIMARY KEY (IdDishes, IdIngredient),
    FOREIGN KEY (IdDishes) REFERENCES Dishes(IdDishes),
    FOREIGN KEY (IdIngredient) REFERENCES Ingredients(IdIngredient)
);

SELECT * FROM Dishes WHERE is_vegan = TRUE;
SELECT * FROM Restaurants ORDER BY Opening_year ASC;
SELECT * FROM CustomerOrders ORDER BY Total_amount DESC LIMIT 1;

//csedrtf
