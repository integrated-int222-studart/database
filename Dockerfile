FROM mysql:8
COPY ./script ./script
EXPOSE 3306:3306 
