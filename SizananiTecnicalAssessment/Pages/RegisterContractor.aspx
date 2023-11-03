<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterContractor.aspx.cs" Inherits="SizananiTecnicalAssessment.RegisterContractor" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

 <div id="RegisterContainer">
            <div id="Register" style="display: flex; flex-direction: column;align-items: center; padding-top:60px">
                <div>
                    <section id="RegisterForm">
                        <div>
                            <asp:ValidationSummary runat="server" CssClass="text-danger" />
                            <div>
                                <asp:Label runat="server" AssociatedControlID="txtEmail">Email</asp:Label>
                                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" Width="100%" />
                                <asp:RequiredFieldValidator ID="reqvalEmailRequired" runat="server" ControlToValidate="txtEmail" Display="None"
                                    ErrorMessage="Email is required." SetFocusOnError="true">*</asp:RequiredFieldValidator>
                            </div>
                            <div style="height: 14px;"></div>
                            <div>
                                <asp:Label runat="server" AssociatedControlID="txtFirstName">Name</asp:Label>
                                <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control" Width="100%" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName"
                                    CssClass="text-danger" ErrorMessage="The Name field is required." />
                            </div>
                            <div style="height: 14px;"></div>
                            <div>
                                <asp:Label runat="server" AssociatedControlID="txtLastName">Surname</asp:Label>
                                <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control" Width="100%" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName"
                                    CssClass="text-danger" ErrorMessage="The Surname field is required." />
                            </div>
                            <div style="height: 14px;"></div>
                            <div>
                                <asp:Label runat="server" AssociatedControlID="txtPhone">Phone Number</asp:Label>
                                <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" TextMode="Phone" Width="100%" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone"
                                    CssClass="text-danger" ErrorMessage="The phone number field is required." />
                            </div>
                            <div style="height: 14px;"></div>
                            <div>
                                <asp:Label runat="server" AssociatedControlID="txtUserName">Username</asp:Label>
                                <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUserName"
                                    CssClass="text-danger" ErrorMessage="The username field is required." />
                            </div>
                            <div style="height: 14px;"></div>
                            <div>
                                <asp:Label runat="server" AssociatedControlID="txtPassword">Password</asp:Label>
                                <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" CssClass="form-control" Width="100%" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
                                    CssClass="text-danger" ErrorMessage="The password field is required." />
                            </div>
                            <div style="height: 14px;"></div>
                            <div>
                                <asp:Label runat="server" AssociatedControlID="txtConfirmPassword">Confirm password</asp:Label>
                                <asp:TextBox runat="server" ID="txtConfirmPassword" TextMode="Password" CssClass="form-control" Width="100%" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirmPassword"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                                <asp:CompareValidator runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
                            </div>
                            <div id="spacer5" style="height: 38px;"></div>
                            <div>
                                <div>
                                    <asp:Button runat="server" ID="btnRegister" Text="Register" CssClass="button" Width="100%" Height="36px" Font-Size="1.5em"  OnClick="btnRegister_Click"/>
                                </div>
                            </div>
                            <div id="spacer6" runat="server" style="height: 36px;"></div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
</asp:Content>
