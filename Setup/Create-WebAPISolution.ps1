param
(
    [Parameter(Mandatory)] [string]$CompanyName,
    [Parameter(Mandatory)] [string]$SolutionName,
    [Parameter(Mandatory)] [string]$ProjectName
)

Set-Location ../..
dotnet new sln -o $SolutionName
Set-Location $SolutionName
New-Item -ItemType Directory -Path . -Name src
New-Item -ItemType Directory -Path . -Name tests

Set-Location src
dotnet new webapi -n (-join($ProjectName, '.WebAPI'))
dotnet new classlib -n (-join($ProjectName, '.Application'))
dotnet new classlib -n (-join($ProjectName, '.Core'))
dotnet new classlib -n (-join($ProjectName, '.Infrastructure'))

Set-Location ..\tests
dotnet new xunit -n (-join($ProjectName, '.WebAPI.UnitTests'))
dotnet new xunit -n (-join($ProjectName, '.Application.UnitTests'))
dotnet new xunit -n (-join($ProjectName, '.Core.UnitTests'))
dotnet new xunit -n (-join($ProjectName, '.Infrastructure.UnitTests'))
dotnet new xunit -n (-join($ProjectName, '.IntegrationTests'))

Set-Location ..
dotnet sln add (-join('src/', $ProjectName, '.WebAPI'))
dotnet sln add (-join('src/', $ProjectName, '.Application'))
dotnet sln add (-join('src/', $ProjectName, '.Core'))
dotnet sln add (-join('src/', $ProjectName, '.Infrastructure'))

dotnet sln add (-join('tests/', $ProjectName, '.WebAPI.UnitTests'))
dotnet sln add (-join('tests/', $ProjectName, '.Application.UnitTests'))
dotnet sln add (-join('tests/', $ProjectName, '.Core.UnitTests'))
dotnet sln add (-join('tests/', $ProjectName, '.IntegrationTests'))

Remove-Item (-join('src/', $ProjectName, '.Application/*.cs'))
Remove-Item (-join('src/', $ProjectName, '.Core/*.cs'))
Remove-Item (-join('src/', $ProjectName, '.Infrastructure/*.cs'))

Remove-Item (-join('tests/', $ProjectName, '.WebAPI.UnitTests/*.cs'))
Remove-Item (-join('tests/', $ProjectName, '.Application.UnitTests/*.cs'))
Remove-Item (-join('tests/', $ProjectName, '.Core.UnitTests/*.cs'))
Remove-Item (-join('tests/', $ProjectName, '.Infrastructure.UnitTests/*.cs'))
Remove-Item (-join('tests/', $ProjectName, '.IntegrationTests/*.cs'))

dotnet add (-join('src/', $ProjectName, '.WebAPI/', $ProjectName, '.WebAPI.csproj')) reference (-join('src/', $ProjectName, '.Application/', $ProjectName, '.Application.csproj'))
dotnet add (-join('src/', $ProjectName, '.WebAPI/', $ProjectName, '.WebAPI.csproj')) reference (-join('src/', $ProjectName, '.Core/', $ProjectName, '.Core.csproj'))
dotnet add (-join('src/', $ProjectName, '.WebAPI/', $ProjectName, '.WebAPI.csproj')) reference (-join('src/', $ProjectName, '.Infrastructure/', $ProjectName, '.Infrastructure.csproj'))

dotnet add (-join('src/', $ProjectName, '.Infrastructure/', $ProjectName, '.Infrastructure.csproj')) reference (-join('src/', $ProjectName, '.Application/', $ProjectName, '.Application.csproj'))
dotnet add (-join('src/', $ProjectName, '.Infrastructure/', $ProjectName, '.Infrastructure.csproj')) reference (-join('src/', $ProjectName, '.Core/', $ProjectName, '.Core.csproj'))

dotnet add (-join('src/', $ProjectName, '.Application/', $ProjectName, '.Application.csproj')) reference (-join('src/', $ProjectName, '.Core/', $ProjectName, '.Core.csproj'))

dotnet add (-join('tests/', $ProjectName, '.WebAPI.UnitTests/', $ProjectName, '.WebAPI.UnitTests.csproj')) reference (-join('src/', $ProjectName, '.WebAPI/', $ProjectName, '.WebAPI.csproj'))

dotnet add (-join('tests/', $ProjectName, '.Application.UnitTests/', $ProjectName, '.Application.UnitTests.csproj')) reference (-join('src/', $ProjectName, '.Application/', $ProjectName, '.Application.csproj'))

dotnet add (-join('tests/', $ProjectName, '.Core.UnitTests/', $ProjectName, '.Core.UnitTests.csproj')) reference (-join('src/', $ProjectName, '.Core/', $ProjectName, '.Core.csproj'))

dotnet add (-join('tests/', $ProjectName, '.Infrastructure.UnitTests/', $ProjectName, '.Infrastructure.UnitTests.csproj')) reference (-join('src/', $ProjectName, '.Infrastructure/', $ProjectName, '.Infrastructure.csproj'))

dotnet add (-join('tests/', $ProjectName, '.IntegrationTests/', $ProjectName, '.IntegrationTests.csproj')) reference (-join('src/', $ProjectName, '.WebAPI/', $ProjectName, '.WebAPI.csproj'))
dotnet add (-join('tests/', $ProjectName, '.IntegrationTests/', $ProjectName, '.IntegrationTests.csproj')) reference (-join('src/', $ProjectName, '.Application/', $ProjectName, '.Application.csproj'))
dotnet add (-join('tests/', $ProjectName, '.IntegrationTests/', $ProjectName, '.IntegrationTests.csproj')) reference (-join('src/', $ProjectName, '.Core/', $ProjectName, '.Core.csproj'))
dotnet add (-join('tests/', $ProjectName, '.IntegrationTests/', $ProjectName, '.IntegrationTests.csproj')) reference (-join('src/', $ProjectName, '.Infrastructure/', $ProjectName, '.Infrastructure.csproj'))

Set-Location (-join('src/', $ProjectName, '.WebAPI'))
dotnet add package Swashbuckle.AspNetCore

Set-Location (-join('../', $ProjectName, '.Infrastructure'))
dotnet add package Microsoft.EntityFrameworkCore.SqlServer

Set-Location (-join('../', $ProjectName, '.Application'))
dotnet add package FluentValidation
dotnet add package FluentValidation.DependencyInjectionExtensions

Set-Location ../../..