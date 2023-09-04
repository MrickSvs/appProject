require('dotenv').config();
const mongoose = require('mongoose');
const Shop = require('/Users/aymericsaves/developpment/App project/models/shops.js'); // Assurez-vous de remplacer par le chemin correct vers votre modèle Shop

// Connexion à MongoDB
mongoose.connect(process.env.MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });

// Données du shop à ajouter
const newShop = new Shop({
    name: "SneakernStuff",
    description: "Description du Shop",
    style: ["streetwear", "casual"],
    type: ["En ligne", "Physique"],
    address: "95 Rue Réaumur, 75002 Paris",
    gps: {
      type: "Point",
      coordinates: [48.862725, 2.287592] // Remplacez par les coordonnées réelles
    },
    imageUrl: "https://lh5.googleusercontent.com/p/AF1QipOs34pGq8PPlUcUOzoy-4tWcLnTWUh7rZjwsQde=w408-h272-k-no",
    contact: {
        email: "email@shop.com",
        phone: "0123456789"
    },
    openingHours: "11h-10h"
});

// Sauvegarde du shop dans la base de données
async function saveShop() {
    try {
        const savedShop = await newShop.save();
        console.log("Shop créé avec succès :", savedShop);
    } catch (err) {
        console.error("Erreur lors de la création du shop :", err);
    } finally {
        mongoose.connection.close();
    }
}

// Exécution de la fonction pour sauvegarder le shop
saveShop();