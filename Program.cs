using Microsoft.EntityFrameworkCore;
using TicketSystem.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services
builder.Services.AddControllersWithViews();
builder.Services.AddSession();

// این خط حیاتی برای DbContext
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

// Use middleware
app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();
builder.Services.AddSession();

app.UseSession();

// Map routes
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();