using System;
using System.Collections.Generic;

namespace As.Models
{
    public partial class ClassSubject
    {
        public ClassSubject()
        {
            StudentEnrollments = new HashSet<StudentEnrollment>();
            Timetables = new HashSet<Timetable>();
        }

        public int ClassSubjectId { get; set; }
        public int? ClassId { get; set; }
        public int? SubjectId { get; set; }

        public virtual Class? Class { get; set; }
        public virtual Subject? Subject { get; set; }
        public virtual ICollection<StudentEnrollment> StudentEnrollments { get; set; }
        public virtual ICollection<Timetable> Timetables { get; set; }
    }
}
