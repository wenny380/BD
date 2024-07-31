/*Database creation*/
DROP DATABASE teamfourdb;
CREATE DATABASE IF NOT EXISTS `teamFourDb` ;
USE `teamFourDb` ;

/*Table Faculty*/
CREATE TABLE IF NOT EXISTS `teamFourDb`.`Faculty` (
`idFaculty` INT NOT NULL AUTO_INCREMENT,
`FacultyName` VARCHAR(255) NOT NULL,
`noCorpus` INT NOT NULL,
PRIMARY KEY (`idFaculty`))
ENGINE = InnoDB;

/*Table Teacher*/
CREATE TABLE IF NOT EXISTS `teamFourDb`.`Teacher` (
`idTeacher` INT NOT NULL AUTO_INCREMENT,
`lastName` VARCHAR(255) NOT NULL,
`firstName` VARCHAR(255) NOT NULL,
`middleName` VARCHAR(255) NULL,
PRIMARY KEY (`idTeacher`))
ENGINE = InnoDB;

/*Table Class category*/
CREATE TABLE IF NOT EXISTS `teamFourDb`.`Class_Category` (
`idClassCategory` INT NOT NULL AUTO_INCREMENT,
`titleCateg` VARCHAR(255) NOT NULL,
`totalHours` INT NOT NULL,
PRIMARY KEY (`idClassCategory`))
ENGINE = InnoDB;

/*Table Subject*/
CREATE TABLE IF NOT EXISTS `teamFourDb`.`Subjecte` (
`idSubject` INT NOT NULL AUTO_INCREMENT,
`title` VARCHAR(255) NOT NULL,
PRIMARY KEY (`idSubject`))
ENGINE = InnoDB;

/*Table Major*/
CREATE TABLE IF NOT EXISTS `teamFourDb`.`Major` (
`idMajor` INT NOT NULL AUTO_INCREMENT,
`majorName` VARCHAR(255) NOT NULL,
`noMajor` INT NOT NULL,
PRIMARY KEY (`idMajor`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `teamFourDb`.`Profil` (
`profil` VARCHAR(255) NOT NULL,
`idFaculty` INT NOT NULL,
`idMajor` INT NOT NULL,
PRIMARY KEY (`idFaculty`, `idMajor`),
CONSTRAINT `fk_idFaculty_1x`
FOREIGN KEY (`idFaculty`)
REFERENCES `teamFourdb`.`Faculty` (`idFaculty`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_idMajor_1x` FOREIGN KEY (`idMajor`)
REFERENCES `teamFourdb`.`Major` (`idMajor`)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `teamFourDb`.`Admission_Year` (
`yearx`	INT NOT NULL,
`idFaculty` INT NOT NULL,
`idMajor` INT NOT NULL,
PRIMARY KEY(`yearx`, `idFaculty`, `idMajor`),
CONSTRAINT `fk_admission_year` FOREIGN KEY (`idFaculty`)
REFERENCES `teamFourdb`. `Profil`(`idFaculty`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_admission_year1` FOREIGN KEY (`idMajor`)
REFERENCES `teamFourDb`. `Profil`(`idMajor`)
ON DELETE NO ACTION
ON UPDATE NO ACTION
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `teamFourDb`. `Plan_Subject` (
`semester` INT NOT NULL,
`yearx` INT NOT NULL,
`idFaculty` INT NOT NULL,
`idMajor` INT NOT NULL,
`idSubject` INT NOT NULL,
`idClassCategory` INT NOT NULL,
`totalCourseHours` INT NOT NULL,
PRIMARY KEY (`semester`,`yearx`,`idFaculty`,`idMajor`,`idSubject`,`idClassCategory`),
CONSTRAINT `fk_plan_subject` FOREIGN KEY (`yearx`)
REFERENCES `teamFourDb`. `Admission_Year`(`yearx`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_plan_subject2` FOREIGN KEY (`idFaculty`)
REFERENCES `teamFourDb`. `Admission_Year`(`idFaculty`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_plan_subject3` FOREIGN KEY (`idMajor`)
REFERENCES `teamFourDb`. `Admission_Year`(`idMajor`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_plan_subject4` FOREIGN KEY (`idSubject`)
REFERENCES `teamFourDb`. `Subjecte`(`idSubject`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_plan_subject5` FOREIGN KEY (`idClassCategory`)
REFERENCES `teamFourDb`. `Class_Category`(`idClassCategory`)
ON DELETE NO ACTION
ON UPDATE NO ACTION
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `teamFourDb`.`Groupx` (
`idGroup`	INT NOT NULL,
`idStudent` INT NOT NULL,
`yearx` INT NOT NULL,
`Namex` VARCHAR(20),
`idFaculty` INT NOT NULL,
`idMajor` INT NOT NULL,
PRIMARY KEY(`idGroup`),
CONSTRAINT `fk_group` FOREIGN KEY (`yearx`)
REFERENCES `teamFourdb`. `Admission_Year`(`yearx`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_group2` FOREIGN KEY (`idFaculty`)
REFERENCES `teamFourDb`. `Admission_Year`(`idFaculty`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_group3` FOREIGN KEY (`idMajor`)
REFERENCES `teamFourDb`. `Admission_Year`(`idMajor`)
ON DELETE NO ACTION
ON UPDATE NO ACTION
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `teamFourDb`.`Student` (
`idStudent`	INT NOT NULL,
`lastName` VARCHAR(255) NOT NULL,
`firstName` VARCHAR(255) NOT NULL,
`middleName` VARCHAR(255) NULL,
`idGroup` INT NOT NULL,
PRIMARY KEY(`idStudent`),
CONSTRAINT `fk_student` FOREIGN KEY (`idGroup`)
REFERENCES `teamFourdb`. `Groupx`(`idGroup`)
ON DELETE NO ACTION
ON UPDATE NO ACTION
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `teamFourDb`.`Groupx` (
`idStudent` INT NOT NULL,
CONSTRAINT `fk_group2` FOREIGN KEY (`idStudent`)
REFERENCES `teamFourdb`. `Student`(`idStudent`)
ON DELETE NO ACTION
ON UPDATE NO ACTION
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `teamFourDb`.`Conduct_Class` (
`idConductClass` INT NOT NULL,
`idTeacher` INT NOT NULL,
`semester` INT NOT NULL,
`yearx` INT NOT NULL,
`idFaculty` INT NOT NULL,
`idMajor` INT NOT NULL,
`idSubject` INT NOT NULL,
`idClassCategory` INT NOT NULL,
`idGroup` INT NOT NULL,
PRIMARY KEY (`idConductClass`),
CONSTRAINT `fk_conduct_class1`
FOREIGN KEY (`idTeacher`)
REFERENCES `teamFourdb`.`Teacher` (`idTeacher`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_conduct_class2` FOREIGN KEY (`semester`)
REFERENCES `teamFourdb`.`Plan_Subject` (`semester`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_conduct_class3` FOREIGN KEY (`yearx`)
REFERENCES `teamFourdb`.`Plan_Subject` (`yearx`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_conduct_class4` FOREIGN KEY (`idFaculty`)
REFERENCES `teamFourdb`.`Plan_Subject` (`idFaculty`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_conduct_class5` FOREIGN KEY (`idMajor`)
REFERENCES `teamFourdb`.`Plan_Subject` (`idMajor`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_conduct_class6` FOREIGN KEY (`idSubject`)
REFERENCES `teamFourdb`.`Plan_Subject` (`idSubject`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_conduct_class7` FOREIGN KEY (`idClassCategory`)
REFERENCES `teamFourdb`.`Plan_Subject` (`idClassCategory`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_conduct_class8` FOREIGN KEY (`idGroup`)
REFERENCES `teamFourdb`.`Groupx` (`idGroup`)
ON DELETE NO ACTION
ON UPDATE NO ACTION
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `teamFourDb`.`Class` (
`idClass` INT NOT NULL,
`datex` DATE NOT NULL,
`orderClass` INT NOT NULL,
`theme` VARCHAR(255) NOT NULL,
`idConductClass` INT NOT NULL,
PRIMARY KEY(`idClass`),
CONSTRAINT `fk_class` FOREIGN KEY (`idConductClass`)
REFERENCES `teamFourdb`. `Conduct_Class`(`idConductClass`)
ON DELETE NO ACTION
ON UPDATE NO ACTION
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `teamFourDb`.`Attendence` (
`idClass` INT NOT NULL,
`idStudent` INT NOT NULL,
PRIMARY KEY(`idClass`, `idStudent`),
CONSTRAINT `fk_attendence1` FOREIGN KEY (`idClass`)
REFERENCES `teamFourdb`. `Class`(`idClass`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_attendence2` FOREIGN KEY (`idStudent`)
REFERENCES `teamFourdb`. `Student`(`idStudent`)
ON DELETE NO ACTION
ON UPDATE NO ACTION
)
ENGINE = InnoDB;





/* REMPLIR LES TABLEAUX*/


use teamFourDb;
show columns from Faculty;
insert into Faculty(idFaculty, FacultyName, noCorpus)values
(1, 'IPAIT', 11),
(2, 'ASI', 16),
(3, 'UEH', 18);

use teamFourDb;
show columns from Teacher;
insert into Teacher(idTeacher, lastName, firstName, middleName)values
(1, 'Montezima', 'Daniel', 'Moise'),
(2, 'Sainteus', 'Stern', 'Sterni'),
(3, 'Constant', 'Valdy', 'Luc'),
(4, 'Montezima', 'Valdy', 'Luc');

use teamFourDb;
show columns from Class_Category;
insert into Class_Category(idClassCategory, titleCateg, totalHours)values
(1, 'Leksi', 24),
(2, 'Laboratory', 32),
(3, 'Pratique', 12);

use teamFourDb;
show columns from Subjecte;
insert into Subjecte(idSubject, title)values
(1, 'Data base'),
(2, 'Programming'),
(3, 'Network');

use teamFourDb;
show columns from Major;
insert into Major(idMajor, majorName, noMajor)values
(1, 'computer science', 09234),
(2, 'Economic', 09235),
(3, 'Engineering', 09236);

use teamFourDb;
show columns from Profil;
insert into Profil(profil, idFaculty, idMajor)values
('programmer', 1, 1),
 ('manager', 1,2),
 ('ingenieur', 2, 3);
 
 use teamFourDb;
show columns from Admission_Year;
insert into Admission_Year(yearx,idfaculty,idMajor)values
(2017,1,1),
(2018,2,1),
(2019,1,2);

 use teamFourDb;
show columns from Plan_Subject;
insert into Plan_Subject(semester,yearx,idFaculty,idMajor,idSubject,idClassCategory,totalCourseHours)values
(1,2017,1,1,1,2,2000),
(2,2018,2,1,1,2,2500),
(3,2019,1,2,3,2,1500);

use teamFourDb;
show columns from Groupx;
insert into Groupx (idGroup,idStudent,yearx,Namex,idFaculty,idMajor)values
(1,2,2017,'92pg',1,1),
(2,3,2019,'92pg',1,2),
(3,1,2018,'92pg',2,1);

use teamFourDb;
show columns from Student;
insert into Student(idStudent,lastName,firstName,middleName,idGroup)values
(1,'Joseph','Wen',Null,3),
(2,'Sainteus','Sterni',Null,1),
(3,'Moise','Wena',Null,3);

use teamFourDb;
show columns from Conduct_Class;
insert into Conduct_Class(idConductClass,idTeacher,semester,yearx,idFaculty,idMajor,idSubject,idClassCategory, idGroup)values
(1,1,1,2017,1,1,1,2,2),
(2,2,1,2018,2,1,1,2,1),
(3,2,2,2019,1,2,3,2,3);

use teamFourDb;
show columns from Class;
insert into Class(idClass,datex,orderClass,theme,idConductClass)values
(1,'2019-05-11',2,'Math calculus', 2),
(2,'2019-05-16',2,'Math calculus2', 3),
(3,'2019-05-18',2,'Math calculus3', 1),
(4,'2019-04-11',2,'Math calculus3', 1);

use teamFourDb;
show columns from Attendence;
insert into Attendence(idClass,idStudent)values
(1,2),
(1,3),
(1,1),
(2,3),
(4,1),
(2,2),
(3,2);
 
/*LAB 5 ............*/

/*SELECT * FROM  teamFourDb.Student;
SELECT * FROM  teamFourDb.Attendence;
SELECT * FROM  teamFourDb.Admission_Year;
SELECT * FROM  teamFourDb.Major;
SELECT * FROM  teamFourDb.Profil;
SELECT * FROM  teamFourDb.Plan_Subject;
SELECT * FROM  teamFourDb.Teacher;
SELECT * FROM  teamFourDb.Faculty;
SELECT * FROM  teamFourDb.Subjecte;
SELECT * FROM  teamFourDb.Conduct_Class;
SELECT * FROM  teamFourDb.Groupx;
SELECT * FROM  teamFourDb.Class;
SELECT * FROM  teamFourDb.Class_Category;


//////////Задание 2 Построить запросы: декартового произведения, левого
внешнего, правого внешнего, естественного и полного внешнего соединения.

use teamFourDb;
select Student.firstName from Student;

декартового произведения
select * from Major join Groupx; */

/*jointure externe gauche*/
select Student.firstName, Groupx.idGroup 
from Student 
left join Groupx
on Student.idStudent = Groupx.idStudent
order by Student.firstName;  

/*правого внешнего*/
select Student.firstName, Groupx.idGroup 
from Student 
right join Groupx
on Student.idStudent = Groupx.idStudent
order by Student.firstName;  

/*естественного соединения*/
select Student.firstName, Groupx.idGroup 
from Student 
inner join Groupx
on Groupx.idStudent = Student.idStudent
order by Student.firstName;  


select Student.firstName, Groupx.idGroup 
from Student 
left join Groupx
on Groupx.idStudent = Student.idStudent
right join Groupx on Groupx.idGroup = Student.idGroup;


/*агрегирующие*/

select count(idTeacher)
from Teacher;

select avg(yearx)
from Admission_Year;

select sum(idTeacher)
from Teacher;

/*с группировкой*/
select lastname
from Teacher 
group by lastname; 

/*С подзапросом, возвращающем единственное значение*/
select * from Student where idStudent =(select Groupx.idStudent from Groupx where Groupx.idStudent=1 );

alter table Attendence
add presence bit default 0;

SELECT count(Attendence.idStudent), Student.lastName from Attendence inner join Student on Attendence.idStudent=Student.idStudent where idClass IN (select Class.idClass from Class where Class.datex between '2019-05-01'and '2019-05-31')
and Attendence.idStudent IN (select Student.idStudent from Student where Student.idGroup IN (select idGroup from Groupx where Namex='92pg')) and Attendence.presence=0 
 group by Attendence.idStudent;
 
 SELECT count(Attendence.idStudent), Student.lastName FROM Attendence inner join Student 
 on Attendence.idStudent=Student.idStudent  group by Attendence.idStudent;


