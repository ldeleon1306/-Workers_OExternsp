#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

#FROM mcr.microsoft.com/dotnet/runtime:3.1 AS base
#WORKDIR /app
#
#FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
#WORKDIR /src
#COPY ["WorkerS_OExtern.csproj", "."]
#RUN dotnet restore "./WorkerS_OExtern.csproj"
#COPY . .
#WORKDIR "/src/."
#RUN dotnet build "WorkerS_OExtern.csproj" -c Release -o /app/build
#
#FROM build AS publish
#RUN dotnet publish "WorkerS_OExtern.csproj" -c Release -o /app/publish
#
#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "WorkerS_OExtern.dll"]
 FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
 WORKDIR /app
 EXPOSE 80
 FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
 WORKDIR /src
 COPY ["Workers.csproj", ""]
 RUN dotnet restore "./Workers.csproj"
 COPY . .
 WORKDIR "/src/."
 RUN dotnet build "Workers.csproj" -c Release -o /app/build
 FROM build AS publish
 RUN dotnet publish "Workers.csproj" -c Release -o /app/publish
 FROM base AS final
 WORKDIR /app
 COPY --from=publish /app/publish .
 ENTRYPOINT ["dotnet", "Workers.dll"]