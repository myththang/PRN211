using System;
using System.Collections.Generic;

namespace As.Models
{
    public partial class StudentEnrollment
    {
        public int EnrollmentId { get; set; }
        public int? StudentId { get; set; }
        public int? ClassSubjectId { get; set; }

        public virtual ClassSubject? ClassSubject { get; set; }
        public virtual Student? Student { get; set; }
    }
}
