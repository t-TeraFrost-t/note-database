delimiter ^^

create procedure select_task()
 begin
 select * 
  from task;
 end ^^
 
 delimiter ^^
 create procedure select_task_user_substring(id_ int, sub char(32))
	begin 
		select * from task
			where id_user = id_ and locate(sub,name);
 
	end^^
 delimiter ^^
 create procedure select_task_id(id_ int)
 begin
 select * 
  from task
  where id = id_;
 end ^^
  delimiter ^^
  create procedure select_task_user(id_u int)
 begin
 select * 
  from task
  where id_user = id_u;
 end ^^
 
   delimiter ^^
 create procedure select_task_under_days(days int)
 begin

 select *,Datediff(end_date,curdate()) as diff from task
   where  Datediff(end_date,curdate())<=days 
   order by end_date desc ;
 end ^^
 create procedure select_task_overdue()
 begin

 select *,Datediff(end_date,curdate()) as diff from task
   where  Datediff(end_date,curdate())<=0 
   order by end_date desc ;
 end ^^
 drop procedure insert_task;
 delimiter ^^
  create procedure insert_task(name char(32),text text,id_importance int,id_user int,start_date date,end_date Date )
	
    begin 
    DECLARE is_null CONDITION FOR SQLSTATE '45000';
    DECLARE non_existant CONDITION FOR SQLSTATE '45001';
    if(name is Null)then 
     SIGNAL is_null
    SET MESSAGE_TEXT = 'name is null';
     end if;
    if(text is Null)then 
     SIGNAL is_null
    SET MESSAGE_TEXT = 'text is null';
     end if;
    if(id_importance is Null)then 
     SIGNAL is_null
    SET MESSAGE_TEXT = 'id_importance is null';
     end if;
     if(id_user is Null)then 
     SIGNAL is_null
    SET MESSAGE_TEXT = 'id_user is null';
     end if;
     
    if(start_date is Null)then
    SIGNAL is_null
    SET MESSAGE_TEXT = 'start_date is null';
     end if;
    
    if(end_date is Null)then 
    SIGNAL is_null
    SET MESSAGE_TEXT = 'end_date is null';
     end if;
     
    if((select id from importance 
		where id=id_importance) is Null)
        then
        SIGNAL non_existant
    SET MESSAGE_TEXT = 'this importance does not exist';
     end if;
     if((select id from user 
		where id=id_user) is Null)
        then 
        SIGNAL non_existant
    SET MESSAGE_TEXT = 'this user does not exist';
     end if; 
     insert into task(name,text_task,id_importance,id_user,start_date,end_date)
      value (name ,text ,id_importance ,id_user ,start_date,end_date);
     end^^ 

delimiter ^^

create procedure update_task(id_ int, name_ char(32), text_ text, id_im int, id_u int, start_d datetime, end_d datetime)
 begin
 
 DECLARE is_null CONDITION FOR SQLSTATE '45000';
    DECLARE non_existant CONDITION FOR SQLSTATE '45001';
    if(id_ is Null)then 
     SIGNAL is_null
    SET MESSAGE_TEXT = 'id is null';
     end if;
    if(name_ is Null)then 
     SIGNAL is_null
    SET MESSAGE_TEXT = 'name is null';
     end if;
    if(text_ is Null)then 
     SIGNAL is_null
    SET MESSAGE_TEXT = 'text is null';
     end if;
    if(id_im is Null)then 
     SIGNAL is_null
    SET MESSAGE_TEXT = 'id_importance is null';
     end if;
     if(id_u is Null)then 
     SIGNAL is_null
    SET MESSAGE_TEXT = 'id_user is null';
     end if;
     
    if(start_d is Null)then
    SIGNAL is_null
    SET MESSAGE_TEXT = 'start_date is null';
     end if;
    
    if(end_d is Null)then 
    SIGNAL is_null
    SET MESSAGE_TEXT = 'end_date is null';
     end if;
     
    if((select id from importance 
		where id=id_im) is Null)
        then
        SIGNAL non_existant
    SET MESSAGE_TEXT = 'this importance does not exist';
     end if;
     if((select id from user 
		where id=id_u) is Null)
        then 
        SIGNAL non_existant
    SET MESSAGE_TEXT = 'this user does not exist';
     end if;
      update task 
      set name = name_, text_task = text_, id_importance=id_im, id_user=id_u, start_date=start_d, end_date=end_d
       where id=id_;
 
 end ^^

   delimiter ^^
     create procedure delete_task(id_d int) 
     begin
     delete from note
        where  id_task = id_d; 
      delete from task
       where id=id_d;
      
     end ^^