using As.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Assignment.Controllers
{
    public class AdminController : Controller
    {
        public IActionResult Index()
        {
            using (prn_asContext context = new prn_asContext())
            {
                ViewBag.pending = context.Pendings
                    .Where(p => p.Status == true).ToList();
                ViewBag.Student = context.Students.ToList();
                ViewBag.cs = context.ClassSubjects
                    .Include(cs => cs.Subject)
                    .Include(cs => cs.Class)
                    .ToList();
                return View();
            }

        }
        public IActionResult Accept(int id)
        {
            using (prn_asContext context = new prn_asContext())
            {
                var pending = context.Pendings.FirstOrDefault(p => p.MoveId == id);
                var sid = context.ClassSubjects.FirstOrDefault(cs => cs.ClassSubjectId == pending.ClassSubjectId).SubjectId;
                var stuclass = context.StudentEnrollments.FirstOrDefault(se => se.StudentId == pending.StudentId && se.ClassSubject.SubjectId == sid);
                stuclass.ClassSubjectId = pending.ClassSubjectId;
                pending.Status = false;
                context.SaveChanges();
                return RedirectToAction("Index");
            }
        }
        public IActionResult Decline(int id)
        {
            using (prn_asContext context = new prn_asContext())
            {
                var pending = context.Pendings.FirstOrDefault(p => p.MoveId == id);
                pending.Status = false;
                context.SaveChanges();
                return RedirectToAction("Index");
            }
        }
    }
}
