create table license_master (
licensenumber varchar(10) not null,
placename varchar(20) not null,
timeslot varchar(20) not null
);

EXEC sp_help 'dbo.license_master';  

create table license_count (
licensenumber varchar(10) Primary key,
placename varchar(20) not null,
totalcount int default 1 not null,
timeslot varchar(20) not null
);

DROP table license_master;
DROP table license_count;

select * from license_master;

select * from license_count;

delete from license_master;
delete from license_count;

insert into license_master (licensenumber,placename) values ('KA41MD5068','DU1');
insert into license_master (licensenumber,placename) values ('KA41EH7353','DU1');
insert into license_master (licensenumber,placename) values ('KA41EH7353','DU2');

MERGE INTO license_count AS t
  USING (SELECT licensenumber='KA41EH7353',placename='DU2',totalcount=1) AS s
  ON t.licensenumber = s.licensenumber
  WHEN MATCHED THEN
  UPDATE SET licensenumber=s.licensenumber, placename=s.placename, totalcount=t.totalcount+1
  WHEN NOT MATCHED THEN
  INSERT (licensenumber, placename, totalcount)
  VALUES (s.licensenumber, s.placename, s.totalcount);

insert_statement ="INSERT INTO license_master (licensenumber,placename,timeslot, filepath) VALUES (?, ?, ?, ?)"
insert_statement1 ='''MERGE INTO license_count AS t
USING (SELECT licensenumber=?,placename=?,totalcount=1, timeslot=?) AS s
ON t.licensenumber = s.licensenumber
WHEN MATCHED THEN
UPDATE SET licensenumber=s.licensenumber, placename=s.placename, totalcount=t.totalcount+1, timeslot=s.timeslot
WHEN NOT MATCHED THEN
INSERT (licensenumber, placename, totalcount, timeslot)
VALUES (s.licensenumber, s.placename, s.totalcount, s.timeslot);'''

create table license_master (
licensenumber varchar(10) not null,
placename varchar(20) not null,
timeslot smalldatetime not null,
filepath varchar(300) not null,
datedifference int default 0 not null
);

EXEC sp_help 'dbo.license_master';  

create table license_count (
licensenumber varchar(10) not null,
placename varchar(20) not null,
totalcount int default 1 not null,
timeslot smalldatetime not null,
filepath varchar(300) not null
);


create TRIGGER licensecounter
ON license_master
AFTER INSERT
AS
   BEGIN
       SET NOCOUNT ON;
 
     DECLARE @licensenumber varchar(10)
	   DECLARE @placename varchar(20)
	   DECLARE @timeslot smalldatetime
	   DECLARE @filepath varchar(300)

 
     SELECT @licensenumber = INSERTED.licensenumber       
       FROM INSERTED
	   SELECT @placename = INSERTED.placename       
       FROM INSERTED
	   SELECT @timeslot = INSERTED.timeslot       
       FROM INSERTED
	   SELECT @filepath = INSERTED.filepath       
       FROM INSERTED

 
  MERGE INTO license_count AS t
  USING (SELECT licensenumber=@licensenumber,placename=@placename,totalcount=1, timeslot=@timeslot, filepath=@filepath) AS s
  ON t.licensenumber = s.licensenumber
  WHEN MATCHED THEN
  UPDATE SET licensenumber=s.licensenumber, placename=s.placename, totalcount=t.totalcount+1, timeslot=s.timeslot, filepath=s.filepath
  WHEN NOT MATCHED THEN
  INSERT (licensenumber, placename, totalcount, timeslot, filepath)
  VALUES (s.licensenumber, s.placename, s.totalcount, s.timeslot, s.filepath);
END



DECLARE @timedif int 
set @timedif = DATEDIFF( MINUTE, (SELECT MAX(timeslot) FROM license_master WHERE licensenumber='KA05EH9955'), GETDATE());
print @timedif;
If not exists(SELECT * FROM license_master t1 WHERE t1.timeslot = (SELECT MAX(timeslot) 
FROM license_master t2 WHERE t2.licensenumber='KA05EH9955' and t2.datedifference>@timedif+(SELECT datedifference 
FROM license_master t3 WHERE t3.licensenumber='KA05EH9955' and t3.timeslot=(SELECT MAX(timeslot) 
FROM license_master t4 WHERE t4.licensenumber='KA05EH9955'))-2))
INSERT INTO license_master (licensenumber,placename,timeslot, filepath, datedifference) 
VALUES ('KA05EH9955', 'DU3', GETDATE(), 'D:/rohan/Documents/License_detection/Backend/images/L_crop31.jpg',ISNULL(DATEDIFF( Minute, (SELECT MAX(timeslot) FROM license_master s2 WHERE s2.licensenumber='KA05EH9955'),GETDATE()),0));



--------------------------------------------------------working below code--------------------------------------------------
----create table------

create table license_master (
licensenumber varchar(10) not null,
placename varchar(20) not null,
timeslot smalldatetime not null,
filepath varchar(300) not null,
datedifference int default 0
);


create table license_count (
licensenumber varchar(10) not null,
placename varchar(20) not null,
totalcount int default 1 not null,
timeslot smalldatetime not null,
filepath varchar(300) not null
);


DROP table license_master;
DROP table license_count;

select * from license_master;
select * from license_count;

delete from license_master;
delete from license_count;

---------create trigger-------

create TRIGGER licensecounter
ON license_master
AFTER INSERT
AS
   BEGIN
       SET NOCOUNT ON;
 
     DECLARE @licensenumber varchar(10)
	   DECLARE @placename varchar(20)
	   DECLARE @timeslot smalldatetime
	   DECLARE @filepath varchar(300)

 
     SELECT @licensenumber = INSERTED.licensenumber       
       FROM INSERTED
	   SELECT @placename = INSERTED.placename       
       FROM INSERTED
	   SELECT @timeslot = INSERTED.timeslot       
       FROM INSERTED
	   SELECT @filepath = INSERTED.filepath       
       FROM INSERTED

 
  MERGE INTO license_count AS t
  USING (SELECT licensenumber=@licensenumber,placename=@placename,totalcount=1, timeslot=@timeslot, filepath=@filepath) AS s
  ON t.licensenumber = s.licensenumber
  WHEN MATCHED THEN
  UPDATE SET licensenumber=s.licensenumber, placename=s.placename, totalcount=t.totalcount+1, timeslot=s.timeslot, filepath=s.filepath
  WHEN NOT MATCHED THEN
  INSERT (licensenumber, placename, totalcount, timeslot, filepath)
  VALUES (s.licensenumber, s.placename, s.totalcount, s.timeslot, s.filepath);
END

---------------------------testing purpose on sql--------------------------------

DECLARE @timedif int 
set @timedif = DATEDIFF( MINUTE, (SELECT MAX(timeslot) FROM license_master WHERE licensenumber='KA05EH9955'), GETDATE());
print @timedif;
If not exists(SELECT * FROM license_master t1 WHERE t1.timeslot = (SELECT MAX(timeslot) 
FROM license_master t2 WHERE t2.licensenumber='KA05EH9955' and t2.datedifference>@timedif+(SELECT datedifference 
FROM license_master t3 WHERE t3.licensenumber='KA05EH9955' and t3.timeslot=(SELECT MAX(timeslot) 
FROM license_master t4 WHERE t4.licensenumber='KA05EH9955'))-2))
INSERT INTO license_master (licensenumber,placename,timeslot, filepath, datedifference) 
VALUES ('KA05EH9955', 'DU3', GETDATE(), 'D:/rohan/Documents/License_detection/Backend/images/L_crop31.jpg',ISNULL(DATEDIFF( Minute, (SELECT MAX(timeslot) FROM license_master s2 WHERE s2.licensenumber='KA05EH9955'),GETDATE()),0));


-----------------------insert to python file--------------------------------

'''DECLARE @timedif int 
set @timedif = DATEDIFF( MINUTE, (SELECT MAX(timeslot) FROM license_master WHERE licensenumber=?), ?);
print @timedif;
If not exists(SELECT * FROM license_master t1 WHERE t1.timeslot = (SELECT MAX(timeslot) 
FROM license_master t2 WHERE t2.licensenumber=? and t2.datedifference>@timedif+(SELECT datedifference 
FROM license_master t3 WHERE t3.licensenumber=? and t3.timeslot=(SELECT MAX(timeslot) 
FROM license_master t4 WHERE t4.licensenumber=?))-2))
INSERT INTO license_master (licensenumber,placename,timeslot, filepath, datedifference) 
VALUES (?, ?, ?, ?,ISNULL(DATEDIFF( Minute, (SELECT MAX(timeslot) FROM license_master s2 WHERE s2.licensenumber=?),?),0));
'''

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------