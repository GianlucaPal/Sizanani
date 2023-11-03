<%@ Page Title="Vehicles" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Vehicles.aspx.cs" Inherits="SizananiTecnicalAssessment.Vehicles" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="upVehicles" runat="server" UpdateMode="Conditional" style=" display: inline-block; max-width: 600px; padding: 10px;">
        <ContentTemplate>
            <div style="display:flex">
                <table runat="server" style="width: 100%;">
                    <tr>
                        <td style="text-align: right;padding-top:20px">Registration Number:
                        </td>
                        <td style="text-align: right;padding-top:20px">
                            <asp:TextBox ID="txtRegistrationNumber" runat="server" Width="194px" BorderStyle="Solid" BorderColor="Gray" BorderWidth="1px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;padding-top:20px">Type:
                        </td>
                        <td style="text-align: right;padding-top:20px">
                            <asp:DropDownList ID="ddlType" runat="server" Width="200px"
                                DataSourceID="dsType"
                                DataValueField="TypeID"
                                DataTextField="Type"
                                AppendDataBoundItems="true">
                                <asp:ListItem Value="0" Text="-- Select Type --"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;padding-top:20px">Model:
                        </td>
                        <td style="text-align: right;padding-top:20px">
                            <asp:TextBox ID="txtModel" runat="server" Width="194px" BorderStyle="Solid" BorderColor="Gray" BorderWidth="1px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;padding-top:20px">Weight:
                        </td>
                        <td style="text-align: right;padding-top:20px">
                            <asp:TextBox ID="txtWeight" runat="server" Width="194px" BorderStyle="Solid" BorderColor="Gray" BorderWidth="1px"></asp:TextBox>   
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator_txtWeight"
                                ControlToValidate="txtWeight" ValidationGroup="Insert" ForeColor="Red"
                                runat="server" Display="Dynamic"
                                ErrorMessage="'Weight' must be decimal"
                                ValidationExpression="^\d+([,\.]\d{1,2})?$">
                            </asp:RegularExpressionValidator>
                        </td>
                    </tr>
                </table>
            </div>

            <asp:SqlDataSource ID="dsType" runat="server" ConnectionString='<%$ ConnectionStrings:ConnString %>'
                SelectCommand="spType_List" SelectCommandType="StoredProcedure">
                <SelectParameters>
                </SelectParameters>
            </asp:SqlDataSource>

        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="upButtons" UpdateMode ="Conditional" runat="server">
        <ContentTemplate>
            <div style="text-align: center; width: 100%; display: inline-block; padding-top: 20px; padding-bottom: 20px;">
                <asp:Button ID="btnSave" runat="server" CssClass="button" ValidationGroup="Insert"
                    Text="Save" Visible="True" OnClick="btnSave_Click" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
