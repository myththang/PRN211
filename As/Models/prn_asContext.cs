using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace As.Models
{
    public partial class prn_asContext : DbContext
    {
        public prn_asContext()
        {
        }

        public prn_asContext(DbContextOptions<prn_asContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Admin> Admins { get; set; } = null!;
        public virtual DbSet<Class> Classes { get; set; } = null!;
        public virtual DbSet<ClassSubject> ClassSubjects { get; set; } = null!;
        public virtual DbSet<Pending> Pendings { get; set; } = null!;
        public virtual DbSet<Student> Students { get; set; } = null!;
        public virtual DbSet<StudentEnrollment> StudentEnrollments { get; set; } = null!;
        public virtual DbSet<Subject> Subjects { get; set; } = null!;
        public virtual DbSet<Timetable> Timetables { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("server=LIBUR\\SQLEXPRESS;database=prn_as;uid=sa;pwd=123;TrustServerCertificate=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Admin>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("Admin");

                entity.Property(e => e.AdminId)
                    .ValueGeneratedOnAdd()
                    .HasColumnName("AdminID");

                entity.Property(e => e.Name).HasMaxLength(50);

                entity.Property(e => e.Password).HasMaxLength(100);

                entity.Property(e => e.Username).HasMaxLength(50);
            });

            modelBuilder.Entity<Class>(entity =>
            {
                entity.Property(e => e.ClassId).HasColumnName("ClassID");

                entity.Property(e => e.ClassName).HasMaxLength(100);
            });

            modelBuilder.Entity<ClassSubject>(entity =>
            {
                entity.Property(e => e.ClassSubjectId).HasColumnName("ClassSubjectID");

                entity.Property(e => e.ClassId).HasColumnName("ClassID");

                entity.Property(e => e.SubjectId).HasColumnName("SubjectID");

                entity.HasOne(d => d.Class)
                    .WithMany(p => p.ClassSubjects)
                    .HasForeignKey(d => d.ClassId)
                    .HasConstraintName("FK__ClassSubj__Class__412EB0B6");

                entity.HasOne(d => d.Subject)
                    .WithMany(p => p.ClassSubjects)
                    .HasForeignKey(d => d.SubjectId)
                    .HasConstraintName("FK__ClassSubj__Subje__4222D4EF");
            });

            modelBuilder.Entity<Pending>(entity =>
            {
                entity.HasKey(e => e.MoveId)
                    .HasName("PK__Pending__A931A43CEAAC606D");

                entity.ToTable("Pending");

                entity.Property(e => e.MoveId).HasColumnName("MoveID");

                entity.Property(e => e.ClassSubjectId).HasColumnName("ClassSubjectID");

                entity.Property(e => e.StudentId).HasColumnName("StudentID");
            });

            modelBuilder.Entity<Student>(entity =>
            {
                entity.Property(e => e.StudentId).HasColumnName("StudentID");

                entity.Property(e => e.Password).HasMaxLength(100);

                entity.Property(e => e.StudentName).HasMaxLength(50);

                entity.Property(e => e.Username).HasMaxLength(50);
            });

            modelBuilder.Entity<StudentEnrollment>(entity =>
            {
                entity.HasKey(e => e.EnrollmentId)
                    .HasName("PK__StudentE__7F6877FB9F5FE827");

                entity.ToTable("StudentEnrollment");

                entity.Property(e => e.EnrollmentId).HasColumnName("EnrollmentID");

                entity.Property(e => e.ClassSubjectId).HasColumnName("ClassSubjectID");

                entity.Property(e => e.StudentId).HasColumnName("StudentID");

                entity.HasOne(d => d.ClassSubject)
                    .WithMany(p => p.StudentEnrollments)
                    .HasForeignKey(d => d.ClassSubjectId)
                    .HasConstraintName("FK__StudentEn__Class__4316F928");

                entity.HasOne(d => d.Student)
                    .WithMany(p => p.StudentEnrollments)
                    .HasForeignKey(d => d.StudentId)
                    .HasConstraintName("FK__StudentEn__Stude__440B1D61");
            });

            modelBuilder.Entity<Subject>(entity =>
            {
                entity.Property(e => e.SubjectId).HasColumnName("SubjectID");

                entity.Property(e => e.SubjectName).HasMaxLength(100);
            });

            modelBuilder.Entity<Timetable>(entity =>
            {
                entity.ToTable("Timetable");

                entity.Property(e => e.TimetableId).HasColumnName("TimetableID");

                entity.Property(e => e.ClassSubjectId).HasColumnName("ClassSubjectID");

                entity.Property(e => e.EndTime).HasColumnType("date");

                entity.Property(e => e.StartTime).HasColumnType("date");

                entity.HasOne(d => d.ClassSubject)
                    .WithMany(p => p.Timetables)
                    .HasForeignKey(d => d.ClassSubjectId)
                    .HasConstraintName("FK__Timetable__Class__44FF419A");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
