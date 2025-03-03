using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using TuristaAPI2.Models;

namespace TuristaAPI2.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class Nehézség : ControllerBase
    {
        private readonly TuristadbContext _context;

        public Nehézség(TuristadbContext context)
        {
            _context = context;
        }
        [HttpPost("Uj")]
        public async Task<ActionResult> uploadNehezseg(UploadNewNehezsegDTO uploadNewNehezsegDTO)
        {
            try
            {
                var ujnehezseg = new Nehezseg
                {
                    Id = uploadNewNehezsegDTO.id,
                    Jelzes = uploadNewNehezsegDTO.jelzes,
                    Leiras = uploadNewNehezsegDTO.leiras,
                };
                if (ujnehezseg != null)
                {
                    await _context.Nehezsegs.AddAsync(ujnehezseg);
                    await _context.SaveChangesAsync();
                    return StatusCode(200, "Sikeres mentés.");
                }
                return StatusCode(406, "X");
            }
            catch (Exception e)
            {

                return StatusCode(400, "Hiba a rögzítés közben: " + e.Message);
            }
        }
        [HttpDelete]
        public async Task<ActionResult> DeleteNehezseg(int id)
        {
            var deletingNehezseg = await _context.Nehezsegs.FirstOrDefaultAsync(x=>x.Id==id);
            if (deletingNehezseg!=null)
            {
                _context.Nehezsegs.Remove(deletingNehezseg);
                await _context.SaveChangesAsync();
                return Ok("Sikeres törlés");
            }
            return StatusCode(404, "Nem létező nehézségi fok.");
        }
    }
}
