using BancoAPI.Data;
using BancoAPI.Data.DTOs;
using BancoAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace BancoAPI.Services
{
    public class LoginService
    {
        private readonly BankContext _context;
        public LoginService(BankContext context) 
        {
            _context = context;
        }

        public async Task<Administrator> GetAdmin(AdminDto admin)
        {
            return await _context.Administrators.
                   SingleOrDefaultAsync(x => x.Email == admin.Email && x.Pwd == admin.Pwd);
        }
    }
}
