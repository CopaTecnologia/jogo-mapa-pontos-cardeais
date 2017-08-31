---
---

$ = (selector) -> document.querySelectorAll selector
_ = (nodes, fn, callback) ->
    if fn and callback
        Array.prototype[fn].call nodes, callback
    else
        Array.prototype.slice.call nodes

app =

    init: ->
        overlay = $('.overlay')[0]
        overlay.classList.add 'off'
        @dialog = $('#dialogo')[0]
        @menu = $('#dialogo menu')[0]
        _ @menu.querySelectorAll('[data-direcao]'), 'forEach', (a) ->
            a.addEventListener 'click', ->
                app.responder a.getAttribute 'data-direcao'
        @dialog.querySelector('.fechar').addEventListener 'click', (e) ->
            e.preventDefault()
            app.closeDialog()
        _ $('#mapa a'), 'forEach', (local) ->
            local.addEventListener 'click', ->
                app.perguntar {
                    id: local.id
                    done: local.classList.contains 'inativo'
                    name: local.getAttribute 'data-nome'
                    dir: local.getAttribute 'data-direcao'
                }
        $('#mapa')[0].addEventListener 'click', (e) ->
            if e.target is overlay
                overlay.classList.remove 'off'
                setTimeout (->
                    overlay.classList.add 'off'
                    return
                    ), 2000

    perguntar: (local) ->
        @local = local
        if @local.done
            @alert 'Parabéns!', 'Este local já foi descoberto.'
            return false
        if @local.dir is 'ref'
            @alert @local.name, 'Este é o ponto de referência'
            return false
        @alert local.name, 'Em qual direção fica este local?', true
    
    responder: (resposta) ->
        if resposta is @local.dir
            @alert 'Parabéns!', 'Você acertou. ' + @local.name + ' fica na direção ' + @local.dir + '.'
            $('#' + @local.id)[0].classList.add 'inativo'
        else
            @alert 'Ah não!', 'Não é a resposta certa...'
            setTimeout (->
                app.perguntar app.local
                return
                ), 2000

    alert: (title, msg, controls) ->
        if controls
            @menu.style.display = 'block'
        else
            @menu.style.display = 'none'
        @dialog.querySelector('.title').textContent = title
        @dialog.querySelector('.msg').textContent = msg
        @dialog.classList.add 'on'
    
    closeDialog: ->
        @alert()
        @dialog.classList.remove 'on'

window.addEventListener 'load', () ->
    app.init() if location.hash is '#start'
window.addEventListener 'hashchange', () ->
    app.init() if location.hash is '#start'