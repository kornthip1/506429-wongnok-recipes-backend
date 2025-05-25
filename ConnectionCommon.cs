using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Wongnok_back
{
    public class ConnectionCommon
    {
        private string _DBconnString = @"Server=(localdb)\MSSQLLocalDB;Database=WongnokDB;User Id=admin;Password=admin;";
        SqlConnection objConn = null;
        public DataTable Register(String Uername, String FirstName , String LastName , String Email , String Pass)
        {
            SqlCommand sqlCmd = null;
            DataTable dt = null;

            try
            {

                sqlCmd = new SqlCommand();
                sqlCmd.CommandText = "spInsert_User";  //sp_Ref_Business_Architecture  //old





                objConn = new SqlConnection(_DBconnString);
                objConn.Open();

                sqlCmd.Connection = objConn;
                sqlCmd.CommandType = CommandType.StoredProcedure;

                //sqlCmd.Parameters.Add(new SqlParameter("@Uername", SqlDbType.VarChar));
                //sqlCmd.Parameters["@Uername"].Value = Uername;

                sqlCmd.Parameters.Add(new SqlParameter("@FirstName", SqlDbType.VarChar));
                sqlCmd.Parameters["@FirstName"].Value = FirstName;

                sqlCmd.Parameters.Add(new SqlParameter("@LastName", SqlDbType.VarChar));
                sqlCmd.Parameters["@LastName"].Value = LastName;

                sqlCmd.Parameters.Add(new SqlParameter("@Email", SqlDbType.VarChar));
                sqlCmd.Parameters["@Email"].Value = Email;

                sqlCmd.Parameters.Add(new SqlParameter("@Password", SqlDbType.VarChar));
                sqlCmd.Parameters["@Password"].Value = Pass;



                SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
                dt = new DataTable("tbl");
                da.Fill(dt);

                sqlCmd.Dispose();
                objConn.Close();

            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return dt;
        }

        public DataTable AddRecipe(
            String MenuName,
            String Ingredient,
            String Step,
            String Times,
            String Levels,
            String ImageRecipe,
            String UserID,
            String RecipID
            )
        {
            SqlCommand sqlCmd = null;
            DataTable dt = null;

            try
            {

                RecipID = null == RecipID ? " " : RecipID;
                UserID = null == UserID ? " " : UserID;

                sqlCmd = new SqlCommand();
                sqlCmd.CommandText = "spInsert_Recipe";  //sp_Ref_Business_Architecture  //old


                objConn = new SqlConnection(_DBconnString);
                objConn.Open();

                sqlCmd.Connection = objConn;
                sqlCmd.CommandType = CommandType.StoredProcedure;

                sqlCmd.Parameters.Add(new SqlParameter("@MenuName", SqlDbType.VarChar));
                sqlCmd.Parameters.Add(new SqlParameter("@Ingredient", SqlDbType.VarChar));
                sqlCmd.Parameters.Add(new SqlParameter("@Step", SqlDbType.VarChar));
                sqlCmd.Parameters.Add(new SqlParameter("@Times", SqlDbType.VarChar));
                sqlCmd.Parameters.Add(new SqlParameter("@Levels", SqlDbType.VarChar));
                sqlCmd.Parameters.Add(new SqlParameter("@ImageRecipe", SqlDbType.VarChar));
                sqlCmd.Parameters.Add(new SqlParameter("@USERID", SqlDbType.VarChar));
                sqlCmd.Parameters.Add(new SqlParameter("@RecipeID", SqlDbType.VarChar));


                sqlCmd.Parameters["@MenuName"].Value = MenuName;
                sqlCmd.Parameters["@Ingredient"].Value = Ingredient;
                sqlCmd.Parameters["@Step"].Value = Step;
                sqlCmd.Parameters["@Times"].Value = Times;
                sqlCmd.Parameters["@Levels"].Value = Levels;
                sqlCmd.Parameters["@ImageRecipe"].Value = ImageRecipe;
                sqlCmd.Parameters["@USERID"].Value = UserID;
                sqlCmd.Parameters["@RecipeID"].Value = RecipID;



                SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
                dt = new DataTable("tbl");
                da.Fill(dt);

                sqlCmd.Dispose();
                objConn.Close();

            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return dt;
        }


        public DataTable GetRecipeByID(int ID)
        {
            SqlCommand sqlCmd = null;
            DataTable dt = null;

            try
            {

                sqlCmd = new SqlCommand();
                sqlCmd.CommandText = "spSelect_RecipeByID";  //sp_Ref_Business_Architecture  //old



                objConn = new SqlConnection(_DBconnString);
                objConn.Open();

                sqlCmd.Connection = objConn;
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.Add(new SqlParameter("@UserID", SqlDbType.Int));
                sqlCmd.Parameters["@UserID"].Value = ID;

                SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
                dt = new DataTable("tbl");
                da.Fill(dt);

                sqlCmd.Dispose();
                objConn.Close();

            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return dt;
        }


        public DataTable DelRecipeByID(String ID)
        {
            SqlCommand sqlCmd = null;
            DataTable dt = null;

            try
            {

                sqlCmd = new SqlCommand();
                sqlCmd.CommandText = "spDelete_RecipeByID";  //sp_Ref_Business_Architecture  //old



                objConn = new SqlConnection(_DBconnString);
                objConn.Open();

                sqlCmd.Connection = objConn;
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.Add(new SqlParameter("@RecipeID", SqlDbType.VarChar));
                sqlCmd.Parameters["@RecipeID"].Value = ID;

                SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
                dt = new DataTable("tbl");
                da.Fill(dt);

                sqlCmd.Dispose();
                objConn.Close();

            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return dt;
        }


        public DataTable GetAllRecipe()
        {
            SqlCommand sqlCmd = null;
            DataTable dt = null;

            try
            {

                sqlCmd = new SqlCommand();
                sqlCmd.CommandText = "spSelect_Recipe";  //sp_Ref_Business_Architecture  //old



                objConn = new SqlConnection(_DBconnString);
                objConn.Open();

                sqlCmd.Connection = objConn;
                sqlCmd.CommandType = CommandType.StoredProcedure;


                SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
                dt = new DataTable("tbl");
                da.Fill(dt);

                sqlCmd.Dispose();
                objConn.Close();

            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return dt;
        }

        public DataTable GetUser( String username , String Password)
        {
            SqlCommand sqlCmd = null;
            DataTable dt = null;

            try
            {

                sqlCmd = new SqlCommand();
                sqlCmd.CommandText = "spChcek_Login";  //sp_Ref_Business_Architecture  //old



                objConn = new SqlConnection(_DBconnString);
                objConn.Open();

                sqlCmd.Connection = objConn;
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.VarChar));
                sqlCmd.Parameters.Add(new SqlParameter("@Password", SqlDbType.VarChar));
                sqlCmd.Parameters["@UserName"].Value = username;
                sqlCmd.Parameters["@Password"].Value = Password;


                SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
                dt = new DataTable("tbl");
                da.Fill(dt);

                sqlCmd.Dispose();
                objConn.Close();

            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return dt;
        }



        public String updaterating(string userID, string rating, string recipeID)
        {
            SqlCommand sqlCmd = null;
            DataTable dt = null;
            String result = "";
            try
            {

                sqlCmd = new SqlCommand();
                sqlCmd.CommandText = "spInsert_Transaction_Rating";  //sp_Ref_Business_Architecture  //old



                objConn = new SqlConnection(_DBconnString);
                objConn.Open();

                sqlCmd.Connection = objConn;
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.Add(new SqlParameter("@RecipeID", SqlDbType.VarChar));
                sqlCmd.Parameters["@RecipeID"].Value = recipeID;

                sqlCmd.Parameters.Add(new SqlParameter("@USERID", SqlDbType.VarChar));
                sqlCmd.Parameters["@USERID"].Value = userID;

                sqlCmd.Parameters.Add(new SqlParameter("@Score", SqlDbType.Int));
                sqlCmd.Parameters["@Score"].Value = int.Parse(rating);
                SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
                dt = new DataTable("tbl");
                da.Fill(dt);

                sqlCmd.Dispose();
                objConn.Close();

                foreach (DataRow row in dt.Rows)
                {
                    
                       result = row["Result"].ToString();
                }

            }
            catch (Exception ex)
            {
                ex.ToString();
            }

            return result;
        }
    }
}
