using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Wongnok_back.Model;

namespace Wongnok_back.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ValuesController : ControllerBase
    {
        // GET api/values
        [HttpGet]
        public ActionResult<IEnumerable<string>> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public ActionResult<string> Get(int id)
        {

            ConnectionCommon conn = new ConnectionCommon();

            List<RecipeModel> listData = new List<RecipeModel>();

            DataTable dt = conn.GetRecipeByID(id);
            foreach (DataRow row in dt.Rows)
            {
                listData.Add(new RecipeModel
                {
                    RecipeID = row["Recipe_ID"].ToString(),
                    MenuName = row["MenuName"].ToString(),
                    Ingredient = row["Ingredient"].ToString(),
                    Step = row["Step"].ToString(),
                    Times = row["Times"].ToString(),
                    Levels = row["Levels"].ToString(),
                    ImageRecipePath = row["ImageRecipe"].ToString(),
                    Rating = row["Rating"].ToString(),
                    UserOwner = row["USERID"].ToString(),

                });
            }



            return Ok(listData);
        }


        // GET api/values
        [HttpGet("Recipe")]
        public ActionResult<IEnumerable<string>> GetRecipe()
        {

            ConnectionCommon conn = new ConnectionCommon();

            List<RecipeModel> listData = new List<RecipeModel>();

            DataTable  dt =  conn.GetAllRecipe();
            foreach (DataRow row in  dt.Rows)
            {
                listData.Add(new RecipeModel
                {
                    RecipeID = row["Recipe_ID"].ToString(),
                    MenuName = row["MenuName"].ToString(),
                    Ingredient = row["Ingredient"].ToString(),
                    Step = row["Step"].ToString(),
                    Times = row["Times"].ToString(),
                    Levels = row["Levels"].ToString(),
                    ImageRecipePath = row["ImageRecipe"].ToString(),
                    Rating = row["Rating"].ToString(),
                    UserOwner = row["USERID"].ToString(),
                    Voter = row["Voter"].ToString(),

                });
            }

            

            return Ok(listData);
        }



        // GET api/values
        [HttpGet("Login")]
        public ActionResult<IEnumerable<string>> GetLogin(string username, string password)
        {

            ConnectionCommon conn = new ConnectionCommon();

            List<User> listData = new List<User>();


             DataTable dt = conn.GetUser(username, password);

            foreach (DataRow row in dt.Rows)
            {

                listData.Add(new User{


                     UerID = row["ID"].ToString(),
                        Uername = row["Uername"].ToString(),
                        FirstName = row["FirstName"].ToString(),
                        LastName = row["LastName"].ToString(),
                        Email = row["Email"].ToString(),
                        Password = row["Password"].ToString(),

                    });

            }


            return Ok(listData);
        }



        // POST api/values
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }



        // POST api/values
        [HttpPost("Register")]
        public string PostRegister([FromBody] User value)
        {

            String res = "";
            bool isSuccess = true;
            try  
            {
                ConnectionCommon conn = new ConnectionCommon();
                DataTable dt =  conn.Register(value.Uername, value.FirstName, value.LastName, value.Email, value.Password);

                foreach ( DataRow row in dt.Rows)
                {
                    res = row["Result"].ToString();
                }
            }
            catch (Exception ex)
            {
                res = "Fail";
                isSuccess = false;
            }
            return Newtonsoft.Json.JsonConvert.SerializeObject(new { success = isSuccess, message = res });
        }


        // POST api/values
        [HttpPost("AddRecipe")]
        public string PostAddRecipe([FromBody] RecipeModel value)
        {

            String res = "";
            bool isSuccess = true;
            try
            {

         
                ConnectionCommon conn = new ConnectionCommon();
                DataTable dt = conn.AddRecipe(value.MenuName, value.Ingredient, value.Step, value.Times, value.Levels, value.ImageRecipePath , value.UserOwner,value.RecipeID);

                foreach (DataRow row in dt.Rows)
                {
                    res = row["Result"].ToString();
                }
            }
            catch (Exception ex)
            {
                res = "Fail";
                isSuccess = false;
            }
            return Newtonsoft.Json.JsonConvert.SerializeObject(new { success = isSuccess, message = res });
        }

        // POST api/values
        [HttpPost("SetRating")]
        public string PostRating([FromBody] RecipeModel value)
        {

            String result = "";
            bool isSuccess = true;
            try
            {


                ConnectionCommon conn = new ConnectionCommon();
                 result = conn.updaterating(value.UserOwner, value.Rating, value.RecipeID);


            }
            catch (Exception ex)
            {
                result = "Fail";
                isSuccess = false;
            }
            return Newtonsoft.Json.JsonConvert.SerializeObject(new { success = isSuccess, message = result });
        }


        // PUT api/values/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/values/5
        [HttpDelete("{id}")]
        public void Delete(String id)
        {
            ConnectionCommon conn = new ConnectionCommon();
            conn.DelRecipeByID(id);
        }



    }
}
