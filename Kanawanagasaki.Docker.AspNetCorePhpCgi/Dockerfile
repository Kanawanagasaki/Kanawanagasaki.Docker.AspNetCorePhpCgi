FROM php:7.4.33-cli as phpcli
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN docker-php-ext-install opcache && docker-php-ext-enable opcache
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0"
COPY opcache.ini "$PHP_INI_DIR/conf.d/opcache.ini"

FROM mcr.microsoft.com/dotnet/sdk:7.0 as build
WORKDIR /src
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:7.0 as publish
COPY --from=phpcli . .
WORKDIR /publish
COPY --from=build /publish .
COPY php.ini /usr/local/etc/php/php.ini
EXPOSE 80
ENTRYPOINT ["dotnet", "Kanawanagasaki.Docker.AspNetCorePhpCgi.dll"]
