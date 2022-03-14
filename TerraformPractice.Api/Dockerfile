FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["TerraformPractice.Api/TerraformPractice.Api.csproj", "TerraformPractice.Api/"]
RUN dotnet restore "TerraformPractice.Api/TerraformPractice.Api.csproj"
COPY . .
WORKDIR "/src/TerraformPractice.Api"
RUN dotnet build "TerraformPractice.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TerraformPractice.Api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TerraformPractice.Api.dll"]
