--Drop tables if already exists in the schema
DROP TABLE IF EXISTS campaign CASCADE;
DROP TABLE IF EXISTS contact CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS subcategory CASCADE;
---------------------------------------------------------------------------------------
--creating table contact:

CREATE TABLE contact (
    contact_id   INT       NOT NULL,
    first_name   VARCHAR   NOT NULL,
    last_name    VARCHAR   NOT NULL,
    email        VARCHAR   NOT NULL,
    CONSTRAINT pk_contact PRIMARY KEY (contact_id)
);

--checking the data from contact:
SELECT * FROM contact;
----------------------------------------------------------------------------------------
--creating table category:

CREATE TABLE category (
    category_id   VARCHAR       NOT NULL,
    category      VARCHAR   NOT NULL,
    CONSTRAINT pk_category PRIMARY KEY (category_id)
);

--checking the data from contact:
SELECT * FROM category;
------------------------------------------------------------------------------------------
--creating table subcategory:

CREATE TABLE subcategory (
    subcategory_id   VARCHAR   NOT NULL,
    subcategory      VARCHAR   NOT NULL,
    CONSTRAINT pk_subcategory PRIMARY KEY (subcategory_id)
);

--checking the data from subcategory:
SELECT * FROM subcategory;
------------------------------------------------------------------------------------------
--creating table campaign:

CREATE TABLE campaign (
    cf_id            INT       NOT NULL,
    contact_id       INT       NOT NULL,
    company_name     VARCHAR   NOT NULL,
    description      VARCHAR   NOT NULL,
    goal             DECIMAL   NOT NULL,
    pledged          DECIMAL   NOT NULL,
    outcome          VARCHAR   NOT NULL,
    backers_count    INT       NOT NULL,
    country          VARCHAR   NOT NULL,
    currency         VARCHAR   NOT NULL,
    launched_date    DATE      NOT NULL,
    end_date         DATE      NOT NULL,
    category_id      VARCHAR   NOT NULL,
    subcategory_id   VARCHAR   NOT NULL,
    CONSTRAINT pk_campagin PRIMARY KEY (contact_id,category_id,subcategory_id
     )
);

--checking the data from titles:
SELECT * FROM campaign;


--Adding Forieng constraints for child tables

ALTER TABLE campaign ADD CONSTRAINT fk_campaign_contact_id FOREIGN KEY(contact_id)
REFERENCES contact (contact_id);

ALTER TABLE campaign ADD CONSTRAINT fk_campaign_category_id FOREIGN KEY(category_id)
REFERENCES category (category_id);

ALTER TABLE campaign ADD CONSTRAINT fk_campaign_subcategory_id FOREIGN KEY(subcategory_id)
REFERENCES subcategory (subcategory_id);
-------------------------------------------------------------------------------------------

--check the crowdfunding data from all the tables after loading CSV files.

SELECT cp.cf_id,
       cp.contact_id,
       ct.first_name,
       ct.last_name,
       ct.email,
       cp.company_name,
       cp.company_name,
       cp.description,
       cp.goal,
       cp.pledged,
       cp.outcome,
       cp.backers_count,
       cp.country,
       cp.currency,
       cp.launched_date,
       cp.end_date,
       cp.category_id,
       cy.category,
       cp.subcategory_id,
       sc.subcategory
  FROM campaign cp,
       category cy,
       subcategory sc,
       contact ct
 WHERE cp.contact_id=ct.contact_id
   AND cp.category_id=cy.category_id
   AND cp.subcategory_id=sc.subcategory_id;
---------------------------------------------------------------------------------------