<%@ Page Title="Summary" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Summary.aspx.cs" Inherits="SizananiTecnicalAssessment.Summary" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:HiddenField id="hfUserID" runat="server"/>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="upVehicles" runat="server" width="100%" UpdateMode="Conditional" style="padding-top:60px">
        <ContentTemplate>
            <asp:GridView ID="gvVehicles" runat="server" CssClass="mydatagrid" s
                HeaderStyle-CssClass="header" RowStyle-CssClass="rows" DataSourceID="dsVehicles" AutoGenerateColumns="false" HorizontalAlign="Center" GridLines="Horizontal">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="FullName" />
                    <asp:BoundField DataField="NoOfVehicles" HeaderText="No Of Vehicles" />
                    <asp:BoundField DataField="TotalTons" HeaderText="Total Tons" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="dsVehicles" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString %>" SelectCommand="spSummary_List"
                SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hfUserID" Name="UserID" PropertyName="Value" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>