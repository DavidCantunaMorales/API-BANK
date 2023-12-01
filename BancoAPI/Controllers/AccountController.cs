using BancoAPI.Data.DTOs;
using BancoAPI.Models;
using BancoAPI.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json.Serialization;
using System.Text.Json;

namespace BancoAPI.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class AccountController : ControllerBase
    {
        private readonly AccountService _accountService;
        private readonly AccountTypeService _accountTypeService;
        private readonly ClientService _clientService;

        public AccountController(AccountService accountService, AccountTypeService accountTypeService, ClientService clientService)
        {
            this._accountService = accountService;
            this._accountTypeService = accountTypeService;
            this._clientService = clientService;
        }

        [HttpGet]
        public async Task<IEnumerable<AccountDtoOut>> Get()
        {
            return await _accountService.GetAll();
        }

        [HttpGet("getAccount/{id}")]
        public async Task<ActionResult<AccountDtoOut>> GetById(int id)
        {
            var account = await _accountService.GetDtoById(id);
            if (account is null) {
                return AccountNotFound(id);
            }

            return account;
        }

        [HttpPost("addAccount")]
        public async Task<IActionResult> Create(AccountDtoIn account)
        {
            string validationResult = await ValidationAccount(account);
            if (!validationResult.Equals("Valid"))
            {
                return BadRequest(new { message = validationResult });
            }

            var newAccount = await _accountService.Create(account);

            // Configura JsonSerializerOptions con ReferenceHandler.Preserve
            var jsonSerializerOptions = new JsonSerializerOptions {
                ReferenceHandler = ReferenceHandler.Preserve,
            };

            return CreatedAtAction(nameof(GetById), new { id = newAccount.Id }, newAccount);
        }

        [HttpPut("updateAccount/{id}")]
        public async Task<IActionResult> Update(int id, AccountDtoIn account)
        {
            if (id != account.Id) {
                return BadRequest(new { message = $"El ID({id}) de la URL no coinciden con el ID({account.Id}) de la cuenta no coinciden" });
            }

            var accountToUpdate = await _accountService.GetById(id);

            if (accountToUpdate is not null)
            {
                string validationResult = await ValidationAccount(account);
                if (!validationResult.Equals("Valid"))
                {
                    return BadRequest(new { message = validationResult });
                }
                await _accountService.Update(account);
                return NoContent();
            } else {
                return AccountNotFound(id);
            }
        }

        [HttpDelete("deleteAccount/{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var accountToDelete = await _accountService.GetById(id);

            if (accountToDelete is not null) {
                await _accountService.Delete(id);
                return Ok();
            } else {
                return AccountNotFound(id);
            }
        }


        private NotFoundObjectResult AccountNotFound(int id) {
            return NotFound(new { message = $"La cuenta con ID = {id} no existe." });
        }

        private async Task<string> ValidationAccount(AccountDtoIn account)
        {
            string result = "Valid";
            var accountType = await _accountTypeService.GetById(account.AccountType);
            
            if (accountType is null) {
                result = $"El tipo de cuenta {account.AccountType} no existe";
            }

            var clienteID = account.ClientId.GetValueOrDefault();
            var client = await _clientService.GetById(clienteID);
            
            if (client is null) {
                result = $"El cliente {clienteID} no existe.";
            }

            return result;
        }
    }
}
