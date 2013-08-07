// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready(function()
{
    $('.carousel').carousel({
      interval: 4000
    });
    $('.comment_field').hide();
    $('.comment_button').click(function(){
    	$(this).next('.comment_field').slideDown(1000);
    	$(this).last('.comment_button').animate({opacity: "0.0"});
    });
    $('.cancel_comment').click(function(e){
    	e.preventDefault();
    	$('.comment_field').slideUp(1000);
    	$('.comment_button').animate({opacity: "1"});
    })
    $('.post_field').hide();
    $('.post_button').click(function(){
        $(this).next('.post_field').slideDown(1000);
        $(this).last('.post_button').animate({opacity: "0.0"});
    });
    $('.cancel_post').click(function(e){
        e.preventDefault();
        $('.post_field').slideUp(1000);
        $('.post_button').animate({opacity: "1"});
    })
    $('#pop').popover({
        title: '#asia fan',
        content: 'come join us!',
        trigger: 'hover'
    });
    // $('.post_button').popover({
    //     title: "&lt;_&lt;",
    //     content: "Damn.",
    //     trigger: 'hover'
    //     });

});