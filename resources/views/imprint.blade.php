<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>LinuxScript.de</title>

    @vite(['resources/css/app.scss', 'resources/js/app.js'])

    <link rel="icon" type="image/x-icon" href="{{ asset('img/command-line.png') }}">
</head>
<body>
<div class="wrapper">
    <div class="container">
        <div class="header-wrapper">
            <div class="header" onclick="window.location.href='{{ URL::to('/') }}'">
                <div class="headIcon">
                    <img class="logo" src="{{ asset('img/gnu-bash.svg') }}">
                </div>
                <div class="headline">
                    <div class="height-auto">LinuxScript.de</div>
                </div>
            </div>
        </div>

        <div class="col" style="gap: 1rem">
            <h1>Impressum</h1>

            <h2>Angaben gem&auml;&szlig; &sect; 5 TMG</h2>
            <p>Malte Werkhausen<br/>
                Charlottenstr. 92<br/>
                45289 Essen</p>

            <h2>Kontakt</h2>
            <p>Telefon: <b>auf Anfrage</b><br/>
                E-Mail: privacy@malte.id</p>

            <h2>Redaktionell verantwortlich</h2>
            <p>Malte Werkhausen</p>
        </div>

    </div>
</div>

@include('misc.footer')

</body>
</html>
