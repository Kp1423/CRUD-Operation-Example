<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUpdateOrder.aspx.cs" Inherits="DevItPractical.AddUpdateOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
   
    <form id="form1" runat="server">
         <div class="jumbotron text-center">
                <h1>Add/Update Order</h1>
                <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-info" OnClick="btnBack_Click" />
            </div>

        <div>
             <asp:Table CssClass="table table-hover center-block" runat="server" Width="60%"  >
                 <asp:TableRow>
                     <asp:TableCell Width="20%">Customer Name :</asp:TableCell>
                     <asp:TableCell>
                         <asp:TextBox ID="txtCustName" runat="server" Width="80%" />
                      </asp:TableCell></asp:TableRow><asp:TableRow>
                     <asp:TableCell>Order Date :</asp:TableCell><asp:TableCell>
                         <asp:TextBox ID="txtOrderDate" runat="server" Width="30%" Text="dd/MM/yyyy"/>
                         <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtOrderDate" runat="server"
                          ErrorMessage="Date should be in dd/MM/yyyy format" ForeColor="Red" 
                             ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"  ></asp:RegularExpressionValidator>
                         <%--<asp:Label ID="valDate"  Text="  Date should be in dd/MM/yyyy format" 
                             Font-Bold="true" ForeColor="Red" runat="server" />--%>
                     </asp:TableCell></asp:TableRow><asp:TableRow>
                     <asp:TableCell>Item :</asp:TableCell><asp:TableCell>
                         <asp:ListBox ID="txtItems" DataTextField="--Select Item--" runat="server" Width="30%" /></asp:TableCell>
                 </asp:TableRow>
                 <asp:TableRow>
                     <asp:TableCell>Quantity :</asp:TableCell>
                     <asp:TableCell>
                         <asp:TextBox ID="txtQuantity" runat="server" Width="30%"/>
                         <asp:RegularExpressionValidator ID="RegexValidator" ControlToValidate="txtQuantity" runat="server"
                          ErrorMessage="Only Numbers Allowed" ForeColor="Red" ValidationExpression="\d+"  ></asp:RegularExpressionValidator>
                     </asp:TableCell>
                 </asp:TableRow>
                <asp:TableRow>
                     <asp:TableCell></asp:TableCell>
                    <asp:TableCell>
                         <%--<asp:Button ID="BtnAddUpdate" runat="server" Text="Add" CssClass="btn btn-info" OnClick="BtnAddUpdate_Click" />
                         <span></span>
                         <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-info" OnClick="BtnReset_Click"/>--%>
                     <asp:Label ID="LblMsg" runat="server" Text="" ForeColor="Red"> </asp:Label>
                     </asp:TableCell>
                  </asp:TableRow>
             </asp:Table>
        </div>

         <div class="jumbotron text-center" style="background-color:white;">
                 <asp:Button ID="BtnAddUpdate" runat="server" Text="Add" CssClass="btn btn-info" OnClick="BtnAddUpdate_Click" />
                         <span>&nbsp;&nbsp;   </span>
                         <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-info" OnClick="BtnReset_Click"/>
                   </div>
    </form>

     
</body></html>