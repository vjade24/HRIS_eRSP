<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Barangay.aspx.cs" Inherits="HRIS_eAdmin.View.Barangays"%>
<asp:Content ID="Content1" ContentPlaceHolderID="specific_css" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContainer" runat="server">
    <form runat="server">
    <asp:ScriptManager ID="sm_Script" runat="server"> </asp:ScriptManager>
    <!-- The Modal - Add Confirmation -->
            <div class="modal fade" id="AddEditConfirm">
              <div class="modal-dialog modal-dialog">
                <div class="modal-content text-center">
                  <!-- Modal body -->
                    <asp:UpdatePanel ID="UpdatePanel8" runat="server">
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

    <!-- Modal Delete -->
        <div class="modal fade" id="deleteRec">
            <div class="modal-dialog modal-dialog">
            <div class="modal-content text-center">
            <!-- Modal body -->
                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
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

        <asp:UpdatePanel ID="UpdatePanel7" runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
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
                                    <asp:Label ID="Label1" runat="server" Text="Barangay Code:"></asp:Label>
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <asp:TextBox ID="tbx_barangaycode" runat="server" Width="100%" CssClass="form-control"></asp:TextBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    </div>
                                <div class="form-group col-md-6">
                                    <asp:Label ID="Label3" runat="server" Text="Barangay Name:"></asp:Label>
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                        <ContentTemplate>
                                            <asp:TextBox ID="tbx_barangayname" runat="server" Width="100%" CssClass="form-control"></asp:TextBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    </div>
                                <div class="form-group col-md-6">
                                    <asp:Label ID="Label5" runat="server" Text="Province"></asp:Label>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddl_province" runat="server"  Width="100%" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddl_province_SelectedIndexChanged"></asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="form-group col-md-6">
                                    <asp:Label ID="Label7" runat="server" Text="Municipality"></asp:Label>
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
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
                            <asp:Button ID="Button2" runat="server"  Text="Save" CssClass="btn btn-primary"  onClick="btnSave_Click" />
                        </div>
                    </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="Button2" />
            </Triggers>
        </asp:UpdatePanel>
     

    <asp:UpdatePanel ID="up_barangay" runat="server">
        <ContentTemplate>
              <ol class="breadcrumb">
                    <li class="breadcrumb-item active font-weight-bold">Barangays Information</li>
                </ol>
            
            <div id="main_page" runat="server">
                <table width="100%" cellpadding="0" cellspacing="0">
                     
                           <tr id="tr_footer" runat="server">
                               <td>
                                   <div>
                                       <table class="table table-bordered">
                                           
                                           <tr>
                                               <td>
                                                   <div class="row" >
                                                        <div class="col-sm-12">
                                                         <asp:TextBox ID="tbx_search" onInput="search_for(event);" runat="server" class="form-control" placeholder="Search.." Height="30px" 
                                                             Width="100%" OnTextChanged="tbx_search_TextChanged"></asp:TextBox>
                                                         <script type="text/javascript">
                                                             function search_for(key) {
                                                                        __doPostBack("<%= tbx_search.ClientID %>", "");
                                                                }
                                                        </script>
                                                        </div>
                                                   </div>

                                                       <tr>
                                                           <td>
                                                               <div class="row" style="margin-bottom:10px">
                                                                   <div class="col-sm-6">
                                                                        <asp:Label runat="server" Text="Show"></asp:Label>
                                                                        <asp:DropDownList ID="DropDownListID" runat="server" CssClass="form-control-sm" AppendDataBoundItems="true" AutoPostBack="True" OnTextChanged="DropDownListID_TextChanged" Width="15%" ToolTip="Show entries per page">
                                                                            <asp:ListItem Text="5" Value="5" />
                                                                            <asp:ListItem Text="10" Value="10" />
                                                                            <asp:ListItem Text="15" Value="15" />
                                                                        </asp:DropDownList>
                                                                        <asp:Label runat="server" Text="Entries"></asp:Label>
                                                                   </div>
                                                                   <div class="col-sm-6 text-right">
                                                                        <%--<asp:ImageButton ID="imgbtn_add1" runat="server" height="20px" ImageUrl="~/ResourceImages/add.png" onclick="imgbtn_add_Click"  data-target="#add" width="20px" />--%>
                                                                        <%--<asp:LinkButton  runat="server" CssClass="btn btn-primary btn-sm" OnCommand="imgbtn_add_Click1" ><i class="fa fa-plus"></i> Add</asp:LinkButton>--%>
                                                                         <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary btn-sm" Text="Add" OnClick="btnAdd_Click" />
                                                                         <asp:Button ID="Button3" runat="server" CssClass="btn btn-success btn-sm" Text="Print" />     
                                                                       
                                                                    </div>
                                                               </div>
                                                               <asp:GridView 
                                                                   ID="gv_dataListGrid" 
                                                                   runat="server" 
                                                                   allowpaging="True" 
                                                                   AllowSorting="True" 
                                                                   AutoGenerateColumns="False" 
                                                                   EnableSortingAndPagingCallbacks="True"
                                                                   ForeColor="#333333" 
                                                                   GridLines="Both" height="100%" 
                                                                   onsorting="gv_dataListGrid_Sorting"  
                                                                   OnPageIndexChanging="gridviewbind_PageIndexChanging"
                                                                   PagerStyle-Width="1" 
                                                                   PagerStyle-Wrap="False" 
                                                                   pagesize="5"
                                                                   Width="100%" 
                                                                   Font-Names="Century gothic"
                                                                   Font-Size="Medium" 
                                                                   RowStyle-Width="5%" 
                                                                   AlternatingRowStyle-Width="10%"
                                                                   >
                                                                   <Columns>
                                                                       <asp:TemplateField HeaderText="CODE" SortExpression="barangay_code">
                                                                           <ItemTemplate>
                                                                           <asp:LinkButton ID="lbtn_barangaycode_c1" runat="server" CommandArgument='<%# Eval("barangay_code") %>' CommandName="select" ForeColor="Black" Text='<%# Eval("barangay_code") %>'> </asp:LinkButton>
                                                                           </ItemTemplate>
                                                                           <ItemStyle Width="10%" />
                                                                           <HeaderStyle HorizontalAlign="Center" />
                                                                           <ItemStyle HorizontalAlign="center" />
                                                                       </asp:TemplateField>
                                                                       <asp:TemplateField HeaderText="BARANGAY NAME" SortExpression="barangay_name">
                                                                           <ItemTemplate>
                                                                               <asp:LinkButton ID="lbtn_barangayname_c1" runat="server" CommandArgument='<%# Eval("barangay_name") %>' CommandName="select" ForeColor="Black" Text='<%# Eval("barangay_name") %>'></asp:LinkButton>
                                                                           </ItemTemplate>
                                                                           <ItemStyle Width="30%" />
                                                                           <HeaderStyle HorizontalAlign="Center" />
                                                                           <ItemStyle HorizontalAlign="left" />
                                                                       </asp:TemplateField>
                                                                       <asp:TemplateField HeaderText="MUNICIPALITY NAME" SortExpression="municipality_name">
                                                                           <ItemTemplate>
                                                                               <asp:LinkButton ID="lbtn_municipalityname_c1" runat="server" CommandArgument='<%# Eval("municipality_name") %>' CommandName="select" ForeColor="Black" Text='<%# Eval("municipality_name") %>'></asp:LinkButton>
                                                                           </ItemTemplate>
                                                                           <ItemStyle Width="25%" />
                                                                           <HeaderStyle HorizontalAlign="Center" />
                                                                           <ItemStyle HorizontalAlign="left" />
                                                                       </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="PROVINCE NAME" SortExpression="province_name">
                                                                           <ItemTemplate>
                                                                               <asp:LinkButton ID="lbtn_provincename_c1" runat="server" CommandArgument='<%# Eval("province_name") %>' CommandName="select" ForeColor="Black" Text='<%# Eval("province_name") %>'></asp:LinkButton>
                                                                           </ItemTemplate>
                                                                           <ItemStyle Width="25%" />
                                                                           <HeaderStyle HorizontalAlign="Center" />
                                                                           <ItemStyle HorizontalAlign="left" />
                                                                        </asp:TemplateField>
                                                                       <asp:TemplateField HeaderText="ACTION">
                                                                           <ItemTemplate>
                                                                               <%--<asp:LinkButton ID="lnkEditRow" runat="server" CssClass="btn btn-danger btn-md" OnCommand="editRow_Command" CommandArgument='<%# Eval("barangay_code") %>'><i class="fa fa-edit"></i></asp:LinkButton>--%>
                                                                                <asp:ImageButton ID="imgbtn_editrow1" runat="server" height="20px" width="20px" ImageUrl="~/ResourceImages/edit.png" OnCommand="editRow_Command" CommandArgument='<%# Eval("barangay_code") %>'/>
                                                                                <asp:ImageButton ID="lnkDeleteRow" runat="server" height="20px" width="20px" ImageUrl="~/ResourceImages/delete1.png" OnCommand="deleteRow_Command" CommandArgument='<%# Eval("barangay_code") + ", " + Eval("barangay_name") %>'/>

                                                                           </ItemTemplate>
                                                                           <ItemStyle Width="20%" />
                                                                       </asp:TemplateField>

                                                                   </Columns>

                                                                   <PagerSettings  Mode="NumericFirstLast" FirstPageText="First" PreviousPageText="Previous" NextPageText="Next" LastPageText="Last" PageButtonCount="1" Position="Bottom" Visible="True" />
                                                                   <AlternatingRowStyle BackColor="White" />
                                                                   <EditRowStyle BackColor="#2461BF" />
                                                                   <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Height="10%" />
                                                                   <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                                   <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="right" VerticalAlign="NotSet"/>
                                                                   <RowStyle BackColor="#EFF3FB" />
                                                                   <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                                   <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                                                   <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                                                   <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                                                   <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                                               </asp:GridView>
                                                           </td>
                                                       </tr>
                                                   
                                               </td>
                                               
                                           </tr>
                                       </table>
                                   </div>
                               </td>
                           </tr>
                </table>

            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    </form>

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
            $('#deleteRec').modal('close');
            
         };
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="specific_scripts" runat="server">
</asp:Content>