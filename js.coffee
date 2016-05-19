degreeCurrent = 0
rotate1Times = []
rotate2Times = []

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
               start = performance.now()
               #console.log("Rotating");
               rotateAnim(90, 0.1, "#output")
               degree.html(degreeCurrent)
               matrix = new WebKitCSSMatrix(getComputedStyle($('#output')[0]).webkitTransform)
               loading.css 'top': output.width()*matrix.c-output.width()*matrix.a + screenCenter.y + output.height()/2 - loading.height()
               loading.css 'left': output.css 'left'
               #console.log loading.css 'top'
               rotate1Time = performance.now() - start 
               rotate1Times.push rotate1Time
               ),1
  setInterval ( ->
               start = performance.now()
               rotateAnim(90, 0.1, "#output2")
               rads = degreeCurrent/(180/Math.PI)
               matrix = (output2.height()*Math.sin(rads)+output2.height()*Math.cos(rads))*-1
               loading2.css 'top': matrix + screenCenter.y + output.height()/2 - loading.height()
               loading2.css 'left':  output2.css 'left'
               rotate2Time = performance.now() - start
               rotate2Times.push rotate2Time
              ), 1
              
  setInterval ( ->
    sum = 0
    for time in rotate1Times
      sum += time
    avg = sum / rotate1Times.length
    rotate1Times = []
    $('#ms1').text 'Rotate 1 takes about ' + avg + 'ms to execute and runs for ' + sum + 'ms every second.'
    
    sum = 0
    for time in rotate2Times
      sum += time
    avg = sum / rotate2Times.length
    rotate2Times = []
    $('#ms2').text 'Rotate 2 takes about ' + avg + 'ms to execute and runs for ' + sum + 'ms every second.'
  ), 1000

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

$(document).ready ready
   