using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRIS_Common;

namespace HRIS_eRSP.View.cPersonnelInfo
{
    public partial class cPersonnelInfo : System.Web.UI.Page
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
        DataTable barangayslist
        {
            get
            {
                if ((DataTable)ViewState["barangayslist"] == null) return null;
                return (DataTable)ViewState["barangayslist"];
            }
            set
            {
                ViewState["barangayslist"] = value;
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
            Session["empl_id"] = "empl_id";
            RetrieveDataListGrid();
        }

        //*************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Retrieve back end data and load to GridView
        //*************************************************************************
        private void RetrieveDataListGrid()
        {
            dataListGrid = CommonDB.RetrieveData("sp_personnelnames_tbl_list");
            CommonCode.GridViewBind(ref this.gv_personnelinfolist, dataListGrid);

        }
        //**************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Edit Row selection that will trigger edit page 
        //**************************************************************************
        protected void editRow_Command(object sender, CommandEventArgs e)
        {

        }

        //***************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Triggers Delete Confirmation Pop-up Dialog Box
        //***************************************************************************
        protected void deleteRow_Command(object sender, CommandEventArgs e)
        {
            string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
            string brgcode = commandArgs[0];
            string brgname = commandArgs[1];

            deleteRec1.Text = "Are you sure to delete this Employee = (" + brgcode.Trim() + ") - " + brgname.Trim() + " ?";
            lnkBtnYes.CommandArgument = brgcode;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalDelete();", true);
        }

        //**************************************************************************
        //  BEGIN - JOSEPH MT- 09/14/2018 - GridView Change Page Number
        //**************************************************************************
        protected void gridviewbind_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gv_personnelinfolist.PageIndex = e.NewPageIndex;
            CommonCode.GridViewBind(ref this.gv_personnelinfolist, dataListGrid);
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
        //  BEGIN - JOSEPH MT- 09/14/2018 - Change Field Sort mode  
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
            CommonDB.Sort(gv_personnelinfolist, dataListGrid, e.SortExpression, sortingDirection);

        }
        //**********************************************************************************
        //  BEGIN - AEC- 09/12/2018 - Change on Page Size (no. of row per page) on Gridview  
        //*********************************************************************************
        protected void DropDownListID_TextChanged(object sender, EventArgs e)
        {
            if (DropDownListID.SelectedItem.Text == "ALL")
            {
                gv_personnelinfolist.PageSize = gv_personnelinfolist.PageCount;
            }
            else
            {
                gv_personnelinfolist.PageSize = Convert.ToInt32(DropDownListID.SelectedItem.Value);
            }
            CommonCode.GridViewBind(ref this.gv_personnelinfolist, dataListGrid);
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

        protected void txt_search_TextChanged(object sender, EventArgs e)
        {
            string searchExpression = "empl_id LIKE '%" + txt_search.Text.Trim() + "%' OR last_name LIKE '%" + txt_search.Text.Trim() + "%' OR first_name LIKE '%" + txt_search.Text.Trim() + "%' OR middle_name LIKE '%" + txt_search.Text.Trim() + "%' OR suffix_name LIKE '%" + txt_search.Text.Trim() + "%'";

            DataTable dtSource1 = new DataTable();
            dtSource1.Columns.Add("empl_id", typeof(System.String));
            dtSource1.Columns.Add("last_name", typeof(System.String));
            dtSource1.Columns.Add("first_name", typeof(System.String));
            dtSource1.Columns.Add("middle_name", typeof(System.String));
            dtSource1.Columns.Add("suffix_name", typeof(System.String));

            DataRow[] rows = dataListGrid.Select(searchExpression);
            dtSource1.Clear();
            if (rows.Length > 0)
            {
                foreach (DataRow row in rows)
                {
                    dtSource1.ImportRow(row);
                }
            }

            gv_personnelinfolist.DataSource = dtSource1;
            gv_personnelinfolist.DataBind();
            UpdatePanel3.Update();
            txt_search.Attributes["onfocus"] = "var value = this.value; this.value = ''; this.value = value; onfocus = null;";
            txt_search.Focus();
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

        protected void ddl_province_SelectedIndexChanged(object sender, EventArgs e)
        {
            RetrieveBindingCityMuni();
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
            tbx_empl_id.Text = "";
            tbx_barangayname.Text = "";

            ddl_province.SelectedIndex = 0;
            ddl_municity.SelectedIndex = 0;
            tbx_empl_id.ReadOnly = false;
            tbx_empl_id.Focus();
        }

        //*************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Initialized datasource fields/columns
        //*************************************************************************
        private void InitializeTable()
        {
            dtSource = new DataTable();
            dtSource.Columns.Add("empl_id", typeof(System.String));
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
            string[] col = new string[] { "empl_id" };
            dtSource = CommonDB.AddPrimaryKeys(dtSource, col);
        }
        //*************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Add new row to datatable object
        //*************************************************************************
        private void AddNewRow()
        {
            DataRow nrow = dtSource.NewRow();
            nrow["empl_id"] = string.Empty;
            nrow["action"] = 1;
            nrow["retrieve"] = false;
            dtSource.Rows.Add(nrow);

            int dtRowCont = dataListGrid.Rows.Count - 1;
            string lastCode = "000";

            if (dtRowCont > 0)
            {
                DataRow lastRow = dataListGrid.Rows[dtRowCont];
                lastCode = lastRow["empl_id"].ToString();
            }

            int lastCodeInt = int.Parse(lastCode) + 1;
            string nextCode = lastCodeInt.ToString();
            nextCode = nextCode.PadLeft(3, '0');

            tbx_empl_id.Text = nextCode;
        }

        //*************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Delete Data to back-end Database
        //*************************************************************************
        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            string svalues = e.CommandArgument.ToString();
            string deleteExpression = "empl_id = '" + svalues + "'";
            //CommonDB.DeleteBackEndData("barangays_tbl", "WHERE " + deleteExpression);
            DataRow[] row2Delete = dataListGrid.Select(deleteExpression);
            dataListGrid.Rows.Remove(row2Delete[0]);
            dataListGrid.AcceptChanges();
            CommonCode.GridViewBind(ref this.gv_personnelinfolist, dataListGrid);


            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "closeModalDelete();", true);
            personnelnames_panel.Update();
        }

    }
}