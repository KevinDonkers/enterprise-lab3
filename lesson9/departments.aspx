<%@ Page Title="Contoso University - Departments" Language="C#" MasterPageFile="~/monday.Master" AutoEventWireup="true" CodeBehind="departments.aspx.cs" Inherits="lesson9.departments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Departments</h1>
    <a href="department.aspx">Add Department</a>

    <div>
        <label for="ddlPageSize">Records Per Page:</label>
        <asp:DropDownList ID="ddlPageSize" runat="server" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" AutoPostBack="true">
            <asp:ListItem Value="3" Text="3" />
            <asp:ListItem Value="5" Text="5" />
            <asp:ListItem Value="10" Text="10" />
        </asp:DropDownList>
    </div>
    <asp:GridView ID="grdDepartments" runat="server" CssClass="table table-striped"
        AutoGenerateColumns="false" DataKeyNames="DepartmentID"
        OnPageIndexChanging="grdDepartments_PageIndexChanging" PageSize="3"
        AllowSorting="true" AllowPaging="true" OnSorting="grdDepartments_Sorting" 
        OnRowDataBound="grdDepartments_RowDataBound"
        OnRowDeleting="grdDepartments_RowDeleting" >
        <Columns>
            <asp:BoundField DataField="Name" SortExpression="Name" HeaderText="Department Name" />
            <asp:BoundField DataField="Budget" SortExpression="Budget" HeaderText="Budget" DataFormatString="{0:c}" />
            <asp:HyperLinkField HeaderText="Edit" NavigateUrl="~/department.aspx" Text="Edit"
                DataNavigateUrlFields="DepartmentID" DataNavigateUrlFormatString="department.aspx?DepartmentID={0}" />
            <asp:CommandField HeaderText="Delete" DeleteText="Delete" ShowDeleteButton="true" />
        </Columns>
    </asp:GridView>
</asp:Content>
