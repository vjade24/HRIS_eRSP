<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="cStaffingPlanEntry.aspx.cs" Inherits="HRIS_eRSP.View.cStaffingPlanEntry.cStaffingPlanEntry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="specific_css" runat="server">
    <style type="text/css">
        /*CSS THAST OVERIDE bootstrap table design*/
        .table-bordered td{
           // border:none !important;
        }
        .table td {
            padding:7px;
        }
        th {
            text-align:center !important
        }
        .table tbody > tr.pagination-ys > td {
              border: 1px solid #e9ecef;
        }
        .table tbody > tr.pagination-ys > td > table td {
            padding:0px !important;
            padding-right:3px !important;
        }
        .pagination-ys > td{
            padding-right:0px !important;
        }
        .pagination-ys td{
            padding-right:0px;
            padding-top:5px;
            padding-bottom:5px;
            vertical-align:unset !important;
            border:none;
        }
        .pagination-ys {
            /*display: inline-block;*/
            padding-left: 0;
            margin: 20px 0;
            border-radius: 4px;
        }
 
        .pagination-ys table > tbody > tr > td {
            display: inline;
        }
 
        .pagination-ys table > tbody > tr > td > a,
        .pagination-ys table > tbody > tr > td > span {
            position: relative;
            float: left;
            padding: 8px 12px;
            line-height: 1.42857143;
            text-decoration: none;
            color: gray !important;
            background-color: #fafafa;
            border: 1px solid #dddddd;
            margin-left: -1px;
        }
 
        .pagination-ys table > tbody > tr > td > span {
            position: relative;
            float: left;
            padding: 8px 12px;
            line-height: 1.42857143;
            text-decoration: none;
            z-index: 2;
            color: white !important;
            background-color:#2461bf;
            border-color: #dddddd;
            cursor: default;
        }
        .no-data-found{
            text-align:center;
            font-weight:200;
        }
        .pagination-ys table > tbody > tr > td:first-child > a,
        .pagination-ys table > tbody > tr > td:first-child > span {
            margin-left: 0;
            border-bottom-left-radius: 4px;
            border-top-left-radius: 4px;
        }
 
        .pagination-ys table > tbody > tr > td:last-child > a,
        .pagination-ys table > tbody > tr > td:last-child > span {
            border-bottom-right-radius: 4px;
            border-top-right-radius: 4px;
        }
 
        .pagination-ys table > tbody > tr > td > a:hover,
        .pagination-ys table > tbody > tr > td > span:hover,
        .pagination-ys table > tbody > tr > td > a:focus,
        .pagination-ys table > tbody > tr > td > span:focus {
            color: #97310e;
            background-color: #eeeeee;
            border-color: #dddddd;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContainer" runat="server">
    <form runat="server" >
        <asp:ScriptManager ID="sm_Script" runat="server"></asp:ScriptManager>
        <div class="row" >
            <div class="col-sm-12">  
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active font-weight-bold">Personnels Informations</li>
                </ol>
            </div>
        </div>
        <div class="row" >
            <div class="col-sm-12">   
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <%-- This Part Update Panel is For Gridview Display --%>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <td>
                                <div class="row" >
                                    <div class="col-sm-12">
                                        <asp:TextBox ID="tbx_search" onInput="search_for(event);" runat="server" class="form-control" placeholder="Search.." Height="30px" 
                                            Width="100%"></asp:TextBox>
                                        <script type="text/javascript">
                                            function search_for(key) {
                                                    __doPostBack("<%= tbx_search.ClientID %>", "");
                                            }
                                    </script>
                                    </div>
                                </div>
                                
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div class="row" style="margin-bottom:10px">
                                    <div class="col-sm-6">
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
                                                <asp:Label runat="server" Text="Show"></asp:Label>
                                                <asp:DropDownList ID="DropDownListID" runat="server" CssClass="form-control-sm" AppendDataBoundItems="true" AutoPostBack="True" Width="15%" ToolTip="Show entries per page">
                                                    <asp:ListItem Text="5" Value="5" />
                                                    <asp:ListItem Text="10" Value="10" />
                                                    <asp:ListItem Text="25" Value="25" />
                                                    <asp:ListItem Text="50" Value="50" />
                                                    <asp:ListItem Text="100" Value="100" />
                                                </asp:DropDownList>
                                                <asp:Label runat="server" Text="Entries"></asp:Label>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="col-sm-6 text-right">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                            <ContentTemplate>
                                                <asp:Button ID="btn_add"  runat="server" autoPostback="false" CssClass="btn btn-primary btn-sm" Text="Add" />
                                                <asp:Button ID="Button3" runat="server" CssClass="btn btn-success btn-sm" Text="Print" /> 
                                            </ContentTemplate>
                                        </asp:UpdatePanel>                       
                                    </div>
                                </div>
                                <asp:UpdatePanel ID="personnelnames_panel" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:GridView 
                                        ID="gv_dataListGrid"
                                        runat="server" 
                                        allowpaging="True" 
                                        AllowSorting="True" 
                                        AutoGenerateColumns="False" 
                                        EnableSortingAndPagingCallbacks="True"
                                        ForeColor="#333333" 
                                        GridLines="Both" height="100%"
                                        PagerStyle-Width="3" 
                                        PagerStyle-Wrap="false" 
                                        pagesize="5"
                                        Width="100%" 
                                        Font-Names="Century gothic"
                                        Font-Size="Medium" 
                                        RowStyle-Width="5%" 
                                        AlternatingRowStyle-Width="10%" CellPadding="2" ShowHeaderWhenEmpty="True"
                                     EmptyDataText="NO DATA FOUND" EmptyDataRowStyle-ForeColor="Red" EmptyDataRowStyle-CssClass="no-data-found">
                                        <Columns>
                                            <asp:TemplateField HeaderText="# ID" SortExpression="empl_id">
                                                <ItemTemplate>
                                                    <%# Eval("barangay_code") %>
                                                </ItemTemplate>
                                                <ItemStyle Width="9%" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="center" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerSettings  
                                            Mode="NumericFirstLast" 
                                            FirstPageText="First" 
                                            PreviousPageText="Previous" 
                                            NextPageText="Next" 
                                            LastPageText="Last" 
                                            PageButtonCount="1" 
                                            Position="Bottom" 
                                            Visible="True" />
                                        <AlternatingRowStyle BackColor="White" />
                                        <EditRowStyle BackColor="#2461BF" />
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Height="10%" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" VerticalAlign="Middle" />
                                        <PagerStyle CssClass="pagination-ys" BackColor="#2461BF" ForeColor="White" HorizontalAlign="right" VerticalAlign="NotSet" Wrap="True" />
                                        <RowStyle BackColor="#EFF3FB" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                        <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                        <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                    </asp:GridView>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btn_add" />
                                    <asp:AsyncPostBackTrigger ControlID="DropDownListID" />
                                </Triggers>
                            </asp:UpdatePanel>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="specific_scripts" runat="server">
</asp:Content>
