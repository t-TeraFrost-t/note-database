drop procedure select_user;
delimiter ^^
create procedure select_user(usern char(32),pass char(32))
 begin 
 
 select id,name
  from user
  where name=usern and password=pass;
 
 end ^^
create procedure insert_user(name char(32), password char(32))
	begin
    DECLARE is_null CONDITION FOR SQLSTATE '45000';
    
 
    if(name is Null)then 
  SIGNAL is_null
    SET MESSAGE_TEXT = 'name is null';
     end if;
    if(password is Null)then 
   SIGNAL is_null
    SET MESSAGE_TEXT = 'password is null';
     end if;
     
     insert into user(name,password)
      value (name,password);
     end^^