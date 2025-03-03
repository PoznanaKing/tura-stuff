using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using TuristaAPI2.Models;

namespace TuristaAPI2.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TuraController : ControllerBase
    {
        private readonly TuristadbContext _context;

        public TuraController(TuristadbContext context)
        {
            _context = context;
        }
        [HttpPut("Modosit")]
        public async Task<ActionResult> Modosit()
        {

        }
    }
}
