

-- 1. UTILISATEURS
CREATE TABLE utilisateurs (
    id           SERIAL PRIMARY KEY,
    email        VARCHAR(254) NOT NULL UNIQUE,
    password     VARCHAR(128) NOT NULL,
    is_active    BOOLEAN NOT NULL DEFAULT TRUE,
    is_staff     BOOLEAN NOT NULL DEFAULT FALSE,
    is_superuser BOOLEAN NOT NULL DEFAULT FALSE,
    last_login   TIMESTAMP WITH TIME ZONE,
    date_joined  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- 2. PERSONNES
CREATE TABLE personnes (
    id        SERIAL PRIMARY KEY,
    nom       VARCHAR(100) NOT NULL,
    prenom    VARCHAR(100) NOT NULL,
    adresse   TEXT,
    telephone VARCHAR(20)
);

-- 3. CLASSES
CREATE TABLE classes (
    id     SERIAL PRIMARY KEY,
    nom    VARCHAR(100) NOT NULL,
    niveau VARCHAR(50)  NOT NULL,
    annee  VARCHAR(10)  NOT NULL
);

-- 4. ADMINISTRATEURS (hérite de personnes)
CREATE TABLE administrateurs (
    personne_ptr_id INTEGER PRIMARY KEY
        REFERENCES personnes(id) ON DELETE CASCADE,
    utilisateur_id  INTEGER NOT NULL UNIQUE
        REFERENCES utilisateurs(id) ON DELETE CASCADE
);

-- 5. ENSEIGNANTS (hérite de personnes)
CREATE TABLE enseignants (
    personne_ptr_id INTEGER PRIMARY KEY
        REFERENCES personnes(id) ON DELETE CASCADE,
    utilisateur_id  INTEGER NOT NULL UNIQUE
        REFERENCES utilisateurs(id) ON DELETE CASCADE,
    specialite      VARCHAR(150) NOT NULL
);

-- 6. ETUDIANTS (hérite de personnes)
CREATE TABLE etudiants (
    personne_ptr_id INTEGER PRIMARY KEY
        REFERENCES personnes(id) ON DELETE CASCADE,
    utilisateur_id  INTEGER NOT NULL UNIQUE
        REFERENCES utilisateurs(id) ON DELETE CASCADE,
    classe_id       INTEGER
        REFERENCES classes(id) ON DELETE SET NULL
);

-- 7. RESPONSABLES (hérite de enseignants)
--    clé primaire = enseignant_ptr_id  ← pointe vers enseignants
CREATE TABLE responsables (
    enseignant_ptr_id INTEGER PRIMARY KEY
        REFERENCES enseignants(personne_ptr_id) ON DELETE CASCADE,
    classe_id         INTEGER
        REFERENCES classes(id) ON DELETE SET NULL
);

-- 8. MODULES
CREATE TABLE modules (
    id            SERIAL PRIMARY KEY,
    nom           VARCHAR(200) NOT NULL,
    description   TEXT,
    enseignant_id INTEGER
        REFERENCES enseignants(personne_ptr_id) ON DELETE SET NULL,
    classe_id     INTEGER NOT NULL
        REFERENCES classes(id) ON DELETE CASCADE
);

-- 9. RESSOURCES
CREATE TABLE ressources (
    id            SERIAL PRIMARY KEY,
    titre         VARCHAR(255) NOT NULL,
    fichier       VARCHAR(500) NOT NULL,
    date_ajout    DATE NOT NULL DEFAULT CURRENT_DATE,
    module_id     INTEGER NOT NULL
        REFERENCES modules(id) ON DELETE CASCADE,
    enseignant_id INTEGER
        REFERENCES enseignants(personne_ptr_id) ON DELETE SET NULL
);

-- 10. ANNONCES
--     responsable_id pointe vers responsables(enseignant_ptr_id) ← CORRECTION
CREATE TABLE annonces (
    id             SERIAL PRIMARY KEY,
    titre          VARCHAR(255) NOT NULL,
    contenu        TEXT NOT NULL,
    date           DATE NOT NULL DEFAULT CURRENT_DATE,
    classe_id      INTEGER NOT NULL
        REFERENCES classes(id) ON DELETE CASCADE,
    responsable_id INTEGER
        REFERENCES responsables(enseignant_ptr_id) ON DELETE SET NULL  -- ← CORRIGÉ
);

-- 11. NOTIFICATIONS
CREATE TABLE notifications (
    id           SERIAL PRIMARY KEY,
    message      TEXT NOT NULL,
    lu           BOOLEAN NOT NULL DEFAULT FALSE,
    date_envoi   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    etudiant_id  INTEGER NOT NULL
        REFERENCES etudiants(personne_ptr_id) ON DELETE CASCADE,
    ressource_id INTEGER
        REFERENCES ressources(id) ON DELETE SET NULL,
    module_id    INTEGER
        REFERENCES modules(id) ON DELETE SET NULL
);

-- 12. HISTORIQUES D'ACCES
CREATE TABLE historiques_acces (
    id           SERIAL PRIMARY KEY,
    date         TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    etudiant_id  INTEGER NOT NULL
        REFERENCES etudiants(personne_ptr_id) ON DELETE CASCADE,
    ressource_id INTEGER NOT NULL
        REFERENCES ressources(id) ON DELETE CASCADE
);


CREATE INDEX idx_etudiants_classe   ON etudiants(classe_id);
CREATE INDEX idx_modules_classe     ON modules(classe_id);
CREATE INDEX idx_modules_enseignant ON modules(enseignant_id);
CREATE INDEX idx_ressources_module  ON ressources(module_id);
CREATE INDEX idx_ressources_ens     ON ressources(enseignant_id);
CREATE INDEX idx_annonces_classe    ON annonces(classe_id);
CREATE INDEX idx_annonces_resp      ON annonces(responsable_id);
CREATE INDEX idx_notif_etudiant     ON notifications(etudiant_id);
CREATE INDEX idx_histo_etudiant     ON historiques_acces(etudiant_id);
CREATE INDEX idx_histo_ressource    ON historiques_acces(ressource_id);
CREATE INDEX idx_utilisateurs_email ON utilisateurs(email);
