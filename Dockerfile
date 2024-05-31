# Etapa 1: Build da aplicação
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia o arquivo .csproj e restaura as dependências
COPY hello-world.csproj .
RUN dotnet restore

# Copia o restante dos arquivos e compila o projeto
COPY . .
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: Configuração do ambiente runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copia os arquivos publicados para o diretório de serviço
COPY --from=build /app/publish .

# Exposição da porta que a API irá escutar
EXPOSE 80

# Comando para rodar a aplicação
ENTRYPOINT ["dotnet", "hello-world.dll"]