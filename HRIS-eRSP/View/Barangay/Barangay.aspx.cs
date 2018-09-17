//**********************************************************************************
// PROJECT NAME     :   HRIS - eComval
// VERSION/RELEASE  :   HRIS Release #1
// PURPOSE          :   Code Behind for Barangay Page
//**********************************************************************************
// REVISION HISTORY
//**********************************************************************************
// AUTHOR                    DATE            PURPOSE
//----------------------------------------------------------------------------------
// ARIEL CABUNGCAL (AEC)      09/09/2018      Code Creation
//**********************************************************************************
using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.UI;
using HRIS_Common;

namespace HRIS_eAdmin.View
{
    public partial class Barangays : System.Web.UI.Page
    {

        //********************************************************************
        //  BEGIN - AEC- 09/09/2018 - Data Place holder creation 
        //********************************************************************
        DataTable dtSource
        {
            get
            {
                if ((DataTable)ViewState["dtSource"] == null) return null;
                return (DataTable)ViewState["dtSource"];
            }
            set
            {
                ViewState["dtSource"] = value;
            }
        }

        DataTable dataListGrid
        {
            get
            {
                if ((DataTable)ViewState["dataListGrid"] == null) return null;
                return (DataTable)ViewState["dataListGrid"];
            }
            set
            {
                ViewState["dataListGrid"] = value;
            }
        }

        DataTable provincelist
        {
            get
            {
                if ((DataTable)ViewState["provincelist"] == null) return null;
                return (DataTable)ViewState["provincelist"];
            }
            set
            {
                ViewState["provincelist"] = value;
            }
        }
        DataTable municipalitieslist
        {
            get
            {
                if ((DataTable)ViewState["municipalitieslist"] == null) return null;
                return (DataTable)ViewState["municipalitieslist"];
            }
            set
            {
                ViewState["municipalitieslist"] = value;
            }
        }

        //********************************************************************
        //  BEGIN - AEC- 09/12/2018 - Public Constant Variable used in Sorting
        //********************************************************************
         const string CONST_SORTASC = "ASC";
         const string CONST_SORTDESC = "DESC";

        //********************************************************************
        //  BEGIN - AEC- 09/09/2018 - Page Load method
        //********************************************************************
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializePage();
            }
        }


        //********************************************************************
        //  BEGIN - AEC- 09/09/2018 - Initialiazed Page 
        //********************************************************************
        private void InitializePage()
        {
            Session["sortdirection"] = SortDirection.Ascending.ToString();
            Session["barangay_code"] = "barangay_code";
            RetrieveDataListGrid();
        }

        //*************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Retrieve back end data and load to GridView
        //*************************************************************************
        private void RetrieveDataListGrid()
        {
            dataListGrid = CommonDB.RetrieveData("sp_barangays_tbl_list");
            CommonCode.GridViewBind(ref this.gv_dataListGrid, dataListGrid);
        }

        //*************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Add button to trigger add/edit page
        //*************************************************************************
         protected void btnAdd_Click(object sender, EventArgs e)
        {
            RetrieveBindingCityMuni();
            RetrieveBindingProvince();
            ClearEntry();
            InitializeTable();
            AddPrimaryKeys();
            AddNewRow();

            LabelAddEdit.Text = "Add New Record";
            LabelAdEditMode.Text = "ADD";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

        //*************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Clear Add/Edit Page Fields
        //*************************************************************************
        private void ClearEntry()
        {
            tbx_barangaycode.Text = "";
            tbx_barangayname.Text = "";

            ddl_province.SelectedIndex = 0;
            ddl_municity.SelectedIndex = 0;
            tbx_barangaycode.ReadOnly = false;
            tbx_barangaycode.Focus();
        }

        //*************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Add new row to datatable object
        //*************************************************************************
        private void AddNewRow()
        {
            DataRow nrow = dtSource.NewRow();
            nrow["barangay_code"] = string.Empty;
            nrow["action"] = 1;
            nrow["retrieve"] = false;
            dtSource.Rows.Add(nrow);

            int dtRowCont = dataListGrid.Rows.Count - 1;
            string lastCode = "000";

            if (dtRowCont > 0)
            {
                DataRow lastRow = dataListGrid.Rows[dtRowCont];
                lastCode = lastRow["barangay_code"].ToString();
            }

            int lastCodeInt = int.Parse(lastCode) + 1;
            string nextCode = lastCodeInt.ToString();
            nextCode = nextCode.PadLeft(3, '0');

            tbx_barangaycode.Text = nextCode;
        }

        //*************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Initialized datasource fields/columns
        //*************************************************************************
        private void InitializeTable()
        {
            dtSource = new DataTable();
            dtSource.Columns.Add("barangay_code", typeof(System.String));
            dtSource.Columns.Add("barangay_name", typeof(System.String));
            dtSource.Columns.Add("municipality_code", typeof(System.String));
        }

        //*************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Add Primary Key Field to datasource
        //*************************************************************************
        private void AddPrimaryKeys()
        {
            dtSource.TableName = "barangays_tbl";
            dtSource.Columns.Add("action", typeof(System.Int32));
            dtSource.Columns.Add("retrieve", typeof(System.Boolean));
            string[] col = new string[] { "barangay_code" };
            dtSource = CommonDB.AddPrimaryKeys(dtSource, col);
        }

        //***************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Triggers Delete Confirmation Pop-up Dialog Box
        //***************************************************************************
        protected void deleteRow_Command(object sender, CommandEventArgs e)
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            string brgcode = commandArgs[0];
            string brgname = commandArgs[1];

            deleteRec1.Text = "Are you sure to delete this Barangay = (" + brgcode.Trim() + ") - " + brgname.Trim() + " ?";
            lnkBtnYes.CommandArgument = brgcode;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalDelete();", true);
        }

        //*************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Delete Data to back-end Database
        //*************************************************************************
        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            string svalues = e.CommandArgument.ToString();
            string deleteExpression = "barangay_code = '" + svalues + "'";

            CommonDB.DeleteBackEndData("barangays_tbl", "WHERE " + deleteExpression);

            DataRow[] row2Delete = dataListGrid.Select(deleteExpression);
            dataListGrid.Rows.Remove(row2Delete[0]);
            dataListGrid.AcceptChanges();
            CommonCode.GridViewBind(ref this.gv_dataListGrid, dataListGrid);

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "closeModalDelete();", true);
        }

        //**************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Edit Row selection that will trigger edit page 
        //**************************************************************************
        protected void editRow_Command(object sender, CommandEventArgs e)
        {
            string svalues = e.CommandArgument.ToString();
            string editExpression = "barangay_code = '" + svalues + "'";

            DataRow[] row2Edit = dataListGrid.Select(editExpression);

            RetrieveBindingCityMuni();
            RetrieveBindingProvince();
            ClearEntry();

            InitializeTable();
            AddPrimaryKeys();
            DataRow nrow = dtSource.NewRow();
            nrow["barangay_code"] = string.Empty;
            nrow["action"] = 2;
            nrow["retrieve"] = true;
            dtSource.Rows.Add(nrow);

            tbx_barangaycode.Text = svalues;
            tbx_barangayname.Text = row2Edit[0]["barangay_name"].ToString();

            ddl_province.SelectedValue = row2Edit[0]["province_code"].ToString();
            if (ddl_province.SelectedValue.ToString() != String.Empty)
            {
                RetrieveBindingCityMuni();
                ddl_municity.SelectedValue = row2Edit[0]["municipality_code"].ToString();
            }

            tbx_barangaycode.ReadOnly = true;
            tbx_barangayname.Focus();
            LabelAddEdit.Text = "Edit Record: " + tbx_barangayname.Text.Trim();
            LabelAdEditMode.Text = "EDIT";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

        //**************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Change Field Sort mode  
        //**************************************************************************
        protected void gv_dataListGrid_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sortingDirection = string.Empty;
            sortingDirection = GetCurrentSortDir();

            if (sortingDirection == CONST_SORTASC)
            {
                SortDirectionVal = SortDirection.Descending;
                sortingDirection = CONST_SORTDESC;
            }
            else
            {
                    SortDirectionVal = SortDirection.Ascending;
                    sortingDirection = CONST_SORTASC;
                }
            CommonDB.Sort(gv_dataListGrid, dataListGrid, e.SortExpression, sortingDirection);
        }

        //**************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Get Grid current sort order 
        //**************************************************************************
        private string GetCurrentSortDir()
        {
            string sortingDirection = string.Empty;

            if (SortDirectionVal == SortDirection.Ascending)
            {
                sortingDirection = CONST_SORTASC;
            }
            else
            {
                sortingDirection = CONST_SORTDESC;
            }

            return sortingDirection;
        }
        //**************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Save New Record/Edited Record to back end DB
        //**************************************************************************
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string saveRecord = LabelAdEditMode.Text.ToString();

            string scriptInsertUpdate = string.Empty;

            if (saveRecord == "ADD")
            { 
                dtSource.Rows[0]["barangay_code"] = tbx_barangaycode.Text.ToString();
                dtSource.Rows[0]["barangay_name"] = tbx_barangayname.Text.ToString();
                dtSource.Rows[0]["municipality_code"] = ddl_municity.SelectedValue.ToString();
                scriptInsertUpdate = CommonDB.get_insertscript(dtSource);
            }
            else if (saveRecord == "EDIT")
            {
                dtSource.Rows[0]["barangay_code"] = tbx_barangaycode.Text.ToString();
                dtSource.Rows[0]["barangay_name"] = tbx_barangayname.Text.ToString();
                dtSource.Rows[0]["municipality_code"] = ddl_municity.SelectedValue.ToString();
                scriptInsertUpdate = CommonDB.updatescript(dtSource);
            }

            if (saveRecord == "ADD" || saveRecord == "EDIT")
            {
                if (scriptInsertUpdate == string.Empty) return;
                string msg = CommonDB.insertdata(scriptInsertUpdate);
                if (msg == "") return;
                if (msg.Substring(0, 1) == "X") return;

                if (saveRecord == "ADD")
                {
                    DataRow nrow = dataListGrid.NewRow();
                    nrow["barangay_code"] = tbx_barangaycode.Text.ToString(); 
                    nrow["barangay_name"] = tbx_barangayname.Text.ToString(); 
                    nrow["municipality_code"] = ddl_municity.SelectedValue.ToString();
                    nrow["province_code"] = ddl_province.SelectedValue.ToString();
                    nrow["municipality_name"] = ddl_municity.SelectedItem.Text.ToString();
                    nrow["province_name"] = ddl_province.SelectedItem.Text.ToString();
                    dataListGrid.Rows.Add(nrow);
                    gv_dataListGrid.SetPageIndex(gv_dataListGrid.PageCount);
                    gv_dataListGrid.SelectRow(gv_dataListGrid.Rows.Count - 1);
                    SaveAddEdit.Text = "New Record Successfully Added";
                }
                if (saveRecord == "EDIT")
                {
                    string editExpression = "barangay_code = '" + tbx_barangaycode.Text.ToString() + "'";
                    DataRow[] row2Edit = dataListGrid.Select(editExpression);
                    row2Edit[0]["barangay_name"] = tbx_barangayname.Text.ToString();
                    row2Edit[0]["municipality_code"] = ddl_municity.SelectedValue.ToString();
                    row2Edit[0]["province_code"] = ddl_province.SelectedValue.ToString();
                    row2Edit[0]["municipality_name"] = ddl_municity.SelectedItem.Text.ToString();
                    row2Edit[0]["province_name"] = ddl_province.SelectedItem.Text.ToString();
                    CommonCode.GridViewBind(ref this.gv_dataListGrid, dataListGrid);
                    SaveAddEdit.Text = "Current Record Successfully Updated";
                }

                LabelAdEditMode.Text = "Init";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "closeModal();", true);
            }
        }

        //**************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Populate Combo list from Province table
        //*************************************************************************
        private void RetrieveBindingProvince()
        {
            ddl_province.Items.Clear();
            DataTable dt = CommonDB.RetrieveData("sp_provinces_tbl_list");

            ddl_province.DataSource = dt;
            ddl_province.DataTextField = "province_name";
            ddl_province.DataValueField = "province_code";
            ddl_province.DataBind();
            ListItem li = new ListItem("-- Select Here --", "");
            ddl_province.Items.Insert(0, li);
        }

        //******************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Populate Conbo list from City/Municipalities table
        //******************************************************************************
        private void RetrieveBindingCityMuni()
        {
            ddl_municity.Items.Clear();
            municipalitieslist = CommonDB.RetrieveData("sp_municipalities_tbl_list2", "province_code", this.ddl_province.SelectedValue);
            ddl_municity.DataTextField = "municipality_name";
            ddl_municity.DataValueField = "municipality_code";
            ddl_municity.DataSource = municipalitieslist;
            ddl_municity.DataBind();

            ListItem li = new ListItem("-- Select Here --", "");
            ddl_municity.Items.Insert(0, li);
        }

        //**************************************************************************
        //  BEGIN - AEC- 09/12/2018 - GridView Change Page Number
        //**************************************************************************
        protected void gridviewbind_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gv_dataListGrid.PageIndex = e.NewPageIndex;
            CommonCode.GridViewBind(ref this.gv_dataListGrid, dataListGrid);
        }

        //**********************************************************************************
        //  BEGIN - AEC- 09/12/2018 - Change on Page Size (no. of row per page) on Gridview  
        //*********************************************************************************
        protected void DropDownListID_TextChanged(object sender, EventArgs e)
        {
            gv_dataListGrid.PageSize = Convert.ToInt32(DropDownListID.Text);
            CommonCode.GridViewBind(ref this.gv_dataListGrid, dataListGrid);
        }

        //**********************************************************************************
        //  BEGIN - AEC- 09/12/2018 - Search Data Bind to Grid View on every KeyInput  
        //*********************************************************************************
        protected void tbx_search_TextChanged(object sender, EventArgs e)
        {
            string searchExpression = "barangay_code LIKE '%" + tbx_search.Text.Trim() + "%' OR barangay_name LIKE '%" + tbx_search.Text.Trim() + "%' OR municipality_name LIKE '%" + tbx_search.Text.Trim() + "%' OR province_name LIKE '%" + tbx_search.Text.Trim() + "%'";

            DataTable dtSource1 = new DataTable();
            dtSource1.Columns.Add("barangay_code", typeof(System.String));
            dtSource1.Columns.Add("barangay_name", typeof(System.String));
            dtSource1.Columns.Add("municipality_code", typeof(System.String));
            dtSource1.Columns.Add("municipality_name", typeof(System.String));
            dtSource1.Columns.Add("province_code", typeof(System.String));
            dtSource1.Columns.Add("province_name", typeof(System.String));

            DataRow[] rows = dataListGrid.Select(searchExpression);
            dtSource1.Clear();
            if (rows.Length > 0)
            {
                foreach (DataRow row in rows)
                {
                    dtSource1.ImportRow(row);
                }
            }

            gv_dataListGrid.DataSource = dtSource1;
            gv_dataListGrid.DataBind();
            tbx_search.Attributes["onfocus"] = "var value = this.value; this.value = ''; this.value = value; onfocus = null;";
            tbx_search.Focus();
        }

        //**********************************************************************************
        //  BEGIN - AEC- 09/12/2018 - Bind Municipality Dropdownlist for selected Province  
        //*********************************************************************************
        protected void ddl_province_SelectedIndexChanged(object sender, EventArgs e)
        {
            RetrieveBindingCityMuni();
        }

        //**************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Define Property for Sort Direction  
        //*************************************************************************
        public SortDirection SortDirectionVal
        {
            get
            {
                if (ViewState["dirState"] == null)
                {
                    ViewState["dirState"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["dirState"];
            }

            set
            {
                ViewState["dirState"] = value;
            }
        }




    }
}