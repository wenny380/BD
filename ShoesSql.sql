DROP database shoesSport;
CREATE DATABASE IF NOT EXISTS `shoesSport`;
USE `shoesSport`;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Saler` (
`idSaler` INT NOT NULL AUTO_INCREMENT,
`lastName` VARCHAR(255) NOT NULL,
`firstName` VARCHAR(255) NOT NULL,
`middleName` VARCHAR(255) NOT NULL,
PRIMARY KEY (`idSaler`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Clientx` (
`idClient` INT NOT NULL AUTO_INCREMENT,
`lastName` VARCHAR(255) NOT NULL,
`firstName` VARCHAR(255) NOT NULL,
`middleName` VARCHAR(255) NOT NULL,
`telNumber`  VARCHAR(20) NOT NULL,
PRIMARY KEY (`idClient`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Magasin` (
`idMagasin` INT NOT NULL AUTO_INCREMENT,
`adress` VARCHAR(255) NOT NULL,
`MagasinName` VARCHAR(255) NOT NULL,
PRIMARY KEY (`idMagasin`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Firme` (
`idFirme` INT NOT NULL AUTO_INCREMENT,
`firmeName` VARCHAR(255) NOT NULL,
PRIMARY KEY (`idFirme`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Category` (
`idCategory` INT NOT NULL AUTO_INCREMENT,
`categoryName` VARCHAR(255) NOT NULL,
PRIMARY KEY (`idCategory`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Color` (
`idColor` INT NOT NULL AUTO_INCREMENT,
`colorName` VARCHAR(255) NOT NULL,
`quantity` INT NOT NULL,
PRIMARY KEY (`idColor`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Material` (
`idMaterial` INT NOT NULL AUTO_INCREMENT,
`materialName` VARCHAR(255) NOT NULL,
PRIMARY KEY (`idMaterial`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Measure` (
`idMeasure` INT NOT NULL AUTO_INCREMENT,
`measureValue` INT NOT NULL,
`quantityM` INT NOT NULL,
PRIMARY KEY (`idMeasure`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Model` (
`idModel` INT NOT NULL AUTO_INCREMENT,
`quantity` INT NOT NULL,
`idFirme` INT NOT NULL,
`idCategory` INT NOT NULL,
PRIMARY KEY (`idModel`),
CONSTRAINT `fk_idFirme_1x`
FOREIGN KEY (`idFirme`)
REFERENCES `shoesSport`.`Firme` (`idFirme`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_idCategory_1x` FOREIGN KEY (`idCategory`)
REFERENCES `shoesSport`.`Category` (`idCategory`)
ON DELETE CASCADE
ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Model_has_Material` (
`idModel` INT NOT NULL,
`idMaterial` INT NOT NULL,
PRIMARY KEY (`idModel`, `idMaterial`),
CONSTRAINT `fk_idModel_1x`
FOREIGN KEY (`idModel`)
REFERENCES `shoesSport`.`Model` (`idModel`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_idMaterial_1x` FOREIGN KEY (`idMaterial`)
REFERENCES `shoesSport`.`Material` (`idMaterial`)
ON DELETE CASCADE
ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Sneakers` (
`idSneakers` INT NOT NULL AUTO_INCREMENT,
`sneakersName` VARCHAR (255) NOT NULL,
`cost` DECIMAL(10,2) NOT NULL,
`sneakQuantity` INT NOT NULL,
`idMeasure`INT NOT NULL,
`idColor` INT NOT NULL,
`idModel` INT NOT NULL,
PRIMARY KEY (`idSneakers`),
CONSTRAINT `fk_idModel_2x`
FOREIGN KEY (`idModel`)
REFERENCES `shoesSport`.`Model` (`idModel`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_idMeasure_1x`
FOREIGN KEY (`idMeasure`)
REFERENCES `shoesSport`.`Measure` (`idMeasure`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_idColor_1x` FOREIGN KEY (`idColor`)
REFERENCES `shoesSport`.`Color` (`idColor`)
ON DELETE CASCADE
ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Sale` (
`idSale` INT NOT NULL AUTO_INCREMENT,
`dateS` DATE,
`totalPrice` DECIMAL(10,2) NOT NULL,
`guarantee` INT NOT NULL,
`product_quantity` INT NOT NULL,
`idMagasin`INT NOT NULL,
`idSaler` INT NOT NULL,
PRIMARY KEY (`idSale`),
CONSTRAINT `fk_idMagasin_1x`
FOREIGN KEY (`idMagasin`)
REFERENCES `shoesSport`.`Magasin` (`idMagasin`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_idSaler_1x`
FOREIGN KEY (`idSaler`)
REFERENCES `shoesSport`.`Saler` (`idSaler`)
ON DELETE CASCADE
ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Sale_has_Sneakers` (
`idSale` INT NOT NULL,
`idSneakers` INT NOT NULL,
`QuantitySale` INT NOT NULL,
`totalPrice` DECIMAL(10,2) NOT NULL,
PRIMARY KEY (`idSale`, `idSneakers`),
CONSTRAINT `fk_idSale_1x`
FOREIGN KEY (`idSale`)
REFERENCES `shoesSport`.`Sale` (`idSale`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_idSneakers_1x`
FOREIGN KEY (`idSneakers`)
REFERENCES `shoesSport`.`Sneakers` (`idSneakers`)
ON DELETE CASCADE
ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Orderx` (
`idOrder` INT NOT NULL AUTO_INCREMENT,
`orderDate` DATE,
`totalCost` DECIMAL(10,2) NOT NULL,
`quantityProduct` INT NOT NULL,
`deadline` INT NOT NULL,
`idClient` INT NOT NULL,
`idMagasin`INT NOT NULL,
`idSaler` INT NOT NULL,
`Statut` VARCHAR(255) NOT NULL,
PRIMARY KEY (`idOrder`),
CONSTRAINT `fk_idMagasin_2x`
FOREIGN KEY (`idMagasin`)
REFERENCES `shoesSport`.`Magasin` (`idMagasin`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_idSaler_2x`
FOREIGN KEY (`idSaler`)
REFERENCES `shoesSport`.`Saler` (`idSaler`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_idClient_1x`
FOREIGN KEY (`idClient`)
REFERENCES `shoesSport`.`Clientx` (`idClient`)
ON DELETE CASCADE
ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `shoesSport`.`Order_has_Sneakers` (
`idOrder` INT NOT NULL,
`idSneakers` INT NOT NULL,
`QuantityOrder` INT NOT NULL,
`totalPriceOrder` DECIMAL(10,2) NOT NULL,
PRIMARY KEY (`idOrder`, `idSneakers`),
CONSTRAINT `fk_idOrder_1x`
FOREIGN KEY (`idOrder`)
REFERENCES `shoesSport`.`Orderx` (`idOrder`)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `fk_idSneakers_2x`
FOREIGN KEY (`idSneakers`)
REFERENCES `shoesSport`.`Sneakers` (`idSneakers`)
ON DELETE CASCADE
ON UPDATE CASCADE)
ENGINE = InnoDB;

use shoesSport;
show columns from Saler;
insert into Saler(idSaler, lastName, firstName,middleName)values
(1, 'Joseph','Wen','Josa'),
(2, 'Josette','Macelus','Shwenny'),
(3, 'Josepha','May','Sagnon');

use shoesSport;
show columns from Clientx;
insert into Clientx(idClient, lastName, firstName, middleName, telNumber)values
(1, 'Moise','Registe','Olem','892566221574'),
(2, 'Abraham','Jules','Andre','89532664521'),
(3, 'Hebert','Dean','Phillip','87854565218');

use shoesSport;
show columns from Magasin;
insert into Magasin(idMagasin, adress, MagasinName)values
(1, 'Baraderes', 'WenSport'),
(2, 'Cap-haitien','WenSport'),
(3, 'Jacmel','WenSport');

use shoesSport;
show columns from Firme;
insert into Firme(idFirme, firmeName)values
(1, 'Adidas'),
(2, 'Nike'),
(3, 'Pumas');

use shoesSport;
show columns from Category;
insert into Category(idCategory, categoryName)values
(1, 'football'),
(2, 'running'),
(3, 'basket-ball');

use shoesSport;
show columns from Color;
insert into Color(idColor, colorName, quantity)values
(1, 'Rouge', 50 ),
(2, 'Noir', 50),
(3, 'Jaune', 50);

use shoesSport;
show columns from Material;
insert into Material(idMaterial, materialName)values
(1, 'textile'),
(2, 'Cuir'),
(3, 'Peau');

use shoesSport;
show columns from Measure;
insert into Measure(idMeasure, measureValue, quantityM)values
(1, 37, 50 ),
(2, 39, 50),
(3, 43, 50);

use shoesSport;
show columns from Model;
insert into Model(idModel,quantity,idFirme, idCategory)values
(1, 50, 1, 1 ),
(2, 50, 2, 2),
(3, 50, 3, 3);

use shoesSport;
show columns from Model_has_Material;
insert into Model_has_Material(idModel,idMaterial)values
(1, 2),
(2, 2),
(3, 3);

use shoesSport;
show columns from Sneakers;
insert into Sneakers(idSneakers,sneakersName,cost,sneakquantity,idMeasure, idColor, idModel)values
(1, 'Speedy',3000, 100,1, 1,1 ),
(2, 'Mercurial',3500, 100,2, 2,2),
(3, 'Predator',4500, 100,3, 3,3),
(4, 'Danilo',3500, 100,2, 3,2),
(5, 'Sternilo',6000, 100,3, 1,2),
(6, 'Moizo',6000, 150,3, 2,2);

use shoesSport;
show columns from Sale;
insert into Sale(idSale,dateS,totalPrice,guarantee, product_quantity, idMagasin, idSaler)values
(1,'2021-04-12', 7000, 1,3, 1,1 ),
(2,'2021-09-21', 9500, 1,2, 2,2),
(3,'2021-11-15', 11000, 1,4, 3,3);

use shoesSport;
show columns from Sale_has_Sneakers;
insert into Sale_has_Sneakers(idSale,idSneakers,QuantitySale, totalPrice)values
(1,1,2,5000),
(2, 2, 3, 7000),
(3, 3, 1, 5000);

use shoesSport;
show columns from Orderx;
insert into Orderx(idOrder,orderDate,totalCost, quantityProduct, deadline,idClient, idMagasin, idSaler, statut)values
(1,'2021-04-12', 7000, 3, 3,1,1,1, 'non paye' ),
(2,'2021-09-21', 9500, 2, 3,2,2,2,'non paye'),
(3,'2021-04-15', 11000, 4, 3,3,3,3, 'non paye');

use shoesSport;
show columns from Order_has_Sneakers;
insert into Order_has_Sneakers(idOrder,idSneakers,QuantityOrder, totalPriceOrder)values
(1,1,2,5000),
(2, 2, 3, 7000),
(3, 3, 1, 5000);

use shoesSport;
select Sneakers.sneakquantity, Sneakers.sneakersName, Firme.firmeName, Color.colorName 
from (((Sneakers
inner join Color on Sneakers.idColor = Color.idColor)
inner join Model on Sneakers.idModel = Model.idModel)
inner join Firme on Model.idFirme= Firme.idFirme)
 group by Sneakers.idModel;

/*use shoesSport;*/
select Sneakers.sneakquantity, Sneakers.sneakersName, Firme.firmeName, Color.colorName, Measure.measureValue
from ((((select * from Sneakers inner join Color on Sneakers.idColor = Color.idColor)
inner join Model on Sneakers.idModel = Model.idModel)
inner join Firme on Model.idFirme= Firme.idFirme)
inner join Measure on Sneakers.idMeasure=Measure.idMeasure) where Sneakers.idMeasure=(select Measure.idMeasure from Measure where measureValue=43)
 group by Sneakers.idModel; 

use shoesSport;
select sum(Sneakers.sneakquantity) 
from Sneakers
 where Sneakers.idMeasure=(select Measure.idMeasure from Measure where measureValue=43);

 DELIMITER //
CREATE PROCEDURE GetOrder()
begin
SELECT * FROM Orderx where orderDate between '2021-04-01'and '2021-04-30';
end //
call GetOrder();

CREATE PROCEDURE GetClient(IN firstN varchar(255))
begin
SELECT * FROM Clientx where firstName= firstN ;
end //
call GetClient('Jules');
USE shoesSport;
DELIMITER //
CREATE TRIGGER Price BEFORE INSERT ON Order_has_Sneakers
FOR EACH ROW  
BEGIN
declare var int;
set var= (select sum(totalPriceOrder) from Order_has_Sneakers  where idOrder=new.idOrder)+ 
(select cost from Sneakers where idSneakers= new.idSneakers )* new.QuantityOrder ;
set new.totalPriceOrder =(select cost from Sneakers where idSneakers= new.idSneakers )* new.QuantityOrder;
update `Orderx`
 set `totalCost`= var where Orderx.idOrder=new.idOrder;
END; //
DELIMITER ;
show triggers;
USE shoesSport;
DELIMITER //
CREATE TRIGGER PriceVente BEFORE INSERT ON Sale_has_Sneakers
FOR EACH ROW  
BEGIN
declare var int;
set var= (select sum(totalPrice) from Sale_has_Sneakers  where idSale=new.idSale)+ 
(select cost from Sneakers where idSneakers= new.idSneakers )* new.QuantitySale ;
set new.totalPrice =(select cost from Sneakers where idSneakers= new.idSneakers )* new.QuantitySale;
update `Sale`
 set `totalPrice`= var where Sale.idSale=new.idSale;
 
END; //

show triggers;

USE shoesSport;
CREATE TRIGGER add_Sneakers BEFORE INSERT ON Sneakers
FOR EACH ROW
BEGIN
DECLARE msg VARCHAR(255);
IF (new.cost<=0) THEN
SIGNAL SQLSTATE '45000';
SET msg = 'Цена не может быть меньше или равна 0!';
END IF;
END//


/*insert into Sneakers(idSneakers,sneakersName,cost,sneakquantity,idMeasure, idColor, idModel)values
(7 ,'Speedy',0, 100,1, 1,1 );*/

/*use shoesSport;
select Sneakers.sneakquantity, Sneakers.sneakersName, Firme.firmeName, Color.colorName, Measure.measureValue
from ((((Sneakers where Sneakers.idMeasure=(select Measure.idMeasure from Measure where measureValue=43)
inner join Color on Sneakers.idColor = Color.idColor)
inner join Model on Sneakers.idModel = Model.idModel)
inner join Firme on Model.idFirme= Firme.idFirme)
inner join Measure on Sneakers.idMeasure=Measure.idMeasure) 
 group by Sneakers.idModel; */


-- use shoesSport;
select Sneakers.sneakquantity, Sneakers.sneakersName, Firme.firmeName, Color.colorName, Measure.measureValue
from (((( Sneakers 
inner join Color on Sneakers.idColor = Color.idColor)
inner join Model on Sneakers.idModel = Model.idModel)
inner join Firme on Model.idFirme= Firme.idFirme)
inner join Measure on Sneakers.idMeasure=Measure.idMeasure) where Sneakers.idMeasure=(select Measure.idMeasure from Measure where measureValue=43);








