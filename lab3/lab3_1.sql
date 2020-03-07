/* Create a database named BookLibray */
create database BookLibray;
use booklibray;

/* The tables in the database are structured as follows */
create table Books
(
	BookCode int unsigned primary key,
    BookTile char(150),
    AuthorName char(100),
    Edition char(50),
    BookPrice decimal,
    Copies int unsigned
);

create table Members
(
	MemberCode int unsigned primary key,
    MemberName char(100),
    Address char(200),
    PhoneNumber char(11)
);

create table IssueDetails
(
	BookCode int unsigned,
    MemberCode int unsigned,
    IssueDate datetime default current_timestamp,
    ReturnDate datetime
);

alter table IssueDetails 
add constraint fk1 foreign key (BookCode) references Books (BookCode),
add constraint fk2 foreign key (MemberCode) references Members (MemberCode);

/* Remove the Foreign Key constraint of the IssueDetails table */
alter table IssueDetails
drop foreign key fk2,
drop foreign key fk1;

/* Delete the Primary Key constraint of the Member and Book table */
alter table Members drop primary key;
alter table Books drop primary key;

/* Add primary key for Member and Book tables */
alter table booklibray.books add primary key (BookCode);
alter table booklibray.members add primary key (MemberCode);

/* Add new Foreign Key constraints to the IssueDetails table */
alter table booklibray.issuedetails
add constraint fk1 foreign key (BookCode) references Books (BookCode),
add constraint fk2 foreign key (MemberCode) references Members (MemberCode);

/* Add check constraints BookPrice > 0 and <200 */
alter table booklibray.books add constraint limitBookPrice check ( BookPrice between 0 and 200);

#Add a unique constraint to the PhoneNumber of the Member table
alter table booklibray.members add constraint unique (PhoneNumber);

#Add a NOT NULL constraint for BookCode, MemberCode in the IssueDetails table
alter table booklibray.issuedetails modify MemberCode int unsigned not null;
alter table booklibray.issuedetails modify BookCode int unsigned not null;

#Creates a primary key consisting of two columns BookCode and MemberCode for the IssueDetails table
alter table booklibray.issuedetails add primary key (BookCode, MemberCode);

#Insert logical data for tables (Using SQL)
insert into booklibray.books (BookCode,BookTile,AuthorName,Edition,BookPrice,Copies) values
(1, "Giao trinh Triet Hoc", "BGD", "document", 100000, 20),
(2, "Java Core", "Cay S. Horstmann", "IT", 28, 5),
(3, "Harry Potter", "J. K. Rowling and Mary GrandPre", "novel", 23, 4);

insert into booklibray.members (MemberCode,MemberName,Address,PhoneNumber) values
(1, "a", "a", "113"),
(2, "b", "b", "114"),
(3, "c", "c", "115");

insert into booklibray.issuedetails (BookCode,MemberCode,ReturnDate) values
(1, 3, 20201002),
(1, 2, 20200129),
(2, 3, 20201203),
(3, 1, 20201002),
(1, 1, 20200812);