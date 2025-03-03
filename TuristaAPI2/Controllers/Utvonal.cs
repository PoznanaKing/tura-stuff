using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TuristaAPI2.Models;

namespace TuristaAPI2.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class Utvonal : ControllerBase
    {
        private readonly TuristadbContext _context;

        public Utvonal(TuristadbContext context)
        {
            _context = context;
        }
        [HttpGet("All")]
        public async Task<ActionResult> GetAllUtvonals()
        {
            try
            {
                var utvonals = await _context.Utvonals.Include(x => x.Nehezseg).ToListAsync();
                if (utvonals != null)
                {
                    return Ok(utvonals);
                }
                return BadRequest();
            }
            catch (Exception e)
            {

                return StatusCode(400, "Hiba a beolvasás közben:" + e.Message);
            }
        }
        [HttpGet("ById")]
        public async Task<ActionResult> GetById(int id)
        {
            try
            {
                var utvonal = await _context.Utvonals.Include(x => x.Nehezseg).FirstOrDefaultAsync(x=> x.Id==id);
                if (utvonal != null)
                {
                    return Ok(utvonal);
                }
                return StatusCode(419, "“Valószínűleg nincs ilyen túra.”");
            }
            catch (Exception e)
            {

                return StatusCode(400, "Hiba a beolvasás közben:" + e.Message);
            }
        }
    }
}
