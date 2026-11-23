# GalaxiEat

Base de données relationnelle d'une chaîne fictive de restaurants installés sur les planètes du système solaire, en l'an 2400. Exercice de TP SQL : modélisation, insertion de données et requêtes.

## Contenu

| Fichier | Rôle |
|---|---|
| `GalaxiEat.sql` | Script complet : création des tables, jeu de données, requêtes de l'exercice |
| `GalaxiEat.sqlite` | Base SQLite déjà générée, prête à être ouverte |

## Modèle de données

- **Restaurants** : nom, planète, année d'ouverture
- **Employees** : prénom, nom, poste, restaurant, date d'embauche
- **Dishes** : nom, prix, catégorie, plat végan ou non
- **CustomerOrders** : restaurant, montant total, nom du client
- **OrderItems** : plats et quantités de chaque commande
- **Ingredients** et **DishIngredients** : ingrédients et composition des plats (relation plusieurs à plusieurs)

Les clés étrangères relient les employés et les commandes à leur restaurant, et les lignes de commande aux plats.

## Requêtes travaillées

- Tris et filtres (`ORDER BY`, `WHERE`, `LIKE`, `IS NULL`, `LIMIT`)
- Sous-requête : plats plus chers que le prix moyen
- Jointures : employés avec le nom de leur restaurant, détail des commandes
- Agrégats : prix moyen par catégorie (`GROUP BY`), chiffre d'affaires total (`SUM`)
- Mises à jour et suppressions (`UPDATE`, `DELETE`)

## Utilisation

Ouvrir la base générée :

```bash
sqlite3 GalaxiEat.sqlite
```

```sql
SELECT Name, Planet FROM Restaurants ORDER BY Opening_year;
```

La base s'ouvre aussi avec DB Browser for SQLite ou l'extension SQLite de VS Code.
