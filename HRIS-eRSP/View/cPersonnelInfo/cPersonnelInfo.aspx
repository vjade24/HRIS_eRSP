<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="cPersonnelInfo.aspx.cs" Inherits="HRIS_eRSP.View.cPersonnelInfo.cPersonnelInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="specific_css" runat="server">
    <style type="text/css">
        /*CSS THAST OVERIDE bootstrap table design*/
        .action{
            padding: 5px !important;
            height: 30px !important;
        }

        .table-bordered td{
            /*border:none !important;*/
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
         <!-- The Modal - Add Confirmation -->
            <div class="modal fade" id="AddEditConfirm">
              <div class="modal-dialog modal-dialog">
                <div class="modal-content text-center">
                  <!-- Modal body -->
                    <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                        <ContentTemplate>
 
                    <div class="modal-body">
                      <i class="fa-5x fa fa-check-circle text-success"></i>
                      <h2 >Successfully</h2>
                       <h6><asp:Label ID="SaveAddEdit" runat="server" Text="Save"></asp:Label></h6>
                  </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                  <!-- Modal footer -->
                  <div style="margin-bottom:30px">
                  </div>
                </div>
              </div>
            </div>
        <asp:UpdatePanel ID="delete_confirm_popup" ChildrenAsTriggers="false" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <!-- Modal Delete -->
                <div class="modal fade" id="deleteRec">
                    <div class="modal-dialog modal-dialog">
                    <div class="modal-content text-center">
                    <!-- Modal body -->
                            <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                <ContentTemplate>
                                    <div class="modal-body">
                                        <i class="fa-5x fa fa-question text-danger"></i>
                                        <h2 >Delete this Record</h2>
                                        <h6><asp:Label ID="deleteRec1" runat="server" Text="Are you sure to delete this Record"></asp:Label></h6>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        <!-- Modal footer -->
                        <div style="margin-bottom:50px">
                            <asp:LinkButton ID="lnkBtnYes" runat="server"  CssClass="btn btn-danger" OnCommand="btnDelete_Command"> <i class="fa fa-check"></i> Yes, Delete it </asp:LinkButton>
                            <asp:LinkButton ID="LinkButton3"  runat="server" data-dismiss="modal"  CssClass="btn btn-dark"> <i class="fa fa-times"></i> No, Keep it! </asp:LinkButton>
                        </div>
                    </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    
        <asp:UpdatePanel ID="add_edit_panel" ChildrenAsTriggers="false" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <!-- Modal Add/EditPage-->
                <div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                            <ContentTemplate>
                                <h5 class="modal-title" id="AddEditPage"><asp:Label ID="LabelAddEdit" runat="server" Text="Add/Edit Page"></asp:Label></h5>
                            </ContentTemplate>
                            </asp:UpdatePanel>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        </div>
                        <div class="modal-body" runat="server">
                        <div class="row" runat="server">
                                <div class="form-group col-md-6" >
                                    <asp:Label ID="Label1" runat="server" Text="Personnel Id:"></asp:Label>
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                        <ContentTemplate>
                                            <asp:TextBox ID="tbx_empl_id" runat="server" Width="100%" CssClass="form-control" Enabled="False"></asp:TextBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:Label ID="Label2" runat="server" Text="BIR TIN:"></asp:Label>
                                    <asp:TextBox runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                 <div class="form-group col-12">
                                     <div class ="form-group row">
                                         <label for="inputPassword" class="col-sm-3 col-form-label">Password</label>
                                         <div class="col-9">
                                            <input type="password" class="form-control" id="inputPassword" placeholder="Password">
                                         </div>
                                     </div>
                                  </div>
                                <div class="form-group col-md-6">
                                    <asp:Label ID="Label3" runat="server" Text="Barangay Name:"></asp:Label>
                                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                        <ContentTemplate>
                                            <asp:TextBox ID="tbx_barangayname" runat="server" Width="100%" CssClass="form-control"></asp:TextBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    </div>
                                <div class="form-group col-md-6">
                                    <asp:Label ID="Label5" runat="server" Text="Province"></asp:Label>
                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddl_province" runat="server"  Width="100%" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddl_province_SelectedIndexChanged"></asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="form-group col-md-6">
                                    <asp:Label ID="Label7" runat="server" Text="Municipality"></asp:Label>
                                    <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                        <ContentTemplate>
                                                <asp:DropDownList ID="ddl_municity" runat="server"  Width="100%" CssClass="form-control"></asp:DropDownList>
                                                <asp:Label ID="LabelAdEditMode" runat="server" Text="Init" Visible="false"></asp:Label>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="LinkButton2"  runat="server" data-dismiss="modal" Text ="Cancel" CssClass="btn btn-danger"></asp:LinkButton>
                            <asp:Button ID="Button2" runat="server"  Text="Save" CssClass="btn btn-primary" />
                        </div>
                    </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>

            </Triggers>
        </asp:UpdatePanel>
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
                <table class="table table-bordered  table-scroll">
                    <thead>
                        <tr>
                            <td>
                                <div class="row" >
                                    <div class="col-sm-12">
                                        <asp:UpdatePanel ID="UpdatePanel3" ChildrenAsTriggers="false" UpdateMode="Conditional"  runat="server">
                                            <ContentTemplate>
                                                <asp:TextBox ID="txt_search" onInput="search_for(event);" runat="server" class="form-control" placeholder="Search.." Height="30px" 
                                            Width="100%" OnTextChanged="txt_search_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                <script type="text/javascript">
                                                    function search_for(key)
                                                    {
                                                           __doPostBack("<%= txt_search.ClientID %>", "");
                                                    }
                                                </script>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
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
                                                <asp:DropDownList ID="DropDownListID" OnTextChanged="DropDownListID_TextChanged" runat="server" CssClass="form-control-sm" AppendDataBoundItems="true" AutoPostBack="True" Width="15%" ToolTip="Show entries per page">
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
                                                <asp:Button ID="btn_add"  runat="server" autoPostback="false" CssClass="btn btn-primary btn-sm" Text="Add" OnClick="btnAdd_Click"/>
                                                <asp:Button ID="Button3" runat="server" CssClass="btn btn-success btn-sm" Text="Print" /> 
                                            </ContentTemplate>
                                        </asp:UpdatePanel>                       
                                    </div>
                                </div>
                                <asp:UpdatePanel ID="personnelnames_panel" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:GridView 
                                        ID="gv_personnelinfolist"
                                        runat="server" 
                                        allowpaging="True" 
                                        AllowSorting="True" 
                                        AutoGenerateColumns="False" 
                                        EnableSortingAndPagingCallbacks="True"
                                        ForeColor="#333333" 
                                        GridLines="Both" height="100%" 
                                        onsorting="gv_dataListGrid_Sorting"  
                                        OnPageIndexChanging="gridviewbind_PageIndexChanging"
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
                                                    <%# Eval("empl_id") %>
                                                </ItemTemplate>
                                                <ItemStyle Width="9%" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="LAST NAME" SortExpression="last_name">
                                                <ItemTemplate>
                                                    <%# Eval("last_name") %>
                                                </ItemTemplate>
                                                <ItemStyle Width="25%" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FIRST NAME" SortExpression="first_name">
                                                <ItemTemplate>
                                                    <%# Eval("first_name") %>
                                                </ItemTemplate>
                                                <ItemStyle Width="25%" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="MIDDLE NAME" SortExpression="middle_name">
                                                <ItemTemplate>
                                                    <%# Eval("middle_name") %>
                                                </ItemTemplate>
                                                <ItemStyle Width="25%" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ACTION">
                                                <ItemTemplate>
                                                    <%--<asp:LinkButton ID="lnkEditRow" runat="server" CssClass="btn btn-danger btn-md" OnCommand="editRow_Command" CommandArgument='<%# Eval("barangay_code") %>'><i class="fa fa-edit"></i></asp:LinkButton>--%>
                                                    <asp:ImageButton ID="imgbtn_editrow1" CssClass="btn btn-primary action" EnableTheming="true"  runat="server"  ImageUrl="~/ResourceImages/final_edit.png" OnCommand="editRow_Command" CommandArgument='<%# Eval("empl_id") %>' ImageAlign="Middle" />
                                                    <asp:ImageButton ID="lnkDeleteRow" CssClass="btn btn-danger action" EnableTheming="true" runat="server"  ImageUrl="~/ResourceImages/final_delete.png" OnCommand="deleteRow_Command" CommandArgument='<%# Eval("empl_id") + ", " + Eval("first_name")+" "+Eval("last_name") %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="8%" />
                                                <ItemStyle CssClass="text-center" />
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
                                    <asp:AsyncPostBackTrigger ControlID="txt_search" />
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
    <script type="text/javascript">
        function openModal() {
            $('#add').modal({
                keyboard: false,
                backdrop:"static"
            });
       };
    </script>
    <script type="text/javascript">
        function closeModal() {
            $('#add').modal("hide");
             $('#AddEditConfirm').modal({
                 keyboard: false,
                backdrop:"static"
            });
            setTimeout(function () {
                $('#AddEditConfirm').modal("hide");
                $('.modal-backdrop.show').remove();
            }, 800);
         };
    </script>

    <script type="text/javascript">
        function openModalDelete() {
            $('#deleteRec').modal({
                keyboard: false,
                backdrop:"static"
            });
       };
    </script>
    <script type="text/javascript">
        function closeModalDelete() {
            $('#deleteRec').modal('hide');
         };
    </script>
</asp:Content>
