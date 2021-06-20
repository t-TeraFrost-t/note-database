delimiter ^^
create procedure select_note()
 begin
  select * 
  from note;
 end ^^
delimiter ^^
create procedure select_note_id_user( id_u int )
 begin
  select * 
  from note
  where id_user=id_u;
 end ^^
 
 create procedure select_note_id_task( id_tsk int )
 begin
  select * 
  from note
  where id_task=id_tsk;
 end ^^
  
 create procedure select_note_id( id_ int )
 begin
  select * 
  from note
  where id=id_;
 end ^^
 delimiter ^^
 create procedure insert_note(name char(32),text text,id_importance int,id_user int,id_task int, start_date datetime)
	begin 
     DECLARE is_null CONDITION FOR SQLSTATE '45000';
    DECLARE non_existant CONDITION FOR SQLSTATE '45001';
    if(name is Null)then 
     SIGNAL is_null
    SET MESSAGE_TEXT = 'name is null';
     end if;
    if(start_date is Null)then 
     SIGNAL is_null
    SET MESSAGE_TEXT = 'start_date is null';
     end if; 
    if(text is Null)then 
		SIGNAL is_null
    SET MESSAGE_TEXT = 'text is null';
     end if;
    if(id_importance is Null)then 
    SIGNAL is_null
    SET MESSAGE_TEXT = 'id_importance is null';
     end if;
     if((select id from importance 
		where id=id_importance) is Null)
        then 
        SIGNAL non_existant
    SET MESSAGE_TEXT = 'this importance does not exist';
     end if;
     
     if(id_task is null)
      then if(id_user is null)
            then SIGNAL is_null
    SET MESSAGE_TEXT = 'id_task and id_user are null';
            elseif((select id from user 
		        where id=id_user) is Null)
                 then 
                  SIGNAL non_existant
                   SET MESSAGE_TEXT = 'this user does not exist';
				end if;
          elseif(id_user is not null)      
                then SIGNAL is_null
				SET MESSAGE_TEXT = 'id_task and id_user cant be bouth conected';
                elseif((select id from task 
		        where id=id_task) is Null)
                 then 
                  SIGNAL non_existant
                   SET MESSAGE_TEXT = 'this task does not exist';
				end if; 
     insert into note(name,text_note,start_date,id_importance,id_user,id_task)
      value (name ,text,start_date ,id_importance ,id_user ,id_task);
     end^^  
 delimiter ^^ 
  create procedure update_note(id_ int,name_ char(32),text_ text,id_im int,id_u int,id_ta int,start_d datetime)
     begin
     
     DECLARE is_null CONDITION FOR SQLSTATE '45000';
    DECLARE non_existant CONDITION FOR SQLSTATE '45001';
    if(id_ is Null)then 
     SIGNAL is_null
    SET MESSAGE_TEXT = 'id is null';
     end if;
     if(start_d is Null)then 
     SIGNAL is_null
    SET MESSAGE_TEXT = 'start_date is null';
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
     if((select id from importance 
		where id=id_im) is Null)
        then 
        SIGNAL non_existant
    SET MESSAGE_TEXT = 'this importance does not exist';
     end if;
     
     if(id_ta is null)
      then if(id_u is null)
            then SIGNAL is_null
    SET MESSAGE_TEXT = 'id_task and id_user are null';
            elseif((select id from user 
		        where id=id_u) is Null)
                 then 
                  SIGNAL non_existant
                   SET MESSAGE_TEXT = 'this user does not exist';
				end if;
          elseif(id_u is not null)      
                then SIGNAL is_null
				SET MESSAGE_TEXT = 'id_task and id_user cant be bouth conected';
                elseif((select id from task 
		        where id=id_ta) is Null)
                 then 
                  SIGNAL non_existant
                   SET MESSAGE_TEXT = 'this task does not exist';
				end if; 
     update note 
      set name=name_,text_note=text_,start_date= start_d,id_importance=id_im,id_user=id_u,id_task=id_ta
       where id=id_;
     end ^^
     create procedure delete_note(id_d int)
     begin
      delete from note
       where id=id_d;
     end ^^