using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//reference models
using lesson9.Models;
using System.Web.ModelBinding;

namespace lesson9
{
    public partial class student : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //check for the id in url
            if (!IsPostBack)
            {
                if (Request.QueryString.Keys.Count > 0)
                {
                    //we have a parameter populate the form
                    GetStudents();
                }
            }
        }

        protected void GetStudents()
        {
            //connect
            using (DefaultConnection conn = new DefaultConnection())
            {
                //get the student id
                Int32 StudentID = Convert.ToInt32(Request.QueryString["StudentID"]);

                //get student info
                var s = (from stu in conn.Students
                         where stu.StudentID == StudentID
                         select stu).FirstOrDefault();

                if (s != null)
                {
                    //populate the form
                    txtFirstName.Text = s.FirstMidName;
                    txtLastName.Text = s.LastName;
                    txtEnrollDate.Text = s.EnrollmentDate.ToString("yyyy-MM-dd");
                }

                 var objE = (from en in conn.Enrollments
                            join c in conn.Courses on en.CourseID equals c.CourseID
                            join d in conn.Departments on c.DepartmentID equals d.DepartmentID
                            where en.StudentID == StudentID
                            select new {en.EnrollmentID, en.Grade, c.Title, d.Name});
               
                grdCourses.DataSource = objE.ToList();
                grdCourses.DataBind();

                ddlDepartment.ClearSelection();
                ddlCourse.ClearSelection();

                //fill departments dropdown
                var deps = (from dep in conn.Departments
                            orderby dep.Name
                            select dep);

                //populate the form
                ddlDepartment.DataSource = deps.ToList();
                ddlDepartment.DataBind();

                //add default options to the 2 dropdowns
                ListItem newItem = new ListItem("-Select-", "0");
                ddlDepartment.Items.Insert(0, newItem);
                ddlCourse.Items.Insert(0, newItem);

                //show the course panel
                pnlCourses.Visible = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //connect
            using (DefaultConnection conn = new DefaultConnection())
            {
                //instantiate a new student object in memory
                Student s = new Student();

                //decide if updating or adding, then save
                if (Request.QueryString.Count > 0)
                {
                    Int32 StudentID = Convert.ToInt32(Request.QueryString["StudentID"]);

                    s = (from stu in conn.Students
                         where stu.StudentID == StudentID
                         select stu).FirstOrDefault();
                }

                //fill the properties of our object from the form inputs
                s.FirstMidName = txtFirstName.Text;
                s.LastName = txtLastName.Text;
                s.EnrollmentDate = Convert.ToDateTime(txtEnrollDate.Text);

                if (Request.QueryString.Count == 0)
                {
                    conn.Students.Add(s);
                }
                conn.SaveChanges();

                //redirect to updated departments page
                Response.Redirect("students.aspx");
            }
        }

        protected void grdCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //get the selected enrollment id
            Int32 EnrollmentID = Convert.ToInt32(grdCourses.DataKeys[e.RowIndex].Values["EnrollmentID"]);

            using (DefaultConnection conn = new DefaultConnection())
            {

                Enrollment objE = (from en in conn.Enrollments
                                   where en.EnrollmentID == EnrollmentID
                                   select en).FirstOrDefault();

                conn.Enrollments.Remove(objE);
                conn.SaveChanges();

                GetStudents();

            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            
            using (DefaultConnection conn = new DefaultConnection())
            {

                Int32 StudentID = Convert.ToInt32(Request.QueryString["StudentID"]);
                Int32 CourseID = Convert.ToInt32(ddlCourse.SelectedValue);

                Enrollment objE = new Enrollment();

                objE.StudentID = StudentID;
                objE.CourseID = CourseID;

                conn.Enrollments.Add(objE);
                conn.SaveChanges();

                //refresh
                GetStudents();

            }
        }

        protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (DefaultConnection conn = new DefaultConnection())
            {
                //store selected department id
                Int32 DepartmentID = Convert.ToInt32(ddlDepartment.SelectedValue);

                var objC = from c in conn.Courses
                                where c.DepartmentID == DepartmentID
                                orderby Title
                                select c;
            
                //bind to the course dropdown
                ddlCourse.DataSource = objC.ToList();
                ddlCourse.DataBind();

                //add default options to the 2 dropdowns
                ListItem newItem = new ListItem("-Select-", "0");
                ddlCourse.Items.Insert(0, newItem);
            }
        }
    }
}