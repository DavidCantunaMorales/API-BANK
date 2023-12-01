using BancoAPI.Data;
using BancoAPI.Models;

namespace BancoAPI.Services
{
    public class AccountTypeService
    {
        private readonly BankContext _context;

        public AccountTypeService(BankContext context)
        {
            _context = context;
        }

        public async Task<AccountType> GetById(int id)
        {
            return await _context.AccountTypes.FindAsync(id);
        }
    }
}
