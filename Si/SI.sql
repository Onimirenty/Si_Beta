CREATE TABLE identite_Entreprise (
    id INT PRIMARY KEY AUTO_INCREMENT,
    logo VARCHAR(255),
    nomSociete VARCHAR(255),
    objetSociete TEXT,
    dateCreation DATE
);

CREATE TABLE Contact (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idSociete INT,
    adresse VARCHAR(255),
    telephone VARCHAR(255),
    mail VARCHAR(255),
    Siege BOOLEAN
);

CREATE TABLE Devise (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nomDevise VARCHAR(255),
    Pays VARCHAR(255)
);

CREATE TABLE Departement (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Description VARCHAR(255)
);

CREATE TABLE Devise_Equivalence (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idReference INT,
    idDevise INT,
    valeur DECIMAL(10,2),
    date DATE,
    taux DECIMAL(10,2),
    Change DECIMAL(10,2),
    idCompte INT,
    FOREIGN KEY (idReference) REFERENCES Devise(id),
    FOREIGN KEY (idDevise) REFERENCES Devise(id),
    FOREIGN KEY (idCompte) REFERENCES Compte(id)
);

CREATE TABLE InfoComptabilite (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idSociete INT,
    capitale DECIMAL(10,2),
    NIF VARCHAR(255),
    NSTAT VARCHAR(255),
    NRCS VARCHAR(255),
    idDevise INT,
    FOREIGN KEY (idSociete) REFERENCES identite_Entreprise(id),
    FOREIGN KEY (idDevise) REFERENCES Devise(id)
);

CREATE TABLE Employe (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    dateNaissance DATE,
    idDepartement INT,
    metier VARCHAR(255),
    salaire DECIMAL(10,2),
    pouvoirExecutif BOOLEAN,
    idSociete INT,
    identite VARCHAR(255),
    FOREIGN KEY (idDepartement) REFERENCES Departement(id),
    FOREIGN KEY (idSociete) REFERENCES identite_Entreprise(id)
);

CREATE TABLE ExoComptable (
    id INT PRIMARY KEY AUTO_INCREMENT,
    DateDebut DATE,
    DateFin DATE,
    idcompta INT,
    FOREIGN KEY (idcompta) REFERENCES InfoComptabilite(id)
);

CREATE TABLE Compte (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    Debit DECIMAL(10,2),
    Credit DECIMAL(10,2)
);

CREATE TABLE Journal (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    idCompte INT,
    FOREIGN KEY (idCompte) REFERENCES Compte(id)
);

CREATE TABLE PieceJournale (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idJournale INT,
    idCompteCollectif INT,
    idCompteTiere INT,
    date DATE,
    Debit DECIMAL(10,2),
    Credit DECIMAL(10,2),
    intitule VARCHAR(255),
    idFacture INT,
    FOREIGN KEY (idJournale) REFERENCES Journal(id),
    FOREIGN KEY (idCompteCollectif) REFERENCES Compte(id),
    FOREIGN KEY (idCompteTiere) REFERENCES compteTier(id),
    FOREIGN KEY (idFacture) REFERENCES Facture(id)
);

CREATE TABLE compteTier (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    idCompte INT,
    FOREIGN KEY (idCompte) REFERENCES Compte(id)
);

CREATE TABLE Stocke (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nomStocke VARCHAR(255),
    Prix DECIMAL(10,2),
    nombre INT
);
CREATE TABLE Produit (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nomproduit VARCHAR(255),
    Prix DECIMAL(10,2),
    nombre INT
);

CREATE TABLE Facture (
    id INT PRIMARY KEY AUTO_INCREMENT,
    NumFacture VARCHAR(255),
    vendeur VARCHAR(255),
    acheteur VARCHAR(255),
    idContact INT,
    ModePayement VARCHAR(255),
    prix DECIMAL(10,2),
    nombre INT,
    FOREIGN KEY (idContact) REFERENCES Contact(id)
);
CREATE TABLE Tva (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Taux DECIMAL(5,2)
);

ALTER TABLE identite_Entreprise 
ADD LieuExercice VARCHAR(255),
ADD idContact INT,
ADD FOREIGN KEY (idContact) REFERENCES Contact(id);

ALTER TABLE DeviseEquivalence
ADD FOREIGN KEY (idDevise) REFERENCES Devise(id);

ALTER TABLE Facture
ADD idproduit INT,
ADD idstocke INT,
ADD FOREIGN KEY (idproduit) REFERENCES Produit(id),
ADD FOREIGN KEY (idstocke) REFERENCES Stocke(id);

