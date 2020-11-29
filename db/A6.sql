use se410;
drop table if exists module;
drop table if exists categories;
drop table if exists materials;
DROP TABLE IF EXISTS `login`;
CREATE TABLE `login` (
  `loginID` int(11) NOT NULL,
  `user` varchar(45) DEFAULT NULL,
  `pass` varchar(45) DEFAULT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`loginID`)
);

create table materials (
	materialID int(10) not null,
    creatorID int(11) default null,
    linktoMat text default null,
    rating int(2) default null,
    NumberOfRatings int(10) default null,
    
    primary key (materialID),
    foreign key (creatorID) references login(loginID)
);

create table categories (
	categoryID int(10) not null,
    name varchar(10) not null,
    description text default null,
    primary key (categoryID)
);

create table module (
	moduleID int(5) NOT NULL,
    creatorID int(11) default null,
    materialID int(10) default null,
    categoryID int(10) default null,
    rating int(2) default null,
    version int(5) default null,
    primary key (moduleID),
    foreign key (creatorID) references login(loginID),
    foreign key (materialID) references materials(materialID),
    foreign key (categoryID) references categories(categoryID)
);

