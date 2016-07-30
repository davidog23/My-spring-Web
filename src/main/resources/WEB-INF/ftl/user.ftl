<#-- @ftlvariable name="user" type="net.davidog.model.User" -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>User details</title>
</head>
<body>
<nav role="navigation">
    <ul>
        <li><a href="/">Home</a></li>
    </ul>
</nav>

<h1>User details - <a href="/user/${user.id}/edit">Edit</a></h1>

<p>Username: ${user.username}</p>
<p>Role: ${user.role}</p>
</body>
</html>