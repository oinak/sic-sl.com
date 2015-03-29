$(document).ready ->

  window.SIC = ( (expose) ->
    _accordion_init = () ->
      $('.accordion-tabs-minimal').each (index) ->
        $(this).children('li').first().children('a').addClass('is-active').next().addClass('is-open').show()
        return
      $('.accordion-tabs-minimal').on 'click', 'li > a', (event) ->
        if !$(this).hasClass('is-active')
          event.preventDefault()
          accordionTabs = $(this).closest('.accordion-tabs-minimal')
          accordionTabs.find('.is-open').removeClass('is-open').hide()
          $(this).next().toggleClass('is-open').toggle()
          accordionTabs.find('.is-active').removeClass 'is-active'
          $(this).addClass 'is-active'
        else
          event.preventDefault()
        return
      return

    expose.init = () ->
      _accordion_init()

    expose

  )(window.SIC or {})

  SIC.init()
