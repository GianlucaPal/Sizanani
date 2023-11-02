<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SizananiTecnicalAssessment.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

         <div id="LoginContainer">
            <div id="LoginContainerBodyContainer" style="display: flex; flex-direction: column;align-items: center; padding-top:60px">
                <div>
                    <section id="loginForm">
                        <div>                              
                            <div>
                                <label id="lblUserName" runat="server">User Name</label>
                                <div id="spacer0" style="height: 9px;"></div>
                                <asp:TextBox ID="txtUserName" runat="server" TabIndex="1" Width="100%" Height="30px" Font-Size="Larger" BorderColor="#18A5FF"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqvalUserNameRequired" runat="server" ControlToValidate="txtUserName" Display="None"
                                    ErrorMessage="User Name is required." ValidationGroup="LoginWizard" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                            </div>
                            <div id="spacer1" style="height: 14px;"></div>
                            <div>
                                <label id="lblPassword" runat="server">Password</label>
                                <div id="spacer3" style="height: 9px;"></div>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" TabIndex="2" Width="100%" Height="30px" Font-Size="Larger" BorderColor="#18A5FF"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqvalPasswordRequired" runat="server" ControlToValidate="txtPassword" Display="None"
                                    ErrorMessage="Password is required." ValidationGroup="LoginWizard" SetFocusOnError="true">*</asp:RequiredFieldValidator>

                            </div>
                            <div id="spacer5" style="height: 38px;"></div>
                            <div>
                                <div style="display: flex; flex-direction: column;">
                                    <asp:label id="lblLoginError" runat="server" class="text-danger" Visible="false"></asp:label>
                                    <asp:Button  ID="btnLogin" runat="server" Text="Log in" CssClass="button" Width="100%" Height="36px" Font-Size="1.5em" OnClick="btnLogin_Click"/>
                                    <asp:HyperLink ID="RegisterHyperLink" runat="server" NavigateUrl="~/Pages/Register.aspx" ToolTip="Start Password Recovery Process">Don't have an account? Register account</asp:HyperLink>
                                </div>
                            </div>
                            <div id="spacer6" runat="server" style="height: 36px;"></div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
</asp:Content>
