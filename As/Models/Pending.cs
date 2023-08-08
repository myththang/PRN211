using System;
using System.Collections.Generic;

namespace As.Models
{
    public partial class Pending
    {
        public int MoveId { get; set; }
        public int? StudentId { get; set; }
        public int? ClassSubjectId { get; set; }
        public bool? Status { get; set; }
    }
}
