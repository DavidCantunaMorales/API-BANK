using BancoAPI.Data.DTOs;
using BancoAPI.Models;
using BancoAPI.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace BancoAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class LoginController : ControllerBase
    {
        private readonly LoginService _loginService;

        private IConfiguration _configuration;

        public LoginController(LoginService loginService, IConfiguration configuration)
        {
            this._loginService = loginService;
            this._configuration = configuration;
        }

        [HttpPost]
        public async Task<IActionResult> Login(AdminDto adminDto)
        {
            var admin = await _loginService.GetAdmin(adminDto);

            if (admin is null) {
                return BadRequest(new { message = "Credenciales Invalidas." });
            }

            // Generar el token

            string jwtToken = GenerateToken(admin);

            return Ok(new { token = jwtToken });
        }

        private string GenerateToken(Administrator admin)
        {
            var claims = new[]
            {
                new Claim(ClaimTypes.Name, admin.Name),
                new Claim(ClaimTypes.Email, admin.Email)
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration.GetSection("JWT:Key").Value));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256Signature);

            var securityToken = new JwtSecurityToken(
                                    claims: claims,
                                    expires: DateTime.Now.AddMinutes(60),
                                    signingCredentials: creds);

            string token = new JwtSecurityTokenHandler().WriteToken(securityToken);
            
            return token;
        }
    }
}
