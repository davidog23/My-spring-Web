<#-- @ftlvariable name="users" type="java.util.List<net.davidog.model.User>" -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>List of Users</title>
</head>
<body>
<nav role="navigation">
    <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/user/create">Create a new user</a></li>
    </ul>
</nav>

<h1>List of Users</h1>

<table>
    <thead>
    <tr>
        <th>Username</th>
        <th>Role</th>
    </tr>
    </thead>
    <tbody>
    <#list users as user>
    <tr>
        <td><a href="/user/${user.id}">${user.username}</a></td>
        <td>${user.role}</td>
        <td> - <a href="/user/${user.id}/edit">Edit user</a></td>
    </tr>
    </#list>
    </tbody>
</table>
</body>
</html>