<#-- @ftlvariable name="_csrf" type="org.springframework.security.web.csrf.CsrfToken" -->
<#-- @ftlvariable name="createForm" type="net.davidog.model.UserCreateForm" -->
<#import "/spring.ftl" as spring>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Create a new user</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/mobile/base.css" rel="stylesheet">
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

    <div class="jumbotron">
        <h1>Create a new user</h1>

        <form role="form" name="createForm" action="" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" name="username" id="username" value="${createForm.username}" class="form-control" required autofocus/>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" name="password" id="password" class="form-control" required/>
            </div>
            <div class="form-group">
                <label for="passwordRepeated">Repeat password:</label>
                <input type="password" name="passwordRepeated" id="passwordRepeated" class="form-control" required/>
            </div>
            <div class="form-group">
                <label for="role">Role:</label>
                <select name="role" id="role" class="form-control" required>
                    <option <#if createForm.role == 'USER'>selected</#if>>USER</option>
                    <option <#if createForm.role == 'SAMPLE'>selected</#if>>SAMPLE</option>
                    <option <#if createForm.role == 'ADMIN'>selected</#if>>ADMIN</option>
                </select>
            </div>
            <button type="submit" class="btn btn-lg btn-primary" role="button">Save &raquo;</button>
        </form>

        <@spring.bind "createForm" />
        <#if spring.status.error>
        <ul>
            <#list spring.status.errorMessages as error>
                <li>${error}</li>
            </#list>
        </ul>
        </#if>

    </div>
</div>

<script type="application/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="application/javascript" src="/js/bootstrap.min.js"></script>
</body>
</html>