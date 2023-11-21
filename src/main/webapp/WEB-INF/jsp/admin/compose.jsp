<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="msg" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title><msg:message code="page.compose.title"/></title>
    <meta name="twitter:title" content="CampusFM - Klingt... anders!">
    <meta property="og:image" content="/assets/img/cropped-Logo-Tab-180x180.png">
    <meta name="description" content="Klingt... anders!
Das Uni-Radio der Uni-Duisburg-Essen.">
    <meta name="twitter:image" content="/assets/img/cropped-Logo-Tab-180x180.png">
    <meta name="twitter:description" content="Das Uni-Radio der Uni-Duisburg-Essen">
    <link rel="apple-touch-icon" type="image/png" sizes="180x180" href="/assets/img/cropped-Logo-Tab-180x180.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/assets/img/cropped-Logo-Tab-32x32.png">
    <link rel="icon" type="image/png" sizes="180x180" href="/assets/img/cropped-Logo-Tab-180x180.png">
    <link rel="stylesheet" href="/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800&amp;display=swap">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Abel&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Abhaya+Libre&amp;display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/assets/css/styles.min.css">

    <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/5/tinymce.min.js"></script>
    <script src="  https://cdn.tiny.cloud/1/no-api-key/tinymce/5/tinymce.min.js"  async></script>
</head>
<body>
<nav class="navbar navbar-light navbar-expand-lg fixed-top" id="mainNav">
    <div class="container">
        <button data-bs-toggle="collapse" data-bs-target="#navbarResponsive" class="navbar-toggler"
                aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <i class="fa fa-bars">

            </i>
        </button>
        <img src="/assets/img/Logo_CampusFM.png" style="width: 142px;filter: contrast(110%);" width="142" height="49">
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/"><msg:message code="navigator.label.home"/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/about"><msg:message code="navigator.label.about"/></a>
                </li>
<%--                <li class="nav-item">
                    <a class="nav-link" href="/events"><msg:message code="navigator.label.events"/></a>
                </li>--%>
                <li class="nav-item">
                    <a class="nav-link" href="/login"><msg:message code="navigator.label.login"/></a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<header class="masthead"
        style="background: url(&quot;/assets/img/banner.png&quot;) center / cover no-repeat;">
    <div class="overlay">

    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-10 col-lg-8 mx-auto position-relative">
                <div class="site-heading">
                    <h1><msg:message code="page.compose.biglabel"/></h1>
                    <span class="subheading"><msg:message code="page.compose.sublabel"/></span>
                </div>
            </div>
        </div>
    </div>
</header>


        <!-- PAGE MAIN CONTENT -->


        <div class="container">

            <div style="box-sizing: border-box;
    padding: 0;" method="post" id="postForm" enctype="multipart/form-data">
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>
                <div class="form-group mb-3"><label class="form-label">Title</label>
                    <input id="titleInput" class="form-control form-control" type="text" placeholder="title here..." value="${articleEntity.title}" name="title" autocomplete="off" required minlength="6" style="width: 620px;" /></div>
                <div>
                    <input type="file" id="avatarInput" accept="image/png" style="display: none" onchange="previewAvatar(this)">
                    <textarea type="text" name="content" id="tiny"> ${articleEntity.contents}</textarea></div>
                <div class="row" style="margin-top: 18px;margin-bottom: 18px;">
                    <div class="col-xxl-10" style="margin-bottom: 0px;width: 359.672px;">
                        <button class="btn btn-primary btn-sm" id="discardBtn" style="position: relative;background: rgb(31,31,31);">Discard</button>
                        <button class="btn btn-primary btn-sm" id="draftBtn" style="position: relative;background: rgb(31,31,31);">Draft</button>
                        <button class="btn btn-primary btn-sm" id="submitBtn" style="position: relative;background: rgb(31,31,31);">Submit</button>
                        <sec:authorize access="hasRole('ADMIN')">
                            ${notAuthor ? '<button class="btn btn-primary btn-sm" id="rejectArt" style="position: relative;background: rgb(31,31,31);">Reject Article</button>' : ''}
                        </sec:authorize>
                    </div>
                    <div class="col">
                        <div class="form-group mb-3" style="padding-left: 40px;"><label class="form-label">Category</label>
                            <input class="form-control form-control" type="text" id="categoryInput" placeholder="category (e.g. allgemein, angeschaut...)" value="${articleEntity.category}" name="category" autocomplete="off" required minlength="6" style="width: 429px;" />
                        </div>
                    </div>
                </div>
            </div>

            <div id="avatarPreview" style="width: 100px; height: 100px; border: 1px solid #ddd;"></div>
            <img id="existingAvatar" src="data:image/png;base64, ${articleEntity.base64preview}" alt="Existing Avatar" style="max-width: 100px; max-height: 100px; border: 1px solid #ddd; display: block;">
            <button type="button" onclick="openFileInput()">Select Thumbnail</button>

        </div>


        <!-- END PAGE MAIN CONTENT -->


<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <ul class="list-inline text-center">
                    <li class="list-inline-item">
                        <span class="fa-stack fa-lg">
                            <a href="https://twitter.com/Campus_FM">
                                <i class="fa fa-circle fa-stack-2x"></i>
                                <i class="fa fa-twitter fa-stack-1x fa-inverse"></i>
                            </a>
                        </span>
                    </li>
                    <li class="list-inline-item">
                        <a href="https://www.instagram.com/campusfmradio/?hl=de">
                            <span class="fa-stack fa-lg">
                                <i class="fa fa-circle fa-stack-2x"></i>
                                <i class="fa fa-instagram fa-stack-1x fa-inverse"></i>
                            </span>
                        </a>
                    </li>
                    <li class="list-inline-item"><a href="mailto:wort@campusfm.info">
                        <span class="fa-stack fa-lg">
                            <i class="fa fa-circle fa-stack-2x"></i>
                            <i class="fa fa-envelope fa-stack-1x fa-inverse">

                            </i></span></a></li>
                </ul>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 col-xl-11 col-xxl-12">
                <ul class="list-inline" style="font-size: 17px;font-family: Abel, sans-serif;">
                    <li class="list-inline-item me-4">
                        <a class="link-secondary" href="/imprint"><msg:message code="footer.label.imprint"/></a>
                    </li>
                    <li class="list-inline-item me-4">
                        <a class="link-secondary" href="/contact"><msg:message code="footer.label.contact"/></a>
                    </li>
                    <li class="list-inline-item">
                        <a class="link-secondary" href="/listen"><msg:message code="footer.label.listen"/></a>
                    </li>
                    <li class="list-inline-item" style="padding-left: 12px;padding-right: 12px;">
                        <a class="link-secondary" href="/contribute"><msg:message code="footer.label.contribute"/></a>
                    </li>
                    <li class="list-inline-item" style="padding-right: 12px;padding-left: 12px;">
                        <a class="link-secondary" href="/program"><msg:message code="footer.label.program"/></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-10 col-lg-8 mx-auto">
                <p class="text-muted copyright">Copyright&nbsp;©&nbsp;CampusFM 2023</p>
            </div>
        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script src="/assets/js/script.min.js"></script>


<script >
    window.addEventListener('load', function() {
        tinymce.init({
            selector: 'textarea#tiny',
            plugins: 'media',
            width: '100%',
            height: '600',
            menubar: 'insert',
            toolbar: 'undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | outdent indent',
            menubar: 'favs edit view insert format tools table help',
        });

        const path = window.location.pathname;

// Split the path by '/' and find the index of 'compose'
        const pathArray = path.split('/');
        const indexOfCompose = pathArray.indexOf('compose');

// Obtain the id from the path
        postId = indexOfCompose !== -1 ? pathArray[indexOfCompose + 1] : null;

        console.log(postId); // Output: The value of {id} in the URL or null if not found
    });

    $(document).on('click', '#submitBtn', function() {
        save();
        setTimeout(() => {
            setPublished(true);

        }, 900);
        alert('Article Submitted!');

        setTimeout(() => {
            window.location.href = "/article?a=" + postId;
        }, 1200);
    });

    $(document).on('click', '#rejectArt', function() {
        setPublished(false)
        alert("Article rejected and sent back to author!")
    });


    $(document).on('click', '#draftBtn', function() {
        save();
    });



    $(document).on('click', '#discardBtn', function() {
        console.log("Discarded");
        // get the form data
        var formData = {
            id: postId
        };

        // send the form data to the server
        $.ajax({
            type: 'DELETE',
            url: '/api/v1/article?article=' + postId,
            dataType: 'json',
            encode: true
        })
            .done(function(response) {
                // handle the server response
                if (response.status == 200) {
                    console.log(response.message);
                    alert(response.message);
                    // redirect to the URL received from the server
                    setTimeout(() => {
                        window.location.href = "/home";
                    }, 1200);
                } else {
                    console.log(response.message + response.status);
                    alert(response.message);
                    // display an error message to the user
                }
            });
    });

    function openFileInput() {
        document.getElementById('avatarInput').click();
    }

    // Function to preview the selected avatar image
    function previewAvatar(input) {
        var preview = document.getElementById('avatarPreview');
        var existingAvatar = document.getElementById('existingAvatar');
        // Hide existing avatar if it's visible
        existingAvatar.style.display = 'none';
        preview.innerHTML = ''; // Clear previous content

        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                var img = document.createElement("img");
                img.src = e.target.result;
                img.style.width = '100%';
                img.style.height = '100%';
                preview.appendChild(img);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    function save(){
        console.log("Drafted");
        // get the form data
        var formData = new FormData();
        formData.append('title', $('input[name=title]').val());
        formData.append('content', btoa(tinymce.activeEditor.getContent()));
        formData.append('category', $('input[name=category]').val());
        formData.append('article', postId);

        var avatarInput = document.getElementById('avatarInput');
        if (avatarInput.files && avatarInput.files[0]) {
            formData.append('previewImage', avatarInput.files[0]);
        }


        // send the form data to the server
        $.ajax({
            type: 'PATCH',
            url: '/api/v1/article',
            data: formData,
            processData: false,
            contentType: false,
            dataType: 'json',
        })
            .done(function(response) {
                // handle the server response
                if (response.status == 200) {
                    console.log(response.message);
                    alert(response.message);
                    // redirect to the URL received from the server
                } else {
                    console.log(response.message);
                    alert(response.message);
                    // display an error message to the user
                }
            });
    }

    function setPublished(boolean) {
        // send the form data to the server
        $.ajax({
            type: 'POST',
            url: '/api/v1/article?article=' + postId + '&pub=' + boolean,
            dataType: 'json',
            encode: true
        })
            .done(function(response) {
                // handle the server response
                if (response.status == 200) {
                    console.log(response.message);
                    alert(response.message);
                    // redirect to the URL received from the server
                    setTimeout(() => {
                        window.location.href = '/' + postId;
                    }, 4000);
                } else {
                    console.log(response.message);
                    alert(response.message);
                    // display an error message to the user
                }
            });
    }


</script>

</body>
</html>