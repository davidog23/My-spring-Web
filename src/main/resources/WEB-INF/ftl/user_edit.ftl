<#-- @ftlvariable name="_csrf" type="org.springframework.security.web.csrf.CsrfToken" -->
<#-- @ftlvariable name="currentUser" type="net.davidog.model.CurrentUser" -->
<#-- @ftlvariable name="editForm" type="net.davidog.model.UserCreateForm" -->
<#import "/spring.ftl" as spring>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Edit ${editForm.username}</title>
</head>
<body>
<h1>Edit a existing user</h1>

<form role="form" name="editForm" action="" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

    <div>
        <label for="username">Username</label>
        <input type="text" name="username" id="username" value="${editForm.username}" required autofocus/>
    </div>
    <#if currentUser.role == 'ADMIN'>
        <div>
            <label for="role">Role</label>
            <select name="role" id="role" required>
                <option <#if editForm.role == 'USER'>selected</#if>>USER</option>
                <option <#if editForm.role == 'SAMPLE'>selected</#if>>SAMPLE</option>
                <option <#if editForm.role == 'ADMIN'>selected</#if>>ADMIN</option>
            </select>
        </div>
    </#if>
    <#if currentUser.role != 'ADMIN'>
        <input type="hidden" name="role" id="role" value="${editForm.role}">
    </#if>
    <button type="submit">Save</button>
</form>

<@spring.bind "editForm" />
<#if spring.status.error>
<ul>
    <#list spring.status.errorMessages as error>
        <li>${error}</li>
    </#list>
</ul>
</#if>
</body>
</html>