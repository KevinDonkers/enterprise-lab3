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
    public partial class department : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //check for the id in url
            if (!IsPostBack)
            {
                if (Request.QueryString.Keys.Count > 0)
                {
                    //we have a parameter populate the form
                    GetDepartment();
                }
            }

        }

        protected void GetDepartment()
        {
            //connect
            using (DefaultConnection conn = new DefaultConnection())
            {
                //get the department id
                Int32 DepartmentID = Convert.ToInt32(Request.QueryString["DepartmentID"]);

                //get department info
                var d = (from dep in conn.Departments
                         where dep.DepartmentID == DepartmentID
                         select dep).FirstOrDefault();

                //populate the form
                txtName.Text = d.Name;
                txtBudget.Text = d.Budget.ToString();

                var objC = (from c in conn.Courses
                            where c.DepartmentID == DepartmentID
                            select new {c.Title, c.DepartmentID, c.CourseID, c.Credits});

                grdDepCourses.DataSource = objC.ToList();
                grdDepCourses.DataBind();

                //show the course panel
                pnlCourses.Visible = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //connect
            using (DefaultConnection conn = new DefaultConnection())
            {
                //instantiate a new deparment object in memory
                Department d = new Department();

                //decide if updating or adding, then save
                if (Request.QueryString.Count > 0)
                {
                    Int32 DepartmentID = Convert.ToInt32(Request.QueryString["DepartmentID"]);

                    d = (from dep in conn.Departments
                         where dep.DepartmentID == DepartmentID
                         select dep).FirstOrDefault();
                }

                //fill the properties of our object from the form inputs
                d.Name = txtName.Text;
                d.Budget = Convert.ToDecimal(txtBudget.Text);

                if (Request.QueryString.Count == 0)
                {
                    conn.Departments.Add(d);
                }
                conn.SaveChanges();

                //redirect to updated departments page
                Response.Redirect("departments.aspx");
            }
        }

        protected void grdDepCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //get the selected Course id
            Int32 CourseID = Convert.ToInt32(grdDepCourses.DataKeys[e.RowIndex].Values["CourseID"]);

            using (DefaultConnection conn = new DefaultConnection())
            {

                Course objC = (from c in conn.Courses
                                   where c.CourseID == CourseID
                                   select c).FirstOrDefault();

                conn.Courses.Remove(objC);
                conn.SaveChanges();

                GetDepartment();

            }
        }
    }
}