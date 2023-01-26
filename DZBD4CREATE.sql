create table if not exists Genre (
	id serial primary key,
	name varchar(80) unique not null
);

create table if not exists Executor (
	id serial primary key,
	name varchar(80) unique not null
);

create table if not exists Album (
	id serial primary key,
	name varchar(80) unique not null,
	year integer check (year between 1900 and 2100) not null
);

create table if not exists Track (
	id serial primary key,
	name varchar(80) not null,
	long integer check (long between 0 and 60) not null,
	Album_id integer not null references Album(id)
);

create table if not exists Complitation (
	id serial primary key,
	name varchar(80) not null,
	year integer check (year between 1900 and 2100) not null
);

create table if not exists Executor_Genre (
	id serial primary key,
	Executor integer not null references Executor(id),
	Genre	integer not null references Genre(id)
);

create table if not exists Executor_Album (
	id serial primary key,
	Executor integer not null references Executor(id),
	Album integer not null references Album(id)
);

create table if not exists Track_Complication (
	id serial primary key,
	Track integer not null references Track(id),
	Complitation integer not null references Complitation(id)
);
