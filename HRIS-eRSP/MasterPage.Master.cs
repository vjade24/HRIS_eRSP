using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using HRIS_Common;
using System.Net;

namespace HRIS_eRSP
{
    public partial class MasterPage : System.Web.UI.MasterPage
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
        public class page_menus
        {
            public int id;
            public string menu_name;
            public int menu_id_link;
            public string url_name;
            public string page_title;
            public string menu_icon;
            public int menu_level;
        }
        public List<page_menus> menus = new List<page_menus>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                inisialize();
            }
        }

        protected void inisialize()
        {
            dtMenuSource = CommonDB.RetrieveData("sp_menus_tbl_list","module_id",1);
            menus.Clear();
            DataRow[] MenuRows = dtMenuSource.Select();
            foreach (DataRow row in MenuRows)
            {
                page_menus getMenusFromDB = new page_menus();
                getMenusFromDB.id = Convert.ToInt32(row["id"]);
                getMenusFromDB.menu_name = row["menu_name"].ToString();
                getMenusFromDB.menu_icon = WebUtility.HtmlDecode(row["menu_icon"].ToString());
                getMenusFromDB.url_name = row["url_name"].ToString();
                getMenusFromDB.page_title = row["page_title"].ToString();
                getMenusFromDB.menu_id_link = Convert.ToInt32(row["menu_id_link"]);
                getMenusFromDB.menu_level = Convert.ToInt32(row["menu_level"]);
                menus.Add(getMenusFromDB);
            }
        }
    }
}