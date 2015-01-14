﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data.SqlServerCe;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace TheVulnBank.Controllers
{
    public class LoginController : BaseController
    {
        //
        // GET: /Login/
        [HttpGet]
        public ActionResult Index()
        {
            TempData.Add("Message", "GET");
            return View();
        }

        //
        // POST: /Login/
        [HttpPost]
        public ActionResult Index(string username, string password)
        {
            //TempData.Add("Message", "POST");
            UserRepository userRepository = new UserRepository(new SqlCeConnection(ConfigurationManager.ConnectionStrings["TheVulnBankDBContext"].ConnectionString));
            if (userRepository.UserExists(username)) 
            {
                if (userRepository.LoginUser(username, password)) 
                {
                    User user = userRepository.GetUser(username);

                    TempData.Add("Message", "Logged in: " + user.Username);
                    Session["Authorized"] = true;

                    HttpCookie authCookie = new HttpCookie("Authorized");
                    authCookie.Value = true.ToString();
                    authCookie.Expires = DateTime.Now.AddHours(8);
                    Response.SetCookie(authCookie);

                    HttpCookie userIdCookie = new HttpCookie("UserId");
                    userIdCookie.Value = user.Id.ToString();
                    userIdCookie.Expires = DateTime.Now.AddHours(8);
                    Response.SetCookie(userIdCookie);

                    return View();
                }
                else 
                {
                    TempData.Add("Message", "Password does not match");

                    HttpCookie cookie = new HttpCookie("Authorized");
                    cookie.Value = false.ToString();
                    cookie.Expires = DateTime.Now.AddHours(8);
                    Response.SetCookie(cookie);

                    return View();
                }
            }
            else 
            {
                TempData.Add("Message", "User does not exist");

                HttpCookie cookie = new HttpCookie("Authorized");
                cookie.Value = false.ToString();
                cookie.Expires = DateTime.Now.AddHours(8);
                Response.SetCookie(cookie);

                return View();
            }
        }

    }

    public class User
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
    }

    public class UserRepository
    {

        private SqlCeConnection connection;

        public UserRepository(SqlCeConnection connection) 
        {
            this.connection = connection;
        }

        public bool UserExists(string username)
        {
            bool result = false;
            //using(this.connection) 
            {
                SqlCeCommand command = new SqlCeCommand("SELECT Id FROM Users WHERE Username='" + username + "';", this.connection);
                this.connection.Open();
                SqlCeDataReader reader = command.ExecuteReader();
                result = reader.Read();
                reader.Close();
                this.connection.Close();
            }
            return result;
        }

        public bool LoginUser(string username, string password)
        {
            bool result = false;
            //using (this.connection)
            {
                SqlCeCommand command = new SqlCeCommand("SELECT Id FROM Users WHERE Username='" + username + "' AND Password='" + CalculateMD5Hash(password) + "';", this.connection);
                this.connection.Open();
                SqlCeDataReader reader = command.ExecuteReader();
                result = reader.Read();
                reader.Close();
                this.connection.Close();
            }
            return result;
        }

        public User GetUser(string username)
        {
            User result = new User();
            //using (this.connection)
            {
                SqlCeCommand command = new SqlCeCommand("SELECT Id, Username, Password FROM Users WHERE Username='" + username + "';", this.connection);
                this.connection.Open();
                SqlCeDataReader reader = command.ExecuteReader();
                if (reader.Read()) {
                    result = new User
                    {
                        Id = reader.GetInt32(0),
                        Username = reader.GetString(1)
                    };
                }
                reader.Close();
                this.connection.Close();
            }
            return result;
        }

        // http://blogs.msdn.com/b/csharpfaq/archive/2006/10/09/how-do-i-calculate-a-md5-hash-from-a-string_3f00_.aspx
        private string CalculateMD5Hash(string input)
        {
            // step 1, calculate MD5 hash from input
            MD5 md5 = System.Security.Cryptography.MD5.Create();
            byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
            byte[] hash = md5.ComputeHash(inputBytes);

            // step 2, convert byte array to hex string
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("X2"));
            }
            return sb.ToString();
        }

    }
}
