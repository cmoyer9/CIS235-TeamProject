<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html>
    <%--developed by Tanner Hainsworth and Charinda Moyer - 3/11/22--%>
<head>

    <%-- 
    code borrowed from https://www.youtube.com/watch?v=vnEc9OaOsbE&ab_channel=kudvenkat
    also here: https://stackoverflow.com/questions/9031779/change-all-image-sources-jquery
    and here: https://www.w3schools.com/howto/howto_js_tabs.asp
     
    --%>
    <title>My Lovely Dogs</title>
    <style type="text/css">
        body {
            /*img credit - https://www.reddit.com/r/wallpaper/comments/ge8t0/show_me_your_most_serene_awe_inspiring_mind/*/
            background: url(/images/serenity.jpg);
            background-repeat: no-repeat;
            background-size: cover;
            background-attachment: fixed;
            min-width: 600px;
            font-family: Arial;
        }

        main {
            justify-content: center;
            height: 100%;
            width: 100%;
        }
            
        .thumb {
            height: 73px;
            width: 73px;
            border: 3px solid grey;  
            border-radius: 50%;
        }
        #focusImg{
            float: left;
            height: 401px;
            width: 401px;
            border: 3px solid grey;
            border-radius: 20px;
            margin: 0 auto;
        }
        #gallery{
            float: none;
            width: 500px;
            height: 415px;
            justify-content: center;
            margin: 0 auto;
            padding: 25px 25px 5px 25px;
        }

        #underGallery{
            float: none;
            width: 500px;
            height: 150px;
            
            margin: 0 auto;
            padding: 25px;
        }

        #thumbs{
            width: 85px;
            float: right;
            margin: 0 auto;
        }

        #forbiddenText{
            margin: 0 auto;
            float:none;
            height: 7px;
            width: 50px;
            color: darkred;
            font-size:7px;
            opacity: 0;
        }
        #escape{
            float:none;
            height: 5px;
            width: 5px;
            color: white;
            font-size:1px;
            opacity: 0.3;
        }

        #AJAXLoad {
            margin: 25px;
            opacity: .9;
        }

        /* https://bytutorial.com/blogs/css3/how-to-create-blinking-background-color-and-text-using-css3-animation */
        @keyframes blinkingBackground{
        0%		{ background-color: darkred;}
        20%		{ background-color: black;}
        40%		{ background-color: black;}
        60%		{ background-color: black;}
        80%	    { background-color: darkred;}
        100%    { background-color: black;}
        }

        @keyframes blinkingThumb{
        0%		{ opacity: 1;}
        20%		{ opacity: 0;}
        40%		{ opacity: 0;}
        60%		{ opacity: 0;}
        80%	    { opacity: 1;}
        100%    { opacity: 0;}
        }

        @keyframes pulsatingFocus{
        0%		{ opacity: .4;}
        50%		{ opacity: 1;}
        100%    { opacity: .4;}
        }

        /* Style the tab */
        .tab {
            overflow: hidden;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
            opacity: .8;
            justify-content:center;
        }

        /* Style the buttons that are used to open the tab content */
        .tab button {
            background-color: inherit;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 14px 16px;
            transition: 0.3s;
        }

        /* Change background color of buttons on hover */
        .tab button:hover {
            background-color: #ddd;
        }

        /* Create an active/current tablink class */
        .tab button.active {
            background-color: #ccc;
        }

        /* Style the tab content */
        .tabcontent {
            float: left;
            display: none;
            padding: 6px 12px;
            -webkit-animation: fadeEffect 1s;
            animation: fadeEffect 1s;
        }   
        /* Fade in tabs */
        @-webkit-keyframes fadeEffect {
            from {opacity: 0;}
            to {opacity: 1;}
        }

        @keyframes fadeEffect {
            from {opacity: 0;}
            to {opacity: 1;}
        }



    </style>
    <script src="jquery-1.6.2.min.js"></script>
    <script>
        function dogsName(evt, viewName, dogImg) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(viewName).style.display = "block";
            evt.currentTarget.className += " active";
            $('#focusImg').attr('src', dogImg);
        }
    </script>
    <script>
        $(document).ready(function () {

            // page starts out normal, not evil
            var evil = false;

            $.ajaxSetup({ cache: false });

            $("#btnAJAXLoad").click(function () {
                $("#divAJAXLoad").load("dogLoversPoem.html" , function (responseTxt, statusTxt, xhr) {
                    if (statusTxt == "success")
                        alert("Dog lovers's poem loaded successfully!");
                    if (statusTxt == "error")
                        alert("Error: " + xhr.status + ": " + xhr.statusText);
                });
            }); // End btnAJAXLoad.click()

            function makeEvil() {
                // all images are replaced with evil versions, by changing the src property to match evil files
                $('img').each(function () {
                    if (!evil) {
                        var imgSrc = $(this).attr('src');
                        var addEvil = "evil";
                        var position = 7;
                        var newImgSrc = [imgSrc.slice(0, position), addEvil, imgSrc.slice(position)].join('');
                        $(this).attr('src', newImgSrc);
                    }

                }); // end each img function

                // borders become evil
                $('img').css('border', '3px solid red');
                // animate body background and the main image
                $('body').css('animation', 'blinkingBackground 1s infinite')
                    .css('background', 'black');
                $('#focusImg').css('animation', 'pulsatingFocus 2s infinite');

                // hide dog poem & name tabs(make invisible so page doesn't jump)
                $('#underGallery').css('visibility', 'hidden');
                $('.tab').css('visibility', 'hidden');
                $('.tabcontent').css('visibility', 'hidden');

                // set evil to true
                evil = true;
            }

            function unEvil() {
                // set everything back to how it should be
                $('body').css('animation', 'none')
                    .css('background', 'url(/images/serenity.jpg)')
                    .css('background-repeat', 'no-repeat')
                    .css('background-size', 'cover')
                    .css('background-attachment', 'fixed')
                    .css ('min-width', '600px');
                $('img').css('border', '3px solid grey')
                    .css('animation', 'none');
                $('#forbiddenText').css('animation', 'none');
                $('#underGallery').css('visibility', 'visible');
                $('.tab').css('visibility', 'visible');
                $('.tabcontent').css('visibility', 'visible');
                $('img').each(function () {
                    var src = $(this).attr('src');
                    var newSrc = src.replace('evil', '');
                    $(this).attr('src', newSrc);
                });
                evil = false;
            }

            function isItEvil() {
                //create string of all the src properties of every thumb image
                var uglySrcString = '';
                $('#thumbs img').each(function () {
                    uglySrcString += $(this).prop('src');
                });
                console.log(uglySrcString);

                // if any sources are evil, evil remains true
                if (uglySrcString.includes('evil')) {
                    evil = true;
                }
                // if none are evil, evil becomes false
                else if (!uglySrcString.includes('evil')) {
                    evil = false;
                }
            }

            // if you hover over the wrong place... bad things begin to happen...
            $('#forbiddenText').mouseover(makeEvil); //end mouseover

            $('#thumbs img').hover(
                function () {
                    // while hovering a regular image, it highlights what is being hovered over
                    // and sets the src of the focus image to that of the hovered image
                    if (!evil) {
                        var newSrc = $(this).attr('src');
                        $('#focusImg').attr('src', newSrc);
                        $(this).css({
                            "border-Color": "yellow"
                        });
                        // hide the Hi, I'm ____! text
                        $('.tabcontent').hide();
                        // this reveals something that is... off... about this page
                        $('#forbiddenText').css('animation', 'pulsatingFocus 2s infinite');
                    }
                    // while hovering an image while evil = true, it highlights what is being hovered over
                    // and sets the src of the focus image to that of the hovered evil image
                    else if (evil) {
                        var newSrc = $(this).attr('src');
                        $('#focusImg').attr('src', newSrc);
                        // stops animation if it's going
                        $(this).css('animation', 'none');
                    }

                },
                function () {
                    // when not hovered, back to the default border color
                    if (!evil) {
                        $(this).css({
                            "border-Color": "grey"
                        })
                    }
                    else if (evil) {
                        $(this).css({
                            "border-Color": "red"
                        })
                        // sets a random animation rate for blinkingThumb
                        var s = Math.random() * 2;
                        $(this).css("animation", "blinkingThumb " + s.toString() + "s infinite");
                    }
                }
            ); // end hover


            $('#thumbs img').click(function () {
                if (evil) {
                    // if the thumb image is evil, it will become normal when clicked
                    // which also makes the focusImg version of it normal
                    var src = $(this).attr('src');
                    var newSrc = src.replace('evil', '');
                    $(this).attr('src', newSrc);
                    $('#focusImg').attr('src', newSrc);
                }
                else if (!evil) {
                    // if everything was in evil mode, this makes sure things go back to normal
                    // once the thumbs are no longer evil
                    unEvil();
                    $(this).css('border-color', 'yellow');

                    // this just flashes the evil version of the focusImg for 60ms
                    // then back to normal, just as a teaser
                    var imgSrc = $('#focusImg').attr('src');
                    var addEvil = "evil";
                    var position = 7;
                    var newImgSrc = [imgSrc.slice(0, position), addEvil, imgSrc.slice(position)].join('');
                    $('#focusImg').attr('src', newImgSrc);
                    setTimeout(function () {
                        var src = $('#focusImg').attr('src');
                        var newSrc = src.replace('evil', '');
                        $(this).attr('src', newSrc);
                        $('#focusImg').attr('src', newSrc);
                    }, 60);
                }
                // checks if any of the current images are evil
                // once nothing is evil, one more click of a thumbnail takes things back to normal
                isItEvil();
            });

            // escape evil dog world when you hover the tiny div in the top left corner
            // a way to make everything go back to normal and fast
            $('#escape').hover(function () {
                if (evil) {
                    unEvil();
                }
            });
        });//end document ready
    </script>
</head>
<body>
    <div class="tab">
        <button class="tablinks" onclick="dogsName(event, 'Lucy', 'images/dog3.png')">Lucy</button>
        <button class="tablinks" onclick="dogsName(event, 'Max', 'images/dog2.png')">Max</button>
        <button class="tablinks" onclick="dogsName(event, 'Cooper', 'images/dog1.png')">Cooper</button>
        <button class="tablinks" onclick="dogsName(event, 'Luna', 'images/dog4.png')">Luna</button>
        <button class="tablinks" onclick="dogsName(event, 'Charlie', 'images/dog5.png')">Charlie</button>
    </div>

    <!-- Tab content -->
    <div id="Lucy" class="tabcontent">
        <p>Hi, I'm Lucy.</p>
    </div>
    <div id="Max" class="tabcontent">
        <p>Hi, I'm Max.</p>
    </div>
    <div id="Cooper" class="tabcontent">
        <p>Hi, I'm Cooper.</p>
    </div>
    <div id="Luna" class="tabcontent">
        <p>Hi, I'm Luna.</p>
        </div>
        <div id="Charlie" class="tabcontent">
            <p>Hi, I'm Charlie.</p>
        </div>
    
    <div id="escape">esc</div>
    <main>
        <div id ="gallery">
            <img id="focusImg" src="images/dog3.png"/>
            
            <div id="thumbs">
                <img class="thumb" src="images/dog3.png"/>
                <img class="thumb" src="images/dog2.png"/>
                <img class="thumb" src="images/dog1.png"/>
                <img class="thumb" src="images/dog4.png"/>
                <img class="thumb" src="images/dog5.png"/>
            </div>
            
        </div>
        <div id="forbiddenText">help me please</div> 
        
        <div id ="underGallery">
            
            
            <div id="AJAXLoad">
                <h2 style="color:aliceblue">Dog lovers's poem!</h2>
                <div id="divAJAXLoad" style="border-style: inherit">
                <button id="btnAJAXLoad" style="color:brown">Click me!</button>
                </div>
            </div>
        </div>

    </main>
</body>

</html>