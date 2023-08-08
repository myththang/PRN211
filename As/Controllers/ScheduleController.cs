using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using As.Models;
using System.Globalization;

namespace Assignment.Controllers
{
    public class ScheduleController : Controller
    {
        public IActionResult Index(int id)
        {


            return View();

        }
        public IActionResult TimeTable(string year, string week)
        {
            using (prn_asContext context = new prn_asContext())
            {
                int currentYear;
                if (year == null)
                {
                    currentYear = DateTime.Now.Year;
                }
                else
                {
                    currentYear = Int32.Parse(year);
                }
                ViewBag.Year = currentYear;
                DateTime currentDate = DateTime.Now;
                string currentweek = GetWeekString(currentDate);

                if (week != null)
                {
                    currentweek = week;
                }
                ViewBag.weeks = GetWeeksInYear(currentYear);
                string[] dateParts = currentweek.Split(new string[] { " To " }, StringSplitOptions.RemoveEmptyEntries);

                DateTime startDate = DateTime.ParseExact(dateParts[0].Trim(), "dd/MM", CultureInfo.InvariantCulture);
                DateTime endDate = DateTime.ParseExact(dateParts[1].Trim(), "dd/MM", CultureInfo.InvariantCulture);
                ViewBag.data = context.Timetables
                     .Include(t => t.ClassSubject)
                     .ThenInclude(cs => cs.Subject)
                     .Where(t => t.ClassSubject.StudentEnrollments.Any(se => se.StudentId == HttpContext.Session.GetInt32("UserId")) && t.StartTime <= startDate && t.EndTime >= endDate)
                     .ToList();
                ViewBag.currentWeek = currentweek;
                return View();
            }
        }

        private string GetWeekString(DateTime date)
        {
            while (date.DayOfWeek != DayOfWeek.Monday)
            {
                date = date.AddDays(-1);
            }

            DateTime endOfWeek = date.AddDays(6);

            return $"{date:dd/MM} To {endOfWeek:dd/MM}";
        }

        private List<string> GetWeeksInYear(int year)
        {
            List<string> weeks = new List<string>();

            DateTime startOfYear = new DateTime(year, 1, 1);
            DateTime endOfYear = new DateTime(year, 12, 31);

            DateTime currentWeekStart = startOfYear;
            while (currentWeekStart.DayOfWeek != DayOfWeek.Monday)
            {
                currentWeekStart = currentWeekStart.AddDays(1);
            }

            while (currentWeekStart <= endOfYear)
            {
                DateTime currentWeekEnd = currentWeekStart.AddDays(6);
                string weekString = $"{currentWeekStart:dd/MM} To {currentWeekEnd:dd/MM}";
                weeks.Add(weekString);

                currentWeekStart = currentWeekStart.AddDays(7);
            }

            return weeks;
        }

        public IActionResult Detail(int cid, int sid)
        {
            using (prn_asContext context = new prn_asContext())
            {
                ViewBag.detail = context.Timetables
                     .Include(t => t.ClassSubject)
                     .ThenInclude(cs => cs.Subject)
                     .Include(t => t.ClassSubject.Class)
                     .FirstOrDefault(t => t.ClassSubject.Class.ClassId == cid && t.ClassSubject.SubjectId == sid);


                return View();
            }

        }
        public IActionResult MoveClass()
        {
            using (prn_asContext context = new prn_asContext())
            {
                ViewBag.mess = TempData["ThongBao"] as string;
                ViewBag.course = context.StudentEnrollments
                    .Include(t => t.ClassSubject)
                    .ThenInclude(s => s.Subject)
                    .Include(t => t.ClassSubject.Class)
                    .Where(t => t.StudentId == HttpContext.Session.GetInt32("UserId")).ToList();
                return View();

            }

        }
        public IActionResult MoveOut(int sid, int cid, string save)
        {
            using (prn_asContext context = new prn_asContext())
            {
                if (save != null)
                {
                    bool check = true;
                    var otherclass = context.Timetables
                           .Include(t => t.ClassSubject)
                           .ThenInclude(cs => cs.Class)
                           .Where(t => t.ClassSubject.StudentEnrollments.Any(se => se.StudentId == HttpContext.Session.GetInt32("UserId")) && t.ClassSubject.SubjectId != sid).ToList();
                    var currentclass = context.Timetables
                                .Include(t => t.ClassSubject)
                                .ThenInclude(cs => cs.Class)
                                .Where(t => t.ClassSubject.SubjectId == sid && t.ClassSubject.Class.ClassId == cid).ToList();
                    int currentclassid = currentclass[0].ClassSubjectId;
                    foreach (Timetable oc in otherclass)
                    {
                        foreach (Timetable cc in currentclass)
                        {
                            if (cc.TimeSlot == oc.TimeSlot && cc.DayOfWeek == oc.DayOfWeek)
                            {
                                ViewBag.mess = "Không chọn được vì trùng slot học";
                                check = false; break;
                            }
                        }
                    }
                    if (check)
                    {
                        Pending p = new Pending() { StudentId = HttpContext.Session.GetInt32("UserId"), ClassSubjectId = currentclassid, Status = true };
                        var checkpending = context.Pendings.Where(p => p.StudentId == HttpContext.Session.GetInt32("UserId")).ToList();
                        var cs = context.ClassSubjects
                    .Include(cs => cs.Subject)
                    .Include(cs => cs.Class)
                    .ToList();
                        foreach (Pending cp in checkpending)
                        {
                            foreach(ClassSubject c in cs)
                            {
                                if (cp.ClassSubjectId == c.ClassSubjectId)
                                {
                                    if (c.SubjectId == sid)
                                    {
                                        ViewBag.mess = "Đã từng đổi lớp";
                                        check = false; break;  
                                    }
                                }
                            }
                        }
                        if (check)
                        {
                            var pending = context.Pendings.Add(p);


                            //var stuclass = context.StudentEnrollments.FirstOrDefault(se => se.StudentId == HttpContext.Session.GetInt32("UserId") && se.ClassSubject.SubjectId == sid);
                            //stuclass.ClassSubjectId = currentclassid;
                            context.SaveChanges();
                            TempData["ThongBao"] = "Thêm yêu cầu chuyển lớp thành công";
                            return RedirectToAction("MoveClass");
                        }
                        
                    }

                }

                Class CurrentClass = context.Classes
                    .FirstOrDefault(c => c.ClassSubjects.Any(cs => cs.StudentEnrollments.Any(se => se.StudentId == HttpContext.Session.GetInt32("UserId")) && cs.SubjectId == sid));
                ViewBag.sid = sid;
                ViewBag.c = context.Classes
                    .Include(c => c.ClassSubjects)
                    .ThenInclude(cs => cs.Subject)
                    .Where(c => c.ClassId != CurrentClass.ClassId)
                    .ToList();

                if (cid != 0)
                {
                    ViewBag.t = context.Timetables
                        .Include(t => t.ClassSubject)
                        .ThenInclude(cs => cs.Class)
                        .Where(t => t.ClassSubject.ClassId == cid && t.ClassSubject.SubjectId == sid).ToList();
                }
                else
                {
                    var firstclass = context.Classes
                    .Include(c => c.ClassSubjects)
                    .ThenInclude(cs => cs.Subject)
                    .FirstOrDefault(c => c.ClassId != CurrentClass.ClassId)
                    ;

                    ViewBag.t = context.Timetables
                            .Include(t => t.ClassSubject)
                            .ThenInclude(cs => cs.Class)
                            .Where(t => t.ClassSubject.ClassId == firstclass.ClassId && t.ClassSubject.SubjectId == sid).ToList();
                }
                ViewBag.selectcid = cid;
                return View();


            }

        }
    }

}
