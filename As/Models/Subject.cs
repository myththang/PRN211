using System;
using System.Collections.Generic;

namespace As.Models
{
    public partial class Subject
    {
        public Subject()
        {
            ClassSubjects = new HashSet<ClassSubject>();
        }

        public int SubjectId { get; set; }
        public string? SubjectName { get; set; }

        public virtual ICollection<ClassSubject> ClassSubjects { get; set; }
    }
}
