CREATE DATABASE gestioncontrat CHARACTER SET utf8;
USE gestioncontrat;
#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: typecontrat
#------------------------------------------------------------

CREATE TABLE typecontrat(
  id         Int  Auto_increment  NOT NULL ,
  libelle    Varchar (255) NOT NULL ,
  descriptif Varchar (255) NOT NULL ,
  modalites  Varchar (255) NOT NULL
  ,CONSTRAINT typecontrat_PK PRIMARY KEY (id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: date
#------------------------------------------------------------

CREATE TABLE date(
  date Date NOT NULL
  ,CONSTRAINT date_PK PRIMARY KEY (date)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: facturation
#------------------------------------------------------------

CREATE TABLE facturation(
  id           Int  Auto_increment  NOT NULL ,
  numero       Int NOT NULL ,
  libelle      Varchar (255) NOT NULL ,
  emeteur      Varchar (255) NOT NULL ,
  recepteur    Varchar (255) NOT NULL ,
  produit      Varchar (255) NOT NULL ,
  datefacture  Date NOT NULL ,
  echeance     Date NOT NULL ,
  modalites    Varchar (255) NOT NULL ,
  encaissement Varchar (255) NOT NULL
  ,CONSTRAINT facturation_PK PRIMARY KEY (id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: devis
#------------------------------------------------------------

CREATE TABLE devis(
  id         Int NOT NULL ,
  numero     Int NOT NULL ,
  libelle    Varchar (25) NOT NULL ,
  emeteur    Varchar (255) NOT NULL ,
  recepteur  Varchar (255) NOT NULL ,
  prestation Varchar (255) NOT NULL ,
  datedevis  Date NOT NULL
  ,CONSTRAINT devis_PK PRIMARY KEY (id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Prestation
#------------------------------------------------------------

CREATE TABLE Prestation(
  id             Int  Auto_increment  NOT NULL ,
  Activite       Varchar (50) NOT NULL ,
  Description    Varchar (255) NOT NULL ,
  designation    Varchar (255) NOT NULL ,
  tva            Decimal NOT NULL ,
  Prixhoraire         Decimal NOT NULL ,
  Heure_totale   Int NOT NULL ,
  id_facturation Int NOT NULL ,
  id_devis       Int NOT NULL
  ,CONSTRAINT Prestation_PK PRIMARY KEY (id)

  ,CONSTRAINT Prestation_facturation_FK FOREIGN KEY (id_facturation) REFERENCES facturation(id)
  ,CONSTRAINT Prestation_devis0_FK FOREIGN KEY (id_devis) REFERENCES devis(id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: contrat
#------------------------------------------------------------

CREATE TABLE contrat(
  id             Int  Auto_increment  NOT NULL ,
  numero         Int NOT NULL ,
  libelle        Varchar (25) NOT NULL ,
  prestataire    Varchar (255) NOT NULL ,
  client         Varchar (255) NOT NULL ,
  descriptif     Varchar (255) NOT NULL ,
  modalites      Varchar (255) NOT NULL ,
  id_typecontrat Int NOT NULL ,
  date           Date NOT NULL ,
  date_finir     Date NOT NULL ,
  date_signer    Date NOT NULL ,
  id_Prestation  Int NOT NULL
  ,CONSTRAINT contrat_PK PRIMARY KEY (id)

  ,CONSTRAINT contrat_typecontrat_FK FOREIGN KEY (id_typecontrat) REFERENCES typecontrat(id)
  ,CONSTRAINT contrat_date0_FK FOREIGN KEY (date) REFERENCES date(date)
  ,CONSTRAINT contrat_date1_FK FOREIGN KEY (date_finir) REFERENCES date(date)
  ,CONSTRAINT contrat_date2_FK FOREIGN KEY (date_signer) REFERENCES date(date)
  ,CONSTRAINT contrat_Prestation3_FK FOREIGN KEY (id_Prestation) REFERENCES Prestation(id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: avenant
#------------------------------------------------------------

CREATE TABLE avenant(
  id          Int  Auto_increment  NOT NULL ,
  modalites   Varchar (255) NOT NULL ,
  dateavenant Date NOT NULL ,
  id_contrat  Int NOT NULL
  ,CONSTRAINT avenant_PK PRIMARY KEY (id)

  ,CONSTRAINT avenant_contrat_FK FOREIGN KEY (id_contrat) REFERENCES contrat(id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: utilisateur
#------------------------------------------------------------

CREATE TABLE utilisateur(
  id              Int NOT NULL ,
  pseudo          Varchar (255) NOT NULL ,
  motdepasse      Varchar (255) NOT NULL ,
  nom             Varchar (255) NOT NULL ,
  prenom          Varchar (255) NOT NULL ,
  adresse         Varchar (255) NOT NULL ,
  telephone       Int NOT NULL ,
  email           Varchar (255) NOT NULL ,
  datedenaissance Date NOT NULL ,
  role            Varchar (255) NOT NULL
  ,CONSTRAINT utilisateur_PK PRIMARY KEY (id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: representant
#------------------------------------------------------------

CREATE TABLE representant(
  id     Int NOT NULL ,
  nom    Varchar (255) NOT NULL ,
  titre  Varchar (255) NOT NULL ,
  prenom Varchar (255) NOT NULL
  ,CONSTRAINT representant_PK PRIMARY KEY (id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: entreprise
#------------------------------------------------------------

CREATE TABLE entreprise(
  id              Int NOT NULL ,
  nom             Varchar (255) NOT NULL ,
  siret           Int NOT NULL ,
  qualification   Varchar (255) NOT NULL ,
  adresse         Varchar (255) NOT NULL ,
  telephone       Int NOT NULL ,
  email           Varchar (255) NOT NULL ,
  id_representant Int NOT NULL
  ,CONSTRAINT entreprise_PK PRIMARY KEY (id)

  ,CONSTRAINT entreprise_representant_FK FOREIGN KEY (id_representant) REFERENCES representant(id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: produit
#------------------------------------------------------------

CREATE TABLE produit(
  id       Int  Auto_increment  NOT NULL ,
  nom      Varchar (255) NOT NULL ,
  quantite Int NOT NULL ,
  devise   Varchar (255) NOT NULL ,
  tva      Decimal NOT NULL
  ,CONSTRAINT produit_PK PRIMARY KEY (id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: signer
#------------------------------------------------------------

CREATE TABLE signer(
  id         Int NOT NULL ,
  id_contrat Int NOT NULL
  ,CONSTRAINT signer_PK PRIMARY KEY (id,id_contrat)

  ,CONSTRAINT signer_entreprise_FK FOREIGN KEY (id) REFERENCES entreprise(id)
  ,CONSTRAINT signer_contrat0_FK FOREIGN KEY (id_contrat) REFERENCES contrat(id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: interesser
#------------------------------------------------------------

CREATE TABLE interesser(
  id             Int NOT NULL ,
  id_utilisateur Int NOT NULL
  ,CONSTRAINT interesser_PK PRIMARY KEY (id,id_utilisateur)

  ,CONSTRAINT interesser_contrat_FK FOREIGN KEY (id) REFERENCES contrat(id)
  ,CONSTRAINT interesser_utilisateur0_FK FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: composer
#------------------------------------------------------------

CREATE TABLE composer(
  id       Int NOT NULL ,
  id_devis Int NOT NULL
  ,CONSTRAINT composer_PK PRIMARY KEY (id,id_devis)

  ,CONSTRAINT composer_produit_FK FOREIGN KEY (id) REFERENCES produit(id)
  ,CONSTRAINT composer_devis0_FK FOREIGN KEY (id_devis) REFERENCES devis(id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: facturer
#------------------------------------------------------------

CREATE TABLE facturer(
  id             Int NOT NULL ,
  id_facturation Int NOT NULL
  ,CONSTRAINT facturer_PK PRIMARY KEY (id,id_facturation)

  ,CONSTRAINT facturer_produit_FK FOREIGN KEY (id) REFERENCES produit(id)
  ,CONSTRAINT facturer_facturation0_FK FOREIGN KEY (id_facturation) REFERENCES facturation(id)
)ENGINE=InnoDB;

#------------------------------------------------------------
# Pour rechercher les différents utilisateurs de la base de données
# SELECT * FROM mysql.USER;
# (si je veux créer un nouveau user et lui donner tout les droits
# alors je tappe : CREATE USER 'kodjovi'@localhost;
#                  IDENTIFIED by 'lkyhafpa';
#                   GRANT ALL ON projetcontrat TO 'kodjovi'@localhost;
#-------------------------------------------------------------

SELECT * FROM mysql.USER;