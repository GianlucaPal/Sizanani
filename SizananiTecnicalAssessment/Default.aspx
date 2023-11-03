<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SizananiTecnicalAssessment._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:HiddenField id="hfUserID" runat="server"/>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="upVehicles" runat="server" width="100%" UpdateMode="Conditional" style="padding-top:60px">
        <ContentTemplate>

            <asp:Button  ID="btnAddVehicle" runat="server" Text="Add Vehicle" CssClass="btn btn-secondary" Width="100%" Height="36px" Font-Size="1.5em" OnClick="btnAddVehicle_Click"/>
            <asp:GridView ID="gvVehicles" runat="server" CssClass="mydatagrid" DataKeyNames="VehicleID" 
                HeaderStyle-CssClass="header" RowStyle-CssClass="rows" DataSourceID="dsVehicles" AutoGenerateColumns="false" HorizontalAlign="Center" GridLines="Horizontal">
                <Columns>
                    <asp:BoundField DataField="VehicleID" HeaderText="VehicleID" Visible ="false"/>
                    <asp:BoundField DataField="RegistrationNumber" HeaderText="Registration Number" />
                    <asp:BoundField DataField="Model" HeaderText="Model" />
                    <asp:BoundField DataField="Type" HeaderText="Type" />
                    <asp:BoundField DataField="Weight" HeaderText="Weight"/>
                    <asp:TemplateField Visible="true">
                        <ItemTemplate>
                            <asp:Button runat="server" ID="btnEdit" class="btn btn-secondary" Text="Edit" OnClick="btnEdit_Click"/>
                            <asp:Button runat="server" ID="btnDelete" class="btn btn-danger" Text="Delete" OnClick="btnDelete_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="dsVehicles" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString %>" SelectCommand="spVehicles_ListByUser"
                SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hfUserID" Name="UserID" PropertyName="Value" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
