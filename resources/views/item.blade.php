<div class="item">
    <div class="title">
        {{ $title }}
    </div>
    <div class="cmd">
        <div class="height-auto">
            {{ $cmd }}
        </div>
        <div class="height-auto width-auto">
            <img onclick="copyTextToClipboard('{{ $cmd }}')" class="copy" src="{{ asset('img/copy.svg') }}">
        </div>
    </div>
</div>
