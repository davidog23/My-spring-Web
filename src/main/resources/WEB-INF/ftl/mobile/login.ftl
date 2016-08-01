<#-- @ftlvariable name="_csrf" type="org.springframework.security.web.csrf.CsrfToken" -->
<#-- @ftlvariable name="error" type="java.util.Optional<String>" -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Sign in</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/login.css" rel="stylesheet">
    <link href="css/mobile/base.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <nav role="navigation" class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/">Home</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="/login">Sign in</a></li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </nav>

    <div class="container">

        <form role="form" action="/login" method="post" class="form-signin">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <h1 class="form-signin-heading">Please sign in</h1>
            <p>You can use davidolmos/123456 as sample</p>
            <div>
                <label for="username" class="sr-only">Username: </label>
                <input type="text" name="username" id="username" class="form-control" placeholder="Username" required autofocus/>
            </div>
            <div>
                <label for="password" class="sr-only">Password: </label>
                <input type="password" name="password" id="password" class="form-control" placeholder="Password" required/>
            </div>
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="remember-me" id="remember-me"/> Remember me
                </label>
            </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
        </form>

        <#if error.isPresent()>
        <p>The username or password you have entered is invalid, try again.</p>
        </#if>
    </div>
</div>
    <script type="application/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script type="application/javascript" src="js/bootstrap.min.js"></script>
</body>
</html>