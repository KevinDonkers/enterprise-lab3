using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//reference our entity framework models
using lesson9.Models;
using System.Web.ModelBinding;

using System.Linq.Dynamic;

namespace lesson9
{
    public partial class Courses : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            //fill the grid
            if (!IsPostBack)
            {
                Session["SortDirection"] = "ASC";
                Session["SortColumn"] = "CourseID";
                GetCourses();
            }
        }

        protected void GetCourses()
        {
            //connect using our connection string from web.config and EF context class
            using (DefaultConnection conn = new DefaultConnection())
            {

                //use link to query the Departments model
                var courses = (from c in conn.Courses
                               select new { c.CourseID, c.Title, c.Credits, c.Department.Name });

                //append the current direction to the sort column
                String sort = Session["SortColumn"].ToString() + " " + Session["SortDirection"].ToString();
                grdCourses.DataSource = courses.AsQueryable().OrderBy(sort).ToList();
                grdCourses.DataBind();
            }
        }

        protected void grdCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //connect
            using (DefaultConnection conn = new DefaultConnection())
            {
                //get the selected department id
                Int32 CourseID = Convert.ToInt32(grdCourses.DataKeys[e.RowIndex].Values["CourseID"]);

                var c = (from crs in conn.Courses
                         where crs.CourseID == CourseID
                         select crs).FirstOrDefault();

                //delete
                conn.Courses.Remove(c);
                conn.SaveChanges();

                //update the grid
                GetCourses();

            }
        }

        protected void grdCourses_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //set the page index and refresh the grid
            grdCourses.PageIndex = e.NewPageIndex;
            GetCourses();
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            //set the page size and refresh
            grdCourses.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            GetCourses();
        }

        protected void grdCourses_Sorting(object sender, GridViewSortEventArgs e)
        {
            //set the global sort cloumn to the column clicked on by the user
            Session["SortColumn"] = e.SortExpression;
            GetCourses();

            //toggle the direction
            if (Session["SortDirection"] == "ASC")
            {
                Session["SortDirection"] = "DESC";
            }
            else
            {
                Session["SortDirection"] = "ASC";
            }
        }

        protected void grdCourses_RowDataBound(object sender, GridViewRowEventArgs e)
        {
             if (IsPostBack) { 
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    Image SortImage = new Image();
                
                    for (int i = 0; i < grdCourses.Columns.Count; i++) {
                        if (grdCourses.Columns[i].SortExpression == Session["SortColumn"].ToString())
                        {
                            if (Session["SortDirection"].ToString() == "DESC")
                            {
                                SortImage.ImageUrl = "images/desc.jpg";
                                SortImage.AlternateText = "Sort Decending";
                            }
                            else
                            {
                                SortImage.ImageUrl = "images/asc.jpg";
                                SortImage.AlternateText = "Sort Ascending";
                            }
                        
                            e.Row.Cells[i].Controls.Add(SortImage);
                            
                        }
                    }
                }
               
            }
        }

    }
}