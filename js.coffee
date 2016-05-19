degreeCurrent = 0

ready = ->
  output = $("#output")
  output2 = $("#output2")
  loading = $("#loading")
  loading2 = $("#loading2")
  degree = $("#debug_degree")
  
  screenCenter =
    x: $(document).width()/2
    y: $(document).height()/2

  output.css 'top': screenCenter.y - output.height()/2
  output.css 'left': screenCenter.x - output.width()/2 - 500
  
  output2.css 'top': screenCenter.y - output.height()/2
  output2.css 'left': screenCenter.x - output.width()/2 + 500
  
 
  doc = $(document)
  mouse = {x: 1, y:1}
  ###$(window).mousemove (event)->
    #console.log "Mouse move"
    mouse.x = event.pageX
    mouse.y = event.pageY
    #console.log "X: "+mouse.x+"     "+"Y: "+mouse.y
    ##console.log outputPos.top
    output.css "top": output.css 'top' + mouse.y/3
    output.css "left": output.css 'left' + mouse.x/3
    #console.log mouse.x+"   "+mouse.y###
  
  setInterval ( -> 
               #console.log("Rotating");
               rotateAnim(90, 0.1, "#output")
               degree.html(degreeCurrent)
               matrix = new WebKitCSSMatrix(getComputedStyle($('#output')[0]).webkitTransform)
               loading.css 'top': output.width()*matrix.c-output.width()*matrix.a + screenCenter.y + output.height()/2 - loading.height()
               loading.css 'left': output.css 'left'
               #console.log loading.css 'top'
               ),1
  setInterval ( ->
                #console.log("Rotating")asdasdasd;
               rotateAnim(90, 0.1, "#output2")
               #y = (output.width()*Math.sin(degreeCurrent))+(output.height()*Math.cos(degreeCurrent))
               #x = (output.width()*Math.cos(degreeCurrent))-(output.height()*Math.sin(degreeCurrent))
               #console.log "y: "+y
               #console.log "x: "+x
               #console.log matrix.a
               rads = degreeCurrent/(180/Math.PI)
               matrix = (output2.height()*Math.sin(rads)+output2.height()*Math.cos(rads))*-1
               loading2.css 'top': matrix + screenCenter.y + output.height()/2 - loading.height()
               loading2.css 'left':  output2.css 'left'
              ),1
 rotateAnim = (degree, speed, target) ->
  #console.log degree
  #console.log degreeCurrent
  $(target).css 
      '-webkit-transform': 'rotate(' + degreeCurrent + 'deg)'
      '-moz-transform': 'rotate(' + degreeCurrent + 'deg)'
      '-ms-transform': 'rotate(' + degreeCurrent + 'deg)'
      '-o-transform': 'rotate(' + degreeCurrent + 'deg)'
      'transform': 'rotate(' + degreeCurrent + 'deg)'
    
  if degreeCurrent < degree
    degreeCurrent += speed
    #console.log degreeCurrent
   else
     degreeCurrent = 0

$(document).ready(ready, );
   