using System;
using System.Collections.Generic;

namespace As.Models
{
    public partial class Class
    {
        public Class()
        {
            ClassSubjects = new HashSet<ClassSubject>();
        }

        public int ClassId { get; set; }
        public string? ClassName { get; set; }

        public virtual ICollection<ClassSubject> ClassSubjects { get; set; }
    }
}
