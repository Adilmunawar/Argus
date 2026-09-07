// ZD Cloud Console API — skeleton (Phase 0). Same posture as the Mills API:
// refuses to boot without required config, prints an integration roll call,
// env vars always win, no secrets on disk.
using Microsoft.AspNetCore.Authentication.JwtBearer;

var builder = WebApplication.CreateBuilder(args);
builder.Configuration.AddEnvironmentVariables();

string Require(string key) =>
    builder.Configuration[key] ?? throw new InvalidOperationException($"{key} is required — refusing to boot.");

var adfsAuthority = Require("Auth:Authority");      // https://adfs.zd.local/adfs
var gitopsRepo    = Require("GitOps:RepoUrl");      // https://forgejo.zd.local/ZaraatDost/zd-cloud-gitops
var openBaoAddr   = Require("OpenBao:Address");     // https://openbao.zd.local:8200

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(o => { o.Authority = adfsAuthority; o.Audience = "zd-console"; });
builder.Services.AddAuthorizationBuilder()
    .AddPolicy("viewer",   p => p.RequireRole("ZD-Console-Viewers", "ZD-Console-Operators", "ZD-Console-Approvers", "ZD-Console-Security", "ZD-Console-Admins"))
    .AddPolicy("operator", p => p.RequireRole("ZD-Console-Operators", "ZD-Console-Admins"))
    .AddPolicy("approver", p => p.RequireRole("ZD-Console-Approvers", "ZD-Console-Admins"))
    .AddPolicy("security", p => p.RequireRole("ZD-Console-Security", "ZD-Console-Admins"))
    .AddPolicy("admin",    p => p.RequireRole("ZD-Console-Admins"));

builder.Services.AddProblemDetails();
builder.Services.AddOpenApi();

var app = builder.Build();
app.UseExceptionHandler();
app.UseAuthentication();
app.UseAuthorization();

var v1 = app.MapGroup("/api/v1");
v1.MapGet("/health", () => Results.Ok(new { status = "healthy", version = typeof(Program).Assembly.GetName().Version?.ToString() }));

// Feature slices register here: Overview, Apps, Deployments, Storage, Databases,
// Secrets, Identity, Hosts, Security, Ml, Runbooks, Audit. Every write creates a
// pull request on the GitOps repo and an audit row; none touches a system directly.
// v1.MapAppsEndpoints(); v1.MapDeploymentsEndpoints(); ...

app.Logger.LogInformation("ZD Cloud Console API booted ({Env})", app.Environment.EnvironmentName);
app.Logger.LogInformation("Integration AD FS: {A}", adfsAuthority);
app.Logger.LogInformation("Integration GitOps: {R}", gitopsRepo);
app.Logger.LogInformation("Integration OpenBao: {O}", openBaoAddr);
app.Run();
