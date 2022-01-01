# Projet AStar
Projet ayant pour but de tester le pathfinding via l'algorythme AStar, ainsi que le déplacement d'un/plusieurs personnage

## Architecture
`NewWorld.tscn` : PackedScene contenant une tilemap et un joueur

`Map.gd` : Contient la classe Astar_Path qui hérite de la classe Tilemap.
Elle contient toutes les fonctions necessaire à la creation de la liste de points ainsi que des connexions entre ces memes points.

`RealMap.gd` : Hérite de Astar_Path. Fais le lien entre les inputs et le déplacement du personnage sur la map.