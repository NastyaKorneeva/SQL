CREATE TABLE collection (
    id_collection           NUMBER NOT NULL,
    title                   VARCHAR2(250) NOT NULL,
    notes                   VARCHAR2(250),
    packagings_id_packaging NUMBER
);

CREATE UNIQUE INDEX collection__idx ON
    collection (
        packagings_id_packaging
    ASC );

ALTER TABLE collection ADD CONSTRAINT collection_pk PRIMARY KEY ( id_collection );

CREATE TABLE concept (
    id_concept                         NUMBER NOT NULL,
    expert_perceptions                 VARCHAR2(250),
    toy_id_toy                         NUMBER NOT NULL, 
    target_audience_id_target_audience NUMBER NOT NULL
);

CREATE UNIQUE INDEX concept__idx ON
    concept (
        toy_id_toy
    ASC );

ALTER TABLE concept ADD CONSTRAINT concept_pk PRIMARY KEY ( id_concept );

CREATE TABLE consignment_note (
    quantity               NUMBER,
    toy_id_toy             NUMBER NOT NULL,
    warehouse_id_warehouse NUMBER NOT NULL
);

ALTER TABLE consignment_note ADD CONSTRAINT consignment_note_pk PRIMARY KEY ( warehouse_id_warehouse,
                                                                              toy_id_toy );

CREATE TABLE material_packaging (
    colour                  NUMBER,
    materials_id_material   NUMBER NOT NULL,
    id_packaging            NUMBER NOT NULL,
    packagings_id_packaging NUMBER NOT NULL
);

ALTER TABLE material_packaging ADD CONSTRAINT material_packaging_pk PRIMARY KEY ( materials_id_material,
                                                                                  id_packaging );

CREATE TABLE materials (
    id_material  NUMBER NOT NULL,
    title        VARCHAR2(250) NOT NULL,
    antiallergic CHAR(1) NOT NULL,
    colour       VARCHAR2(250) NOT NULL
);

ALTER TABLE materials ADD CONSTRAINT materials_pk PRIMARY KEY ( id_material );

CREATE TABLE materials_for_toy (
    quantity              NUMBER,
    materials_id_material NUMBER NOT NULL,
    id_toy                NUMBER NOT NULL,
    toy_id_toy            NUMBER NOT NULL
);

ALTER TABLE materials_for_toy ADD CONSTRAINT materials_for_toy_pk PRIMARY KEY ( materials_id_material,
                                                                                id_toy );

CREATE TABLE officer (
    id_officer           NUMBER NOT NULL,
    last_name            VARCHAR2(250) NOT NULL,
    name                 VARCHAR2(250) NOT NULL,
    patronymic           VARCHAR2(250),
    payment              VARCHAR2(250) NOT NULL,
    birth_date           DATE NOT NULL,
    telephone_number     NUMBER NOT NULL,
    "E-Mail"             VARCHAR2(250),
    officer_id_officer   NUMBER NOT NULL,
    concept_id_concept   NUMBER NOT NULL,
    store_id_store       NUMBER,
    position_id_position NUMBER
);

CREATE UNIQUE INDEX officer__idx ON
    officer (
        officer_id_officer
    ASC );

ALTER TABLE officer ADD CONSTRAINT officer_pk PRIMARY KEY ( id_officer );

CREATE TABLE packagings (
    id_packaging             NUMBER NOT NULL,
    color_scheme             VARCHAR2(250) NOT NULL,
    collection_id_collection NUMBER
);

CREATE UNIQUE INDEX packagings__idx ON
    packagings (
        collection_id_collection
    ASC );

ALTER TABLE packagings ADD CONSTRAINT packagings_pk PRIMARY KEY ( id_packaging );

CREATE TABLE position (
    id_position NUMBER NOT NULL,
    title       VARCHAR2(250) NOT NULL,
    salary      NUMBER
);

ALTER TABLE position ADD CONSTRAINT position_pk PRIMARY KEY ( id_position );

ALTER TABLE position ADD CONSTRAINT position_id_position_un UNIQUE ( id_position );

CREATE TABLE sanitary_blank (
    toy_id_toy                            NUMBER NOT NULL, 
    sanitary_requirements_registry_nomber NUMBER NOT NULL
);

ALTER TABLE sanitary_blank ADD CONSTRAINT sanitary_blank_pk PRIMARY KEY ( toy_id_toy,
                                                                          sanitary_requirements_registry_nomber );

CREATE TABLE sanitary_requirements (
    registry_nomber  NUMBER NOT NULL,
    requirement      VARCHAR2(250) NOT NULL,
    necessary_checks VARCHAR2(250)
);

ALTER TABLE sanitary_requirements ADD CONSTRAINT sanitary_requirements_pk PRIMARY KEY ( registry_nomber );

CREATE TABLE store (
    id_store         NUMBER NOT NULL,
    address          VARCHAR2(250) NOT NULL,
    telephone_number NUMBER NOT NULL,
    web_site         VARCHAR2(250) NOT NULL,
    "E-Mail"         VARCHAR2(250) NOT NULL
);

ALTER TABLE store ADD CONSTRAINT store_pk PRIMARY KEY ( id_store );

CREATE TABLE suppliers (
    id_supplier NUMBER NOT NULL,
    name        VARCHAR2(250) NOT NULL,
    payment     VARCHAR2(250) NOT NULL,
    location    VARCHAR2(250)
);

ALTER TABLE suppliers ADD CONSTRAINT suppliers_pk PRIMARY KEY ( id_supplier );

CREATE TABLE supply_list (
    quantity              NUMBER,
    materials_id_material NUMBER NOT NULL,
    suppliers_id_supplier NUMBER NOT NULL
);

ALTER TABLE supply_list ADD CONSTRAINT supply_list_pk PRIMARY KEY ( materials_id_material,
                                                                    suppliers_id_supplier );

CREATE TABLE target_audience (
    id_target_audience NUMBER NOT NULL,
    age_group          VARCHAR2(250) NOT NULL,
    main_preference    VARCHAR2(250) NOT NULL
);

ALTER TABLE target_audience ADD CONSTRAINT target_audience_pk PRIMARY KEY ( id_target_audience );

CREATE TABLE toy (
    id_toy                                   NUMBER NOT NULL,
    name                                     VARCHAR2(250) NOT NULL,
    colour                                   VARCHAR2(250) NOT NULL,
    "Size"                                   NUMBER NOT NULL, 
    санитарные_требования_номер_в_госриестре NUMBER NOT NULL,
    packagings_id_packaging                  NUMBER NOT NULL,
    collection_id_collection                 NUMBER NOT NULL, 
    target_audience_id_target_audience       NUMBER
);

ALTER TABLE toy ADD CONSTRAINT toy_pk PRIMARY KEY ( id_toy );

CREATE TABLE warehouse (
    id_warehouse NUMBER NOT NULL,
    address      VARCHAR2(250),
    contacts     VARCHAR2(250),
    количество   NUMBER NOT NULL
);

ALTER TABLE warehouse ADD CONSTRAINT warehouse_pk PRIMARY KEY ( id_warehouse );

ALTER TABLE concept
    ADD CONSTRAINT concept_target_audience_fk FOREIGN KEY ( target_audience_id_target_audience )
        REFERENCES target_audience ( id_target_audience );

ALTER TABLE concept
    ADD CONSTRAINT concept_toy_fk FOREIGN KEY ( toy_id_toy )
        REFERENCES toy ( id_toy );

ALTER TABLE consignment_note
    ADD CONSTRAINT consignment_note_toy_fk FOREIGN KEY ( toy_id_toy )
        REFERENCES toy ( id_toy );

ALTER TABLE consignment_note
    ADD CONSTRAINT consignment_note_warehouse_fk FOREIGN KEY ( warehouse_id_warehouse )
        REFERENCES warehouse ( id_warehouse );

ALTER TABLE material_packaging
    ADD CONSTRAINT material_packaging_materials_fk FOREIGN KEY ( materials_id_material )
        REFERENCES materials ( id_material );

ALTER TABLE material_packaging
    ADD CONSTRAINT material_packaging_packagings_fk FOREIGN KEY ( packagings_id_packaging )
        REFERENCES packagings ( id_packaging );

ALTER TABLE materials_for_toy
    ADD CONSTRAINT materials_for_toy_materials_fk FOREIGN KEY ( materials_id_material )
        REFERENCES materials ( id_material );

ALTER TABLE materials_for_toy
    ADD CONSTRAINT materials_for_toy_toy_fk FOREIGN KEY ( toy_id_toy )
        REFERENCES toy ( id_toy );

ALTER TABLE officer
    ADD CONSTRAINT officer_concept_fk FOREIGN KEY ( concept_id_concept )
        REFERENCES concept ( id_concept );

ALTER TABLE officer
    ADD CONSTRAINT officer_officer_fk FOREIGN KEY ( officer_id_officer )
        REFERENCES officer ( id_officer );

ALTER TABLE officer
    ADD CONSTRAINT officer_position_fk FOREIGN KEY ( position_id_position )
        REFERENCES position ( id_position );

ALTER TABLE officer
    ADD CONSTRAINT officer_store_fk FOREIGN KEY ( store_id_store )
        REFERENCES store ( id_store );

ALTER TABLE sanitary_blank
    ADD CONSTRAINT sanitary_blank_sanitary_requirements_fk FOREIGN KEY ( sanitary_requirements_registry_nomber )
        REFERENCES sanitary_requirements ( registry_nomber );

ALTER TABLE sanitary_blank
    ADD CONSTRAINT sanitary_blank_toy_fk FOREIGN KEY ( toy_id_toy )
        REFERENCES toy ( id_toy );

ALTER TABLE supply_list
    ADD CONSTRAINT supply_list_materials_fk FOREIGN KEY ( materials_id_material )
        REFERENCES materials ( id_material );

ALTER TABLE supply_list
    ADD CONSTRAINT supply_list_suppliers_fk FOREIGN KEY ( suppliers_id_supplier )
        REFERENCES suppliers ( id_supplier );

ALTER TABLE toy
    ADD CONSTRAINT toy_collection_fk FOREIGN KEY ( collection_id_collection )
        REFERENCES collection ( id_collection );

ALTER TABLE toy
    ADD CONSTRAINT toy_packagings_fk FOREIGN KEY ( packagings_id_packaging )
        REFERENCES packagings ( id_packaging );

ALTER TABLE toy
    ADD CONSTRAINT toy_target_audience_fk FOREIGN KEY ( target_audience_id_target_audience )
        REFERENCES target_audience ( id_target_audience );
