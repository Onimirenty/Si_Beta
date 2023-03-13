CREATE TABLE identite_Entreprise (
    id serial PRIMARY KEY,
    logo VARCHAR(255),
    nomSociete VARCHAR(255),
    objetSociete TEXT,
    dateCreation DATE,
    LieuExercice VARCHAR(255)

);


CREATE TABLE Contact (
    id serial PRIMARY KEY,
    idSociete INTEGER,
    adresse VARCHAR(255),
    telephone VARCHAR(255),
    mail VARCHAR(255),
    Siege BOOLEAN,
    
    FOREIGN KEY (idSociete) REFERENCES identite_Entreprise(id)

);

CREATE TABLE Devise (
    id serial PRIMARY KEY,
    nomDevise VARCHAR(255),
    Pays VARCHAR(255)
);

CREATE TABLE Departement (
    id serial PRIMARY KEY,
    Descriptions VARCHAR(255)
);

CREATE TABLE Compte (
    id serial PRIMARY KEY,
    nom VARCHAR(255),
    Debit DECIMAL(10,2),
    Credit DECIMAL(10,2)
);

CREATE TABLE Devise_Equivalence (
    id serial PRIMARY KEY,
    idReference INTEGER,
    idDevise INTEGER,
    valeur DECIMAL(10,2),
    dates DATE,
    taux DECIMAL(10,2),
    Change DECIMAL(10,2),
    idCompte INTEGER,

    FOREIGN KEY (idReference) REFERENCES Devise(id),
    FOREIGN KEY (idDevise) REFERENCES Devise(id),
    FOREIGN KEY (idCompte) REFERENCES Compte(id)
);

CREATE TABLE InfoComptabilite (
    id serial PRIMARY KEY,
    idSociete INTEGER,
    capitale DECIMAL(10,2),
    NIF VARCHAR(255),
    NSTAT VARCHAR(255),
    NRCS VARCHAR(255),
    idDevise INTEGER,

    FOREIGN KEY (idSociete) REFERENCES identite_Entreprise(id),
    FOREIGN KEY (idDevise) REFERENCES Devise(id)

);

CREATE TABLE Employe (
    id serial PRIMARY KEY,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    dateNaissance DATE,
    idDepartement INTEGER,
    metier VARCHAR(255),
    salaire DECIMAL(10,2),
    pouvoirExecutif BOOLEAN,
    idSociete INTEGER,
    identite VARCHAR(255),
    FOREIGN KEY (idDepartement) REFERENCES Departement(id),
    FOREIGN KEY (idSociete) REFERENCES identite_Entreprise(id)
);

CREATE TABLE ExoComptable (
    id serial PRIMARY KEY,
    DateDebut DATE,
    DateFin DATE,
    idcomptabilite INTEGER,
    FOREIGN KEY (idcomptabilite) REFERENCES InfoComptabilite(id)
);



CREATE TABLE compteTier (
    id serial PRIMARY KEY,
    nom VARCHAR(255),
    idCompte INTEGER,
    FOREIGN KEY (idCompte) REFERENCES Compte(id)
);

CREATE TABLE Stocke (
    id serial PRIMARY KEY,
    nomStocke VARCHAR(255),
    Prix DECIMAL(10,2),
    nombre INTEGER
);

CREATE TABLE Produit (
    id serial PRIMARY KEY,
    nomproduit VARCHAR(255),
    Prix NUMERIC(10,2),
    nombre INT
);

CREATE TABLE Facture (
    id serial PRIMARY KEY,
    idstocke INTEGER,
    idproduit INTEGER,
    NumFacture VARCHAR(255),
    vendeur VARCHAR(255),
    acheteur VARCHAR(255),
    idContact INT,
    ModePayement VARCHAR(255),
    prix NUMERIC(10,2),
    nombre INT,

    FOREIGN KEY (idContact) REFERENCES Contact(id),
    FOREIGN KEY (idproduit) REFERENCES produit(id),
    FOREIGN KEY (idstocke) REFERENCES Stocke(id)

);

CREATE TABLE Journal (
    id serial PRIMARY KEY ,
    nom VARCHAR(255),
    idCompte INTEGER,
    FOREIGN KEY (idCompte) REFERENCES Compte(id)
);

CREATE TABLE PieceJournale (
    id serial PRIMARY KEY,
    idJournale INTEGER,
    idCompteCollectif INTEGER,
    idCompteTiere INTEGER,
    dates DATE,
    Debit DECIMAL(10,2),
    Credit DECIMAL(10,2),
    intitule VARCHAR(255),
    idFacture INTEGER,
    FOREIGN KEY (idJournale) REFERENCES Journal(id),
    FOREIGN KEY (idCompteCollectif) REFERENCES Compte(id),
    FOREIGN KEY (idCompteTiere) REFERENCES compteTier(id),
    FOREIGN KEY (idFacture) REFERENCES Facture(id)
);




CREATE TABLE Tva (
    id INT PRIMARY KEY,
    Taux NUMERIC(5,2)
);

INSERT INTO identite_Entreprise (logo, nomSociete, objetSociete, dateCreation, LieuExercice)
VALUES
('logo1.png', 'Entreprise A', 'Objet de l entreprise A', '2022-01-01', 'Lieu A'),
('logo2.png', 'Entreprise B', 'Objet de l entreprise B', '2021-07-15', 'Lieu B'),
('logo3.png', 'Entreprise C', 'Objet de l entreprise C', '2020-03-31', 'Lieu C');

INSERT INTO Contact (idSociete, adresse, telephone, mail, Siege)
VALUES
(1, 'Adresse 1', '01 23 45 67 89', 'contact@entrepriseA.com', true),
(1, 'Adresse 2', '01 23 45 67 90', 'commercial@entrepriseA.com', false),
(2, 'Adresse 3', '01 23 45 67 91', 'contact@entrepriseB.com', true);

INSERT INTO Devise (nomDevise, Pays)
VALUES
('Euro', 'Europe'),
('Dollar américain', 'États-Unis'),
('Yen', 'Japon');

INSERT INTO Compte (nom, Debit, Credit)
VALUES
('Compte A', 500.00, 0.00),
('Compte B', 0.00, 200.00),
('Compte C', 1000.00, 0.00);

INSERT INTO Devise_Equivalence (idReference, idDevise, valeur, dates, taux, Change, idCompte)
VALUES
(1, 2, 1.15, '2022-01-01', 0.15, 1.15, 1),
(2, 3, 110.00, '2021-07-15', 10.00, 110.00, 2),
(1, 3, 0.90, '2020-03-31', 0.10, 0.90, 3);

INSERT INTO InfoComptabilite (idSociete, capitale, NIF, NSTAT, NRCS, idDevise)
VALUES
(1, 50000.00, '1234567890', '12345', '12345B01', 1),
(2, 75000.00, '0987654321', '67890', '67890B01', 2),
(3, 100000.00, '1357902468', '13579', '13579B01', 3);

INSERT INTO Departement (Descriptions) VALUES ('Ventes');
INSERT INTO Departement (Descriptions) VALUES ('Marketing');
INSERT INTO Departement (Descriptions) VALUES ('Développement');


INSERT INTO Employe (nom, prenom, dateNaissance, idDepartement, metier, salaire, pouvoirExecutif, idSociete, identite)
VALUES ('Dupont', 'Jean', '1985-03-25', 1, 'Ingénieur', 5000.00, TRUE, 1, 'Personne physique');

INSERT INTO Employe (nom, prenom, dateNaissance, idDepartement, metier, salaire, pouvoirExecutif, idSociete, identite)
VALUES ('Durand', 'Marie', '1990-07-11', 2, 'Marketing', 3000.00, FALSE, 2, 'SARL X');

INSERT INTO Employe (nom, prenom, dateNaissance, idDepartement, metier, salaire, pouvoirExecutif, idSociete, identite)
VALUES ('Martin', 'Pierre', '1980-05-16', 3, 'Développeur', 4500.00, TRUE, 3, 'SA Y');

INSERT INTO ExoComptable (DateDebut, DateFin, idcomptabilite)
VALUES ('2022-01-01', '2022-03-31', 1);

INSERT INTO ExoComptable (DateDebut, DateFin, idcomptabilite)
VALUES ('2022-04-01', '2022-06-30', 2);

INSERT INTO ExoComptable (DateDebut, DateFin, idcomptabilite)
VALUES ('2022-07-01', '2022-09-30', 3);

INSERT INTO Journal (nom, idCompte)
VALUES ('Journal des ventes', 1);

INSERT INTO Journal (nom, idCompte)
VALUES ('Journal des achats', 2);

INSERT INTO Journal (nom, idCompte)
VALUES ('Journal de caisse', 3);

INSERT INTO compteTier (nom, idCompte)
VALUES ('Client A', 1);

INSERT INTO compteTier (nom, idCompte)
VALUES ('Client B', 2);

INSERT INTO compteTier (nom, idCompte)
VALUES ('Fournisseur X', 3);

INSERT INTO Stocke (nomStocke, Prix, nombre)
VALUES ('Stocke 1', 25.00, 100);

INSERT INTO Stocke (nomStocke, Prix, nombre)
VALUES ('Stocke 2', 35.00, 75);

INSERT INTO Stocke (nomStocke, Prix, nombre)
VALUES ('Stocke 3', 45.00, 50);

INSERT INTO Produit (nomproduit, Prix, nombre)
VALUES ('Produit A', 20, 500);

INSERT INTO Produit (nomproduit, Prix, nombre)
VALUES ('Produit B', 30.00, 750);

INSERT INTO Produit (nomproduit, Prix, nombre)
VALUES ('Produit C', 40.00, 300);

INSERT INTO Facture (idproduit, NumFacture, vendeur, acheteur, idContact, ModePayement, prix, nombre)
VALUES (1, 'FAC0001', 'SARL X', 'Client A', 1, 'Carte bancaire', 500.00, 25);

INSERT INTO Facture (idproduit, NumFacture, vendeur, acheteur, idContact, ModePayement, prix, nombre)
VALUES 
    (1, 'FAC0002', 'SARL Y', 'Client B', 2, 'Carte bancaire', 5000.00, 25),
    (2, 'FAC0003', 'SARL Z', 'Client C', 3, 'Carte bancaire', 501.00, 20);

INSERT INTO Journal (nom, idCompte) VALUES ('Journal des ventes', 1);
INSERT INTO Journal (nom, idCompte) VALUES ('Journal des achats', 2);
INSERT INTO Journal (nom, idCompte) VALUES ('Journal des opérations diverses', 3);

INSERT INTO PieceJournale (idJournale, idCompteCollectif, idCompteTiere, dates, Debit, Credit, intitule, idFacture)
VALUES (1, 4, 5, '2022-12-01', 100.00, 0.00, 'Vente de produit X', 1);

INSERT INTO PieceJournale (idJournale, idCompteCollectif, idCompteTiere, dates, Debit, Credit, intitule, idFacture)
VALUES (2, 6, 7, '2022-12-05', 0.00, 75.00, 'Achat de fournitures de bureau', 2);

INSERT INTO PieceJournale (idJournale, idCompteCollectif, idCompteTiere, dates, Debit, Credit, intitule, idFacture)
VALUES (3, 8, 9, '2022-12-10', 250.00, 0.00, 'Paiement du loyer', 3);