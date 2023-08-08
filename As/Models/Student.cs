using System;
using System.Collections.Generic;

namespace As.Models
{
    public partial class Student
    {
        public Student()
        {
            StudentEnrollments = new HashSet<StudentEnrollment>();
        }

        public int StudentId { get; set; }
        public string? StudentName { get; set; }
        public string? Username { get; set; }
        public string? Password { get; set; }

        public virtual ICollection<StudentEnrollment> StudentEnrollments { get; set; }
    }
}
