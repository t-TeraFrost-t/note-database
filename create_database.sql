drop database notes_database;
create database notes_database;
use notes_database;
create table importance
(
	id int auto_increment primary key,
    text_type char(32)  unique not null
);
create table user
(
	id int auto_increment primary key,
    name varchar(32) unique not null,
    password char(32) not null
);
create table task
(
	id int auto_increment primary key,
    name char(32) unique not null, 
    text_task text not null,
    id_importance int not null,
    id_user int,
    start_date datetime,
    end_date datetime,
    constraint fk_task_importance foreign key (id_importance) REFERENCES  `importance`(id),
    constraint fk_task_user foreign key (id_user) REFERENCES  `user`(id)
);
create table note
(
	id int auto_increment primary key,
	name char(32) unique not null, 
    text_note text not null,
	start_date datetime,
    id_importance int not null,
    id_user int null,
    id_task int null,  
    constraint fk_note_importance foreign key (id_importance) REFERENCES  `importance`(id),
    constraint fk_note_user foreign key (id_user) REFERENCES  `user`(id),
    constraint fk_note_task foreign key (id_task) REFERENCES  `task`(id)
    
);

call select_task_user_substring(1,"1");
	insert into importance (text_type)
     values ("Important"),
             ("Not_Important");