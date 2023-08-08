using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using As.Models;

namespace Assignment.Controllers
{
    public class LoginController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Index(string account, string password, string type)
        {
            using (prn_asContext context = new prn_asContext())
            {
                if (type.Equals("student"))
                {
                    Student s1 = context.Students.FirstOrDefault(s => s.Username.Equals(account) && s.Password.Equals(password));
                    if (s1 != null)
                    {
                        HttpContext.Session.SetInt32("UserId", s1.StudentId);
                        return Redirect("~/Schedule/Index");
                    }
                    else
                    {
                        ViewBag.message = "Đăng nhập không thành công";
                        return View();
                    }
                }
                else
                {
                    Admin a = context.Admins.FirstOrDefault(s => s.Username.Equals(account) && s.Password.Equals(password));
                    if (a != null)
                    {
                        return Redirect("~/Admin/Index");
                    }
                    else
                    {
                        ViewBag.message = "Đăng nhập không thành công";
                        return View();
                    }
                }

            }

        }
    }
}
