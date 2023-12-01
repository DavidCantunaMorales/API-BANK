using BancoAPI.Data;
using BancoAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace BancoAPI.Services
{
    public class ClientService
    {
        private readonly BankContext _context;

        public ClientService(BankContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Client>> GetAll()
        {
            return await _context.Clients.ToListAsync();
        }

        public async Task<Client> GetById(int id)
        {
            return await _context.Clients.FindAsync(id);
        }

        public async Task<Client> Create(Client newClient)
        {
            _context.Clients.Add(newClient);
            await _context.SaveChangesAsync();
            return newClient;
        }

        public async Task Update(int id, Client client)
        {
            var existClient = await GetById(id);
            
            if (existClient != null)
            {
                existClient.Name = client.Name;
                existClient.PhoneNumber = client.PhoneNumber;
                existClient.Email = client.Email;

                await _context.SaveChangesAsync();
            }
        }

        public async Task Delete(int id)
        {
            var clientToDelete = await GetById(id);  

            if (clientToDelete != null) {
                _context.Clients.Remove(clientToDelete);
                await _context.SaveChangesAsync();
            }
        }
    }
}
