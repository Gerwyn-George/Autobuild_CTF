<!DOCTYPE html>
<html lang="en"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
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
    left: 1100px;
  }

  .bottom{
        position:relative;
        text-align: center;
        top: 818px;
        left: 75px;
      }

   .info_box {
        position:relative;
        text-align: center;
        left: 50px;
   }

   .instruct {
        position:relative;
        text-align: center;
        left: 50px;
   }
  </style>

  </head>
  <body>

    <div class="container">
        <header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
          <a href="home.html" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
            <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
            <span class="fs-4">SITE_NAME</span>
          </a>

          <ul class="nav nav-pills">
            <li class="nav-item"><a href="home.html" class="nav-link" aria-current="page">Home</a></li>
            <li class="nav-item"><a href="about.html" class="nav-link">About</a></li>
            <li class="nav-item"><a href="time.html" class="nav-link">opening hours</a></li>
            <li class="nav-item"><a href="contact_us.html" class="nav-link">Contact Us</a></li>
            <li class="nav-item"><a href="login.php" class="nav-link active">Login</a></li>
          </ul>
        </header>
      </div>

    <h1 class="header">View user information</h1>


    <p class="instruct">Input username and password to view user information.</p><p>

    </p><div class="login_box">
        <form method="post" action="login.php">
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
if(isset($_POST['submit']))
{
        $servername = "localhost";
        $username = "admin_account";
        $password = "password";
        $database = "exploitable";

        $conn =  mysqli_connect($servername, $username, $password, $database);

        $lusername = $_REQUEST['username'];
        $lpassword = $_REQUEST['password'];


        if (!$conn){
                die("Connection failed: " . mysqli_connect_error());

        }
        try{
                $sql = "SELECT * FROM accounts WHERE username='${lusername}' AND password='${lpassword}'";
                $result = mysqli_query($conn, $sql);
                $queryresult = mysqli_num_rows($result);
                if($queryresult > 0){
                        while($row = mysqli_fetch_assoc($result))
                        {
                                echo '<p class="info_box"> Username: ', $row['username'], '</p>';
                                echo '<p class="info_box"> Firstname: ', $row['firstname'], '</p>';
                                echo '<p class="info_box"> Lastname: ', $row['lastname'], '</p>';
                                echo '<p class="info_box"> Admin: ', $row['is_admin'], '</p>';
                                echo '<p class="info_box"> Signature: ', $row['signature'], '</p>';
                                echo '<p class="info_box"> Password: ', $row['password'], '</p>';
                        }
                }
                else{
                        echo '<p class="info_box">No information found, please try again.</p>';
                }
        }
        catch(Exception $e) {
                echo '<p class="info_box"> Caught exception: ', $e->getMessage(), '</p>';
        }
}
?>
    <div class="bottom">
      <p>WEBSITE_CREATED_BY</p>
    </div>

</body>

</html>
