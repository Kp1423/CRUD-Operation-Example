<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderList.aspx.cs" Inherits="DevItPractical.OrderList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">
            <asp:ScriptManager runat="server"></asp:ScriptManager>

        <div class="container">
            <div class="jumbotron text-center">
                <h1>Customer Order</h1>
                <asp:Button ID="btnAdd" runat="server" Text="New Order" CssClass="btn btn-info" OnClick="btnAdd_Click" />
            </div>

            <asp:UpdatePanel ID="upCrudGrid" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvCust" runat="server" AutoGenerateColumns="false" DataKeyNames="Sr"
                          OnRowCommand="gvCust_RowCommand" CssClass="table table-striped">
                        <EmptyDataTemplate>
                         <asp:Label runat="server" Text="No Data Found" Visible="false"></asp:Label> 
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="Sr"  HeaderText="Sr." />
                            <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" />
                            <asp:BoundField DataField="OrderDate" HeaderText="Order Date" />
                            <asp:BoundField DataField="ItemName" HeaderText="Item Name" />
                            <asp:BoundField DataField="Price" HeaderText="Price" />
                            <asp:BoundField DataField="Quantity"  HeaderText="Quantity" />
                            <asp:BoundField DataField="Amount"  HeaderText="Amount" />
                            
                            <asp:ButtonField CommandName="editRecord" ControlStyle-CssClass="btn btn-info" 
                            ButtonType="Button" Text="Edit" HeaderText="" ItemStyle-CssClass="text-center">
                            </asp:ButtonField>
                            <%--<asp:ButtonField CommandName="deleteRecordold" ControlStyle-CssClass="btn btn-info" 
                            ButtonType="Button" Text="Delete" HeaderText="" ItemStyle-CssClass="text-center">
                            </asp:ButtonField>--%>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button runat="server" CommandName="deleteRecord" Text="Delete" CommandArgument='<%# Eval ("Sr") %>'
                                        CssClass="btn btn-info;" BackColor="SkyBlue" ForeColor="White"
                                        OnClientClick="return confirm('Are you sure you want to delete record?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:Label ID="lblMessage" runat="server" />

        </div>
    </form>

    
</body>
</html>
