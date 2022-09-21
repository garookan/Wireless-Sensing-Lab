clc;clear;
delete(instrfindall)
s = serial('COM23','BaudRate',115200);
fopen(s);
for n=1:1000
   a = readline(s)
end