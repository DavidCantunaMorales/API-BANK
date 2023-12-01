using BancoAPI.Data;
using BancoAPI.Services;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using BancoAPI.Models;
using Microsoft.AspNetCore.Authorization;

namespace BancoAPI.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class ClientController : ControllerBase
    {
        private readonly ClientService _service;
        public ClientController(ClientService service)
        {
            _service = service;
        }

        // Obtener todos los clientes
        [HttpGet]
        public async Task<IEnumerable<Client>> Get()
        {
            return await _service.GetAll();
        }

        // Obtener un cliente en especifico
        [HttpGet("getClient/{id}")]
        public async Task<ActionResult<Client>> GetById(int id)
        {
            var client = await _service.GetById(id);
            if (client is null)
            {
                return AccountNotFound(id);
            }
            return client;
        }

        // Crear un nuevo cliente
        [HttpPost("addClient")]
        public async Task<IActionResult> Create(Client client)
        {
            var newCliente = await _service.Create(client);

            return CreatedAtAction(nameof(GetById), new { id = client.Id }, client);
        }



        // Actualizar cliente
        [HttpPut("updateClient/{id}")]
        public async Task<IActionResult> Update(int id, Client client)
        {
            if ( id != client.Id ) {
                return BadRequest(new { message = $"El ID({ id }) de la URL no coincide con el ID({ client.Id }) del cuerpo de la solicitud" });
            }

            var clientUpdate = await _service.GetById(id);

            if (clientUpdate is not null) {
                await _service.Update(id, client);
                return NoContent();
            } else {
                return AccountNotFound(id);
            }
        }

        // Borrar clientes
        [HttpDelete("deleteClient/{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var clientUpdate = await _service.GetById(id);

            if (clientUpdate is not null) {
                await _service.Delete(id);
                return Ok();
            } else{
                return AccountNotFound(id);
            }
        }

        private NotFoundObjectResult AccountNotFound(int id) {
            return NotFound(new { message = $"La cuenta con ID = {id} no existe." });
        }
    }
}
