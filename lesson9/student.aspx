<%@ Page Title="" Language="C#" MasterPageFile="~/monday.Master" AutoEventWireup="true" CodeBehind="student.aspx.cs" Inherits="lesson9.student" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Student Details</h1>

    <div class="form-group">
        <label for="txtFirstName" class="col-sm-3">First Name:</label>
        <asp:TextBox ID="txtFirstName" runat="server" required="true" MaxLength="50" />
    </div>
    <div class="form-group">
        <label for="txtLastName" class="col-sm-3">Last Name:</label>
        <asp:TextBox ID="txtLastName" runat="server" required="true" MaxLength="50" />
    </div>
    <div class="form-group">
        <label for="txtEnrollDate" class="col-sm-3">Enrollment Date(yyyy-mm-dd):</label>
        <asp:TextBox ID="txtEnrollDate" runat="server" required="true" 
            MaxLength="50"/>
        <asp:CompareValidator
            ID="dateValidator" runat="server" 
            Type="Date"
            Operator="DataTypeCheck"
            ControlToValidate="txtEnrollDate" 
            ErrorMessage="Please enter a valid date.">
        </asp:CompareValidator>
    </div>
    <div class="col-sm-offset-3">
        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" 
        OnClick="btnSave_Click"/>
    </div>

    <asp:Panel ID="pnlCourses" runat="server" Visible="false">
    <h2>Courses</h2>
        <asp:GridView ID="grdCourses" runat="server" CssClass="table table-striped table-hover"
            AutoGenerateColumns="false" DataKeyNames="EnrollmentID"
            OnRowDeleting="grdCourses_RowDeleting">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Department" />
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="Grade" HeaderText="Grade" />
                <asp:CommandField HeaderText="Delete" DeleteText="Delete" ShowDeleteButton="true" />
            </Columns>
        </asp:GridView>

        <table class="table table-striped table-hover">
            <thead>
                <th>Department</th>
                <th>Title</th>
                <th>Add</th>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlDepartment" runat="server" DataValueField="DepartmentID" DataTextField="Name" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged"></asp:DropDownList>
                        <asp:RangeValidator runat="server" ControlToValidate="ddlDepartment" Type="Integer" 
                            MinimumValue="1" MaximumValue="9999999" ErrorMessage="Required" CssClass="label label-danger"></asp:RangeValidator>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlCourse" runat="server" DataValueField="CourseID" DataTextField="Title"></asp:DropDownList>
                        <asp:RangeValidator runat="server" ControlToValidate="ddlCourse" Type="Integer" 
                            MinimumValue="1" MaximumValue="9999999" ErrorMessage="Required" CssClass="label label-danger"></asp:RangeValidator>
                    </td>
                    <td>
                        <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
                    </td>
                </tr>
            </tbody>
        </table>
    </asp:Panel>
</asp:Content>
