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

        @include('item', [
                'title' => 'Installieren des MySQL Servers (MariaDB) unter Debian 11',
                'cmd' => 'bash <(wget -qO - linuxscript.de/install-mariadb)'])
        @include('item', [
                'title' => 'Autostart des Raspberry PI bearbeiten, sodass Chromium im Kiosk-Modus geöffnet wird.',
                'cmd' => 'bash <(wget -qO - linuxscript.de/open-browser-at-boot)'])
        @include('item', [
                'title' => 'Installieren von NodeJS unter Debian 11',
                'cmd' => 'bash <(wget -qO - linuxscript.de/install-nodejs)'])
        @include('item', [
                'title' => 'Installieren des SignalK Servers unter Debian 11',
                'cmd' => 'bash <(wget -qO - linuxscript.de/install-signalk)'])
        @include('item', [
                'title' => 'Setzen des Splash Screen vom Raspberry PI',
                'cmd' => 'bash <(wget -qO - linuxscript.de/set-splash-screen)'])
        @include('item', [
                'title' => 'Versuche Benutzerwechsel mit sudo zum root-Benutzer',
                'cmd' => 'bash <(wget -qO - linuxscript.de/use-root)'])
        @include('item', [
                        'title' => 'MyShip-Toolkit',
                        'cmd' => 'bash <(wget -qO - linuxscript.de/myship)'])

        <div class="feedback-wrapper">
            <div class="feedback-container">
                <div class="feedback-col" style="align-items: flex-end">
                    <img src="{{ asset('img/feedback.svg') }}" class="feedback-img">
                </div>
                <div class="feedback-col">
                    <div class="feedback-headline">
                        Nicht das richtige Script dabei?
                    </div>
                    <div>
                        <div>
                            Über dein Feedback freue ich mich sehr!
                        </div>
                        <div>
                            <a class="feedback-email" href="mailto:feedback@linuxscript.de">feedback@linuxscript.de</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

@include('misc.footer')

<script>
    function fallbackCopyTextToClipboard(text) {
        var textArea = document.createElement("textarea");
        textArea.value = text;

        // Avoid scrolling to bottom
        textArea.style.top = "0";
        textArea.style.left = "0";
        textArea.style.position = "fixed";

        document.body.appendChild(textArea);
        textArea.focus();
        textArea.select();

        try {
            var successful = document.execCommand("copy");
            var msg = successful ? "successful" : "unsuccessful";
        } catch (err) {
            //
        }

        document.body.removeChild(textArea);
    }

    function copyTextToClipboard(text) {
        if (!navigator.clipboard) {
            fallbackCopyTextToClipboard(text);
            return;
        }
        navigator.clipboard.writeText(text).then();
    }
</script>

</body>
</html>
