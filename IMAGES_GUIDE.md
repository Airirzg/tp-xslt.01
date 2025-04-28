# Guide d'ajout d'images de couverture

Ce guide explique comment ajouter des images de couverture pour les livres dans l'application Infinity Book.

## Structure des images

Les images de couverture des livres doivent être placées dans le dossier `images/` à la racine du projet. Le XML fait référence à ces images par leur chemin relatif, par exemple `images/petit_prince.jpg`.

## Noms de fichiers attendus

Voici les noms de fichiers attendus pour chaque livre:

1. **Le Petit Prince**: `images/petit_prince.jpg`
2. **L'Étranger**: `images/etranger.jpg`
3. **La Peste**: `images/peste.jpg`
4. **Madame Bovary**: `images/bovary.jpg`
5. **Les Misérables**: `images/miserables.jpg`
6. **Notre-Dame de Paris**: `images/notre_dame.jpg`
7. **Germinal**: `images/germinal.jpg`
8. **Le Rouge et le Noir**: `images/rouge_noir.jpg`
9. **Les Fleurs du Mal**: `images/fleurs_mal.jpg`
10. **Candide**: `images/candide.jpg`

## Comment ajouter vos propres images

1. Préparez vos images de couverture de livres (format recommandé: JPG ou PNG)
2. Redimensionnez-les à une taille appropriée (recommandé: 400-600px de largeur)
3. Nommez-les selon la convention ci-dessus
4. Placez-les dans le dossier `images/`

## Format d'image recommandé

- **Format**: JPG ou PNG
- **Dimensions**: Largeur de 400-600px, hauteur proportionnelle
- **Ratio**: Idéalement 2:3 (format livre standard)
- **Taille de fichier**: Moins de 200KB par image pour des performances optimales

## Modification du XML

Si vous souhaitez utiliser des noms de fichiers différents, vous devrez mettre à jour les chemins dans le fichier `livres.xml`. Chaque livre a une balise `<image>` qui contient le chemin de l'image:

```xml
<livre>
    <titre>Le Petit Prince</titre>
    <!-- autres informations -->
    <image>images/petit_prince.jpg</image>
</livre>
```

## Absence d'image

Si une image n'est pas trouvée, une icône de livre par défaut sera affichée à la place.
