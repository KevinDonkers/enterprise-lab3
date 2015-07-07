<%@ Page Title="" Language="C#" MasterPageFile="~/monday.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="lesson9.Courses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Courses</h1>
    <a href="course.aspx">Add Course</a>
    
    <div>
        <label for="ddlPageSize">Records Per Page:</label>
        <asp:DropDownList ID="ddlPageSize" runat="server" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" AutoPostBack="true">
            <asp:ListItem Value="3" Text="3" />
            <asp:ListItem Value="5" Text="5" />
            <asp:ListItem Value="10" Text="10" />
        </asp:DropDownList>
    </div>
    <asp:GridView ID="grdCourses" runat="server" CssClass="table table-striped"
        AutoGenerateColumns="false" OnRowDeleting="grdCourses_RowDeleting" 
        DataKeyNames="CourseID" AllowPaging="true" OnPageIndexChanging="grdCourses_PageIndexChanging" PageSize="3" 
        AllowSorting="true" OnSorting="grdCourses_Sorting" OnRowDataBound="grdCourses_RowDataBound">
        <Columns>
            <asp:BoundField DataField="CourseID" SortExpression="CourseID" HeaderText="Course ID" />
            <asp:BoundField DataField="Title" SortExpression="Title" HeaderText="Title" />
            <asp:BoundField DataField="Credits" SortExpression="Credits" HeaderText="Credits" />
            <asp:BoundField DataField="Name" SortExpression="Name" HeaderText="Department" />
            <asp:HyperLinkField HeaderText="Edit" NavigateUrl="~/student.aspx" Text="Edit"
                DataNavigateUrlFields="CourseID" DataNavigateUrlFormatString="course.aspx?CourseID={0}" />
            <asp:CommandField HeaderText="Delete" DeleteText="Delete" ShowDeleteButton="true" />
        </Columns>
    </asp:GridView>
</asp:Content>
