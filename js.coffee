degreeCurrent = 0
rotate1Times = []
rotate2Times = []

ready = ->
  output = $("#output")
  loading = $("#loading")
  degree = $("#debug_degree")
  mousee = $("#mousee")
  
  screenCenter =
    x: $(document).width()/2
    y: $(document).height()/2

  output.css 'bottom': "90px"
  output.css 'left': screenCenter.x - output.width()/2
 
  doc = $(document)
  mouse = {x: 1, y:1}
  $(window).mousemove (event)->
    #console.log "Mouse move"
    mouse.x = event.pageX
    mouse.y = event.pageY
    #console.log "X: "+mouse.x+"     "+"Y: "+mouse.y
    ##console.log outputPos.top
   
    #console.log mouse.x+"   "+mouse.y
  
  setInterval ( -> 
               start = performance.now()
               #console.log("Rotating");
               rotateAnim(90, 0.15, "#output", "#output2")
               rotateAnim(90, 0.1, "#output2", "#output3")
               rotateAnim(90, 0.05, "#output3", "#output4")
               rotateAnim(90, 0.0, "#output4", "#none")
               #degree.html degreeCurrent
               #mousee.html "x: "+mouse.x+"   "+"y: "+mouse.y
               
               #console.log output.offset().top
               #output.css "top":  screenCenter.y - mouse.y/4
               output.css "left":   screenCenter.x - mouse.x/4
               #console.log loading.css 'top'
               rotate1Time = performance.now() - start 
               rotate1Times.push rotate1Time
               ##console.log rotateAnim(0,0,0)
               ),1
              
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

 rotateAnim = (degree, speed, target, bouncer) ->
  $target = $(target)
  $bouncer = $(bouncer)
  $(target).css 
      '-webkit-transform': 'rotate(' + degreeCurrent + 'deg)'
      '-moz-transform': 'rotate(' + degreeCurrent + 'deg)'
      '-ms-transform': 'rotate(' + degreeCurrent + 'deg)'
      '-o-transform': 'rotate(' + degreeCurrent + 'deg)'
      'transform': 'rotate(' + degreeCurrent + 'deg)'
  
  rads = degreeCurrent/(180/Math.PI)
  matrix = ($target.height()*Math.sin(rads)+$target.height()*Math.cos(rads))*-1
  $bouncer.css 'top': matrix + $target.offset().top + $target.height() - $bouncer.height() - 15
  $bouncer.css 'left': $target.css 'left'
  if degreeCurrent < degree
    degreeCurrent += speed
    #console.log degreeCurrent
   else
     degreeCurrent = 0
  return degreeCurrent
$(document).ready ready
   