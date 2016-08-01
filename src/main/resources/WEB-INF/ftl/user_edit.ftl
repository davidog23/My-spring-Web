<#-- @ftlvariable name="_csrf" type="org.springframework.security.web.csrf.CsrfToken" -->
<#-- @ftlvariable name="currentUser" type="net.davidog.model.CurrentUser" -->
<#-- @ftlvariable name="editForm" type="net.davidog.model.UserCreateForm" -->
<#import "/spring.ftl" as spring>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Edit ${editForm.username}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/base.css" rel="stylesheet">
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
        <h1>Edit a existing user</h1>

        <form role="form" name="editForm" action="" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" name="username" id="username" value="${editForm.username}" class="form-control" required autofocus/>
            </div>
            <#if currentUser.role == 'ADMIN' || currentUser.role == 'SAMPLE'>
                <div class="form-group">
                    <label for="role">Role:</label>
                    <select name="role" id="role" class="form-control" required>
                        <option <#if editForm.role == 'USER'>selected</#if>>USER</option>
                        <option <#if editForm.role == 'SAMPLE'>selected</#if>>SAMPLE</option>
                        <option <#if editForm.role == 'ADMIN'>selected</#if>>ADMIN</option>
                    </select>
                </div>
            </#if>
            <#if currentUser.role != 'ADMIN'>
                <input type="hidden" name="role" id="role" value="${editForm.role}">
            </#if>
            <button type="submit" class="btn btn-lg btn-primary" role="button">Save &raquo;</button>
        </form>

        <@spring.bind "editForm" />
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