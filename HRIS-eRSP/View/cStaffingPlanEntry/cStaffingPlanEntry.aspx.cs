using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRIS_Common;

namespace HRIS_eRSP.View.cStaffingPlanEntry
{
    public partial class cStaffingPlanEntry : System.Web.UI.Page
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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializePage();
               
            }
        }
        //*************************************************************************
        //  BEGIN - AEC- 09/09/2018 - Retrieve back end data and load to GridView
        //*************************************************************************
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
        //  BEGIN - AEC- 09/09/2018 - Initialized datasource fields/columns
        //*************************************************************************
        private void InitializeTable()
        {
            dtSource = new DataTable();
            dtSource.Columns.Add("barangay_code", typeof(System.String));
            dtSource.Columns.Add("barangay_name", typeof(System.String));
            dtSource.Columns.Add("municipality_code", typeof(System.String));
        }
        //**************************************************************************
        //  BEGIN - AEC- 09/12/2018 - GridView Change Page Number
        //**************************************************************************
        protected void gridviewbind_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gv_dataListGrid.PageIndex = e.NewPageIndex;
            CommonCode.GridViewBind(ref this.gv_dataListGrid, dataListGrid);
        }
        //**************************************************************************
        //  BEGIN - JOSEPH MT- 09/14/2018 - Change Field Sort mode  
        //**************************************************************************
        protected void gv_dataListGrid_Sorting(object sender, GridViewSortEventArgs e)
        {
            //string sortingDirection = string.Empty;
            //sortingDirection = GetCurrentSortDir();

            //if (sortingDirection == CONST_SORTASC)
            //{
            //    SortDirectionVal = SortDirection.Descending;
            //    sortingDirection = CONST_SORTDESC;
            //}
            //else
            //{
            //    SortDirectionVal = SortDirection.Ascending;
            //    sortingDirection = CONST_SORTASC;
            //}
            //CommonDB.Sort(gv_personnelinfolist, dataListGrid, e.SortExpression, sortingDirection);
        }
    }
}