const mongoose = require("mongoose");

const shopSchema = new mongoose.Schema({
  // Nom du magasin
  name: {
    type: String,
    required: true,
    trim: true,
    unique: false,
  },

  // Description du magasin
  description: {
    type: String,
    trim: true,
    default: "",
  },

  // Styles du magasin (par exemple : ['streetwear', 'casual', ...])
  style: [{
    type: String,
    required: true,
    trim: true,
    lowercase: true,
  }],

  // Type de magasin : physique ou en ligne
  type: [{
    type: String,
    required: true,
    trim: true,
    lowercase: true,
  }],

  // Localisation (uniquement pour les magasins physiques)
  address: {
    type: String,
    trim: true,
    default: "",
  },
  gps: {
    type: {
      type: String,
      default: "Point",
    },
    coordinates: {
      type: [Number],
      required: function() {
        return this.type === "physical";
      },
    },
  },

  // URL du site web (uniquement pour les magasins en ligne)
  website: {
    type: String,
    trim: true,
    required: function() {
      return this.type === "online";
    },
  },

  // Image ou logo du magasin
  imageUrl: {
    type: String,
    trim: true,
    default: "",
  },

  // Informations de contact
  contact: {
    email: {
      type: String,
      trim: true,
      default: "",
    },
    phone: {
      type: String,
      trim: true,
      default: "",
    },
  },

  // Heures d'ouverture (uniquement pour les magasins physiques)
  openingHours: {
    type: String,
    trim: true,
    default: "",
  },

  // Autres informations ou caractéristiques que vous pourriez vouloir ajouter
  // ...

  // Date de création et de mise à jour
  createdAt: {
    type: Date,
    default: Date.now,
  },
  updatedAt: {
    type: Date,
    default: Date.now,
  },
});

// Index pour améliorer les recherches par localisation
shopSchema.index({location: "2dsphere"});

const Shop = mongoose.model("Shop", shopSchema);

module.exports = Shop;
