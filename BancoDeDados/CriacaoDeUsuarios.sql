create login user1 with password='123456789123'
create user user1 from login user1

create login user2 with password='123456789123'
create user user2 from login user2

create login user3 with password='123456789123'
create user user3 from login user3


grant all to user1
grant alter, execute, view definition to user2 
grant select, insert, update, delete on SCHEMA :: escola to user3
