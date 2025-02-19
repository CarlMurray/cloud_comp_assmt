FROM mcr.microsoft.com/dotnet/sdk:8.0 as build
WORKDIR /source
# COPY . .
RUN git clone https://github.com/carlmurray/cloud_comp_assmt
WORKDIR /source/cloud_comp_assmt/server
RUN mkdir /source/app
RUN dotnet build -c release -o /source/app server.csproj

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /source/app /app
CMD [ "dotnet", "server.dll"]
