<#-- @ftlvariable name="_csrf" type="org.springframework.security.web.csrf.CsrfToken" -->
<#-- @ftlvariable name="currentUser" type="net.davidog.model.CurrentUser" -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Home page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script type="application/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script type="application/javascript" src="js/bootstrap.min.js"></script>

    <link href="css/base.css" rel="stylesheet">
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
                    <#if !currentUser??>
                        <li><a href="/login">Sign in</a></li>
                    </#if>
                    <#if currentUser??>
                        <li><a href="/user/${currentUser.id}">View myself</a></li>
                        <#if currentUser.role == "ADMIN" || currentUser.role == "SAMPLE">
                            <li><a href="/user/create">Create a new user</a></li>
                            <li><a href="/users">View all users</a></li>
                        </#if>
                    </#if>
                </ul>
                <#if currentUser??>
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="javascript:document.logoutForm.submit()" role="menuitem"> Log out</a>
                            <form hidden name="logoutForm" action="/logout" method="post">
                                <input hidden name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button hidden type="submit">Log out</button>
                            </form>
                        </li>
                    </ul>
                </#if>
            </div>
        </div>
    </nav>
</div>
</body>
</html>