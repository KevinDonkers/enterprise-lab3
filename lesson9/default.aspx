<%@ Page Title="Contoso - Home" Language="C#" MasterPageFile="~/monday.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="lesson9._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Welcome to Contoso University</h1>
    <div class="well">
        <p>This is a sample ASP.NET application built for COMP2007.  It will include
            CRUD operations using SQL Server and the Entity Framework, as well as 
            ASP.Identity and Exception Handling.
        </p>
    </div>
</asp:Content>
