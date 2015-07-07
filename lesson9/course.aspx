<%@ Page Title="" Language="C#" MasterPageFile="~/monday.Master" AutoEventWireup="true" CodeBehind="course.aspx.cs" Inherits="lesson9.course" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Course Details</h1>

    <div class="form-group">
        <label for="txtTitle" class="col-sm-3">Title:</label>
        <asp:TextBox ID="txtTitle" runat="server" required="true" MaxLength="50" />
    </div>
    <div class="form-group">
        <label for="txtCredits" class="col-sm-3">Credits:</label>
        <asp:TextBox ID="txtCredits" runat="server" required="true" MaxLength="50" TextMode="number" />
    </div>
    <div class="form-group">
        <label for="txtDepartment" class="col-sm-3">Department</label>
        <asp:DropDownList ID="ddlDepartment" runat="server" required="true" DataTextField="Name" DataValueField="DepartmentID" />
    </div>
    <div class="col-sm-offset-3">
        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" 
        OnClick="btnSave_Click"/>
    </div>

    <asp:Panel ID="pnlStudents" runat="server" Visible="false">
        <h2>Students</h2>
        <asp:GridView ID="grdStudents" runat="server" CssClass="table table-striped table-hover"
            AutoGenerateColumns="false" DataKeyNames="EnrollmentID"
            OnRowDeleting="grdStudents_RowDeleting" >
            <Columns>
                <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                <asp:BoundField DataField="FirstMidName" HeaderText="First Name" />
                <asp:BoundField DataField="EnrollmentDate" HeaderText="Enrollment Date" />
                <asp:CommandField HeaderText="Delete" DeleteText="Delete" ShowDeleteButton="true" />
            </Columns>
        </asp:GridView>

        <div class="form-group">
            <label for="ddlStudent" class="col-sm-3">Title:</label>
            <asp:DropDownList ID="ddlStudent" runat="server" DataValueField="StudentID"></asp:DropDownList>
            <asp:RangeValidator runat="server" ControlToValidate="ddlStudent" Type="Integer" 
                                MinimumValue="1" MaximumValue="9999999" ErrorMessage="Required" CssClass="label label-danger"></asp:RangeValidator>
            <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="btnAdd_Click" />        
        </div>
    </asp:Panel>
</asp:Content>
