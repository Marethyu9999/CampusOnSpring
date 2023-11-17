<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="msg" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Dashboard</title>
    <link rel="stylesheet" href="/assets/dashboard/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/dashboard/assets/css/styles.min.css">
</head>

<body>
<div class="container profile profile-view" id="profile"><nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">Dashboard</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="/home">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/myprofile">Profile</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/compose/1">Compose</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/register">Register</a>
            </li>
        </ul>
    </div>
</nav>
    <div class="row">
        <div class="col-md-12 alert-col relative">
            <div class="alert alert-info alert-dismissible absolue center" role="alert"><button class="btn-close" type="button" aria-label="Close" data-bs-dismiss="alert"></button><span>Profile save with success</span></div>
        </div>
    </div>
    <form>
        <div class="row profile-row">
            <div class="col-md-4 relative">
                <div class="avatar">
                    <div class="avatar-bg center" id="background-ava" style="background-image: url('data:image/png;base64, ${userEntity.base64Avatar}')"></div></div>
                    <input id="avatar-file" class="form-control form-control" type="file" name="avatar-file" onchange="previewImage()">
                    <input id="base64-image" type="hidden" style="display: none" name="base64-image">
            </div>
            <div class="col-md-8">
                <h2>${userEntity.username}'s Profile </h2>
                <hr>
                <div class="row">
                    <div class="col-sm-12 col-md-6">
                        <div class="form-group mb-3"><label class="form-label">Firstname </label><input class="form-control" type="text" name="firstname" value="${userEntity.firstName}"></div>
                    </div>
                    <div class="col-sm-12 col-md-6">
                        <div class="form-group mb-3"><label class="form-label">Lastname </label><input class="form-control" type="text" name="lastname" value="${userEntity.lastName}"></div>
                    </div>
                </div>
                <div class="form-group mb-3"><label class="form-label">Email </label><input class="form-control" type="email" autocomplete="off" name="email" value="${userEntity.email}"></div>
                <div class="row">
                    <div class="col-sm-12 col-md-6">
                        <div class="form-group mb-3"><label class="form-label">Social Link</label><input class="form-control" name="social" autocomplete="off"  value="${userEntity.social}"></div>
                    </div>
                    <div class="col-sm-12 col-md-6">
                        <div class="form-group mb-3"><label class="form-label">Position Name</label><input class="form-control" name="position" autocomplete="off" value="${userEntity.position}"></div>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-md-12 content-right"><button class="btn btn-primary form-btn" type="submit">SAVE </button><button class="btn btn-danger form-btn" type="button">DEACTIVATE</button></div>
                </div>
            </div>
        </div>
    </form>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div style="text-align: center;padding-bottom: 27px;">
                <h2 class="divider-style"><span style="width: 0px;padding: 0px;"></span></h2>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div>
                <h3>Drafts</h3>
                <hr class="mt-0">
            </div>
        </div>
        <div class="col-md-6">
            <div>
                <h3>(coming soon...)</h3>
                <hr class="mt-0">
            </div>
        </div>
        <div class="col-md-6">
            <c:forEach items="${draftEntitiesList}" var="draft">
            <a class="list-group-item list-group-item-action flex-column align-items-start" href="/compose/${draft.id}">
                <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">${draft.title}</h5><span class="badge rounded-pill align-self-center
        ${draft.editable ? 'bg-primary' : (draft.published ? 'bg-success' : 'bg-warning')}">
                        ${draft.editable ? 'Drafted' : (draft.published ? 'Published' : 'Queued')}
                </div>
                <p class="mb-1">${draft.previewContent}</p>
                <small class="text-muted">${draft.userEntity.firstName} ${draft.userEntity.lastName}</small>
            </a>
                <hr>
            </c:forEach>

        </div>
        <div class="col-md-6"></div>
    </div>
</div>
<div class="list-group"></div>
<script src="/assets/dashboard/assets/bootstrap/js/bootstrap.min.js"></script>

<script>


    function previewImage() {
            const input = document.getElementById('avatar-file');
            const backgroundDiv = document.getElementById('background-ava');

            const file = input.files[0];

            if (file) {
                const reader = new FileReader();

                reader.onload = function (e) {
                    const base64Image = e.target.result;
                    backgroundDiv.style.backgroundImage = `url('`+ base64Image + `')`;
                    document.getElementById('base64-image').value = base64Image;
                };

                reader.readAsDataURL(file);
            }
        }
</script>
</body>

</html>