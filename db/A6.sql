use se410;

drop table if exists modulematerialslink;
drop table if exists materialcomments;
drop table if exists materials;
drop table if exists moduleLog;
drop table if exists moduleType;
drop table if exists moduleratings;
drop table if exists otherResources;
drop table if exists module;
drop table if exists categories;
drop table if exists moduleBases;
drop table if exists recovery;
drop table if exists currLogins;
DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `loginID` int(11) NOT NULL,
  `user` varchar(45) DEFAULT NULL,
  `pass` varchar(45) DEFAULT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `groups` text default null,
  PRIMARY KEY (`loginID`)
);

create table materials (
	materialID int(10) not null,
    type text not null,
    content text default null,
    readableFilename text default null,
    dt datetime not null,
    format text default null,
    creatorID int(11) default null,
    linktoMat text default null,
    rating int(2) default null,
    NumberOfRatings int(10) default null,
    accessFlag text default null,
    
    primary key (materialID),
    foreign key (creatorID) references login(loginID)
);

create table materialcomments (
	materialID int (10) not null,
    comments text default null,
    subject text default null,
    date date default null,
    rating int(2) default null,
    author text default null,
    numOfRatings int(10) default null,
    
    foreign key(materialID) references materials(materialID)
);

create table categories (
	categoryID int(10) not null,
    name varchar(10) not null,
    description text default null,
    primary key (categoryID)
);

create table moduleBases (
	baseID int(5) not null,
    title text default null,
    moduleIdentifier text default null,
    
    primary key(baseID)
);

create table module (
	moduleID int(5) NOT NULL,
    creatorID int(11) default null,
    baseID int(5) default null,
    categoryID int(10) default null,
    dt datetime default null,
    description text default null,
    lang text default null,
    educationLvl int(2) default null,
    minutes int(4) default null,
    authorName text default null,
    authorComments text default null,
    status text default null,
    minUserType tinyint(4) default null,
    interactType text default null,
    rights text default null,
    version int(5) default null,
    checkinComments text default null,
    restrictions text default null,
    objectiveText text default null,
    prereqText text default null,
    
    primary key (moduleID),
    foreign key (creatorID) references login(loginID),
    foreign key (categoryID) references categories(categoryID),
    foreign key (baseID) references moduleBases(baseID)
);

create table modulematerialslink (
	moduleID int(5) not null,
    materialID int(5) not null,
    orderID int(5) not null,
    
    primary key(moduleID, materialID),
    foreign key(moduleID) references module(moduleID),
    foreign key(materialID) references materials(materialID)
);

create table otherResources (
	moduleID int(5) not null,
    description text default null,
    resourceLink text default null,
    
    primary key(moduleID),
    foreign key(moduleID) references module(moduleID)
);

create table moduleratings (
	moduleID int(5) not null,
    rating int(2) default null,
    numOfRatings int(4) default null,
    
    primary key(moduleID),
    foreign key(moduleID) references module(moduleID)
);

create table moduleType (
	moduleID int(5) not null,
    typeID int(3) not null,
    name text default null,
    
    primary key(moduleID, typeID),
    foreign key(moduleID) references module(moduleID)
);

create table moduleLog (
	moduleID int(5) not null,
    msg text default null,
    userID int(11) default null,
    
    foreign key(moduleID) references module(moduleID),
    foreign key(userID) references login(loginID)
);

create table currLogins (
	currLoginID int(11) not null,
    userID int(11) default null,
    authToken text default null,
    expires datetime default null,
    
    primary key(currLoginID),
    foreign key(userID) references login(loginID)
);

create table recovery (
	id int(11) not null,
    userID int(11) default null,
    token text default null,
    expires datetime default null,
    
    primary key(id),
    foreign key(userID) references currLogins(userID)
);