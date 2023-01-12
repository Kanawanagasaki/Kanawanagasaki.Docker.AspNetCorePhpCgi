clear
docker build -t aspnetcore-phpcgi:0.1 .
docker run -ti --name phpcgi --rm -p 80:80 -v K:\docker\test:/www aspnetcore-phpcgi:0.1