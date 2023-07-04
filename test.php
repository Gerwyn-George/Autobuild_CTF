<?php
    try
    {
            $lEnableHTMLControls = FALSE;
        $lFormMethod = "GET";
            $lEnableJavaScriptValidation = TRUE;
            $lEncodeOutput = FALSE;

            $lFromSubmitted = FALSE;
                if (isset($_POST["submit"]) || isset($_REQUEST["submit"]))
                {
                    $lFromSubmitted = TRUE;
                }

                if ($lFromSubmitted)
                {
                    $luserInfoSubmitButton = $_REQUEST["submit"];
                        $lusername = $_REQUEST["username"];
                        $lpassword = $_REQUEST["password"];
                }
    }
   catch (Exception $e)
        {
        echo $CustomErrorHandler->FormatError($e);
        }
?>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>login</title>
    <link href="bootstrap/dist/css/bootstrap.css" rel="stylesheet">
  <style>
  .header {
    position: relative;
    left: 65px;
    padding-bottom: 40px;
    text-align: center;
  }

  .login_box {
    background-color: white;
    position: relative;
    left: 1125px;
  }

  .bottom{
        position:relative;
        text-align: center;
        top: 818px;
        left: 75px;
      }
  </style>

  </head>
  <body>

    <div class="container">
        <header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
          <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
            <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
            <span class="fs-4">Hogwarts</span>
          </a>

          <ul class="nav nav-pills">
            <li class="nav-item"><a href="home.html" class="nav-link" aria-current="page">Home</a></li>
            <li class="nav-item"><a href="About.html" class="nav-link">About</a></li>
            <li class="nav-item"><a href="opening hours.html" class="nav-link">opening hours</a></li>
            <li class="nav-item"><a href="Contact_Us.html" class="nav-link">Contact Us</a></li>
            <li class="nav-item"><a href="Login.html" class="nav-link active">Login</a></li>
          </ul>
        </header>
      </div>

    <h1 class="header">Login Page</h1>

    <div class="login_box">
        <form method="post" action="test.php">
            <div class="mb-3" style="width:450px;">
                <label for="exampleInputEmail1" class="form-label">Username</label>
                <input type="text" name="username" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
            </div>
            <div class="mb-3" style="width:450px;">
                <label for="exampleInputPassword1" class="form-label">Password</label>
                <input type="password" name="password" class="form-control" id="exampleInputPassword1">
            </div>
            <button type="submit" name="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>


<?php

    $servername = "localhost";
    $username = "gerwyn";
    $password = "";
    $database = "exploitable";

if(isset($_POST['submit']))
{
        echo "test";

        $conn = mysqli_connect($servername, $username, $password,$database);

        if (!$conn){
           die("connection failed:" . mysqli_connect_error());
        }


        try {

        $sql = "SELECT * FROM accounts WHERE username = '{$lusername}' AND password = '{$lpassword}'";
        $result = mysqli_query($conn, $sql);

        if (mysqli_num_rows($result) > 0) {
                while($row = mysqli_fetch_assoc($result)) {
                        echo $row["password"];
                        echo $row["username"];
                        echo $row["is_admin"];
                        echo $row["firstname"];
                        echo $row["lastname"];
                        echo $row["signature"];

        }
        }
        }
        catch (Exception $e)
        {
                echo 'Caught exception: ', $e->getMessage(), "\n";
        }

}
?>

    <div class="bottom">
      <p>This site was created by Dobby the house elf. - 2023</p>
    </div>

  </body>
</html>
