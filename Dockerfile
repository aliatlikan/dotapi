FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build

USER root

WORKDIR /app

COPY *.csproj .

RUN dotnet restore

COPY . ./

RUN dotnet publish --no-restore -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "dotapi.dll"]
