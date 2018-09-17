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
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRIS_eRSP
{
    public partial class _default : System.Web.UI.Page
    {
        //********************************************************************
        //  BEGIN - JMTJR- 09/03/2018 - Data Place holder creation 
        //********************************************************************
        DataTable dtMenuSource
        {
            get
            {
                if ((DataTable)ViewState["dtMenuSource"] == null) return null;
                return (DataTable)ViewState["dtMenuSource"];
            }
            set
            {
                ViewState["dtMenuSource"] = value;
            }
        }
        //********************************************************************
        //  BEGIN - JMTJR- 09/03/2018 - Menu List Variable Initialization 
        //********************************************************************
        public class page_menus {
            public int id;
            public string menu_name;
            public string menu_id_link;
            public string page_name;
            public string page_title;
            public string menu_icon;
        }
        public List<page_menus> menus = new List<page_menus>();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack){
                inisialize();
            }
        }

        protected void inisialize()
        {
            dtMenuSource = CommonDB.RetrieveData("sp_menus_tbl_list", "module_id", 1);
            this.DropDownList1.DataSource = dtMenuSource;
            DropDownList1.DataTextField = "menu_name";
            DropDownList1.DataValueField = "page_title";
            DropDownList1.DataBind();
            DataRow[] MenuRows = dtMenuSource.Select();
            foreach (DataRow row in MenuRows)
            {
                page_menus getMenusFromDB = new page_menus();
                getMenusFromDB.id = Convert.ToInt32(row["id"]);
                getMenusFromDB.menu_name = row["menu_name"].ToString();
                getMenusFromDB.menu_icon = row["menu_icon"].ToString();
                getMenusFromDB.page_name = row["url_name"].ToString();
                getMenusFromDB.page_title = row["page_title"].ToString();
                menus.Add(getMenusFromDB);
            }
        }
    }
}