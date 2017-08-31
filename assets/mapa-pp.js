$(document).ready(function() {
	var nomeLocal;
	var dirLocal;
	var local;
	var camada = $('<div class="overlayer"></div>');	
	var locais=[$('#campo'),$('#aquario'),$('#museu'),$('#praca'),$('#balsa'),$('#armazens'),$('#guaruja')];
	var contador = locais.length;
		
	for (l in locais){
		locais[l].click( function(){
			if (contador){
				perguntar( $(this) );
			}
		});
	}

	$('#fechar_abertura').click( function(){
		$('#abertura').hide();
		camada.appendTo('#mapa');
		camada.fadeTo('fast',0.5).delay(3000).fadeOut(500);
		camada = $('.overlayer','#mapa');
		$('#help').bind('click', function(){
			if( camada.css('display') == 'none'){
				camada.fadeTo('fast',0.5).delay(3000).fadeOut(500);
			}
		});
	});
	$('.fechar','#dialogo').click(ocultarDialogo);
	$('#colegio').click( function(){
		alert('Este é o local de referência!');
	});
	$('menu a','#dialogo').click( function(){
		if( dirLocal == $(this).attr('data-direcao') ){
			responder('<h4>Est&aacute; correto. Parab&eacute;ns!</h4>');
			ocultarDialogo();
			local.fadeTo('fast',0.7);
			local.addClass('inativo');
			contador--;
			if (contador==0){
				$('#dialogo').clearQueue().hide();
				$('#help').hide();
				alert('Parabéns! \n\nVocê já encontrou a resposta certa para todos os locais.');
			}
		}
		else{
			responder('<h4>N&atilde;o. Parece que n&atilde;o &eacute; a dire&ccedil;&atilde;o correta.</h4>');
		}
	});

	function ocultarDialogo(){
		$('#dialogo').delay(500).fadeOut('slow');
		camada.fadeOut();
	}
	function perguntar(ob){
		if ( ob.hasClass('inativo') ){
			alert('Já foi respondido!');
			return;
		}
		nomeLocal = ob.attr('data-nome');
		dirLocal = ob.attr('data-direcao');
		local = ob;
		$('h1#nomelocal').html(nomeLocal);
		$('#dialogo').fadeIn('fast');
		camada.fadeTo('fast',0.5);
	}
	function responder(resp){
		var resposta = $(resp);
		$('#dialogo').append(resposta);
		resposta.delay(800).fadeOut('fast');
	}

});