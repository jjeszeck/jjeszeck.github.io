window.app =
  image_prefix: './images/books/'
  # TEST FOR BROWSER
  # This first conditional sets 
  # a flag for IE Windows, which will 
  # be used in the loadImage() function.
  crappyBrowser: navigator.appName == 'Microsoft Internet Explorer' and navigator.appVersion.indexOf('Windows') != -1
  # TEST FOR BROWSER
  #
  # PRELOAD ARTWORK FOR NAVIGATION BUTTONS
  # This section loads all the 
  # round button images into memory 
  # so there is no delay when you roll over them.
  navButName: ['home', 'books', 'misc', 'logos', 'clients', 'bio', 'contact', 'web']
  navButton: []

  # PRELOAD ARTWORK FOR NAVIGATION BUTTONS
  
  # ROLLOVERS FOR NAV BUTTONS
  # setButtons() returns all the buttons except the button for the current page (named in the variable pageName, which can be
  # found on the page itself) back to their initial state.
  # changeButton(bName,bNum) changes the button named in bName to either the rollover state (1) or the clicked-on state (2). 
  # The if(document.images[navButName[i]]) condition is only there so I can use this function for the email rollover, which is only
  # on the contact page and so would cause an error on other pages. (this is leftover from a previous version of the website, but I
  # left it in to cover any similar case in the future.)
  setButtons: ->
    i = 0
    while i < @navButName.length
      if document.images[@navButName[i]]
        if @navButName[i] == @pageName
          document.images[@navButName[i]].src = 'images/button/' + @navButName[i] + '2.jpg'
        else
          document.images[@navButName[i]].src = 'images/button/' + @navButName[i] + '0.jpg'
      i++
    return

  changeButton: (bName, bNum) ->
    @setButtons()
    if bName != @pageName
      document.images[bName].src = 'images/button/' + bName + bNum + '.jpg'
    return

  # ROLLOVERS FOR NAV BUTTONS
  #
  # LOAD SPECIFIC ILLUSTRATION
  # The eval() functions are necessary to turn strings 
  # back into object properties. The setIllustration() 
  # function uses information from the layouts[] array, 
  # set on a separate page and included via php.

  setIllustration: (illoNumber) ->
    illustration = document.getElementById('illo' + illoNumber)
    if eval("layouts[app.txtNum].leftIllo" + illoNumber)
      illustration.style.left = eval("layouts[app.txtNum].leftIllo" + illoNumber)
    if eval("layouts[app.txtNum].topIllo" + illoNumber)
      illustration.style.top = eval("layouts[app.txtNum].topIllo" + illoNumber)
    if eval("layouts[app.txtNum].widthIllo" + illoNumber)
      illustration.style.width = eval("layouts[app.txtNum].widthIllo" + illoNumber)
    if eval("layouts[app.txtNum].heightIllo" + illoNumber)
      illustration.style.height = eval("layouts[app.txtNum].heightIllo" + illoNumber)
    if eval("layouts[app.txtNum].srcIllo" + illoNumber)
      illustration.src = eval("layouts[app.txtNum].srcIllo" + illoNumber)
    illustration.style.display = 'inline-block'
    illustration

  # layoutsLoaded is set in header.php. 
  # It is necessary because some pages 
  # don't have associated layouts.
  # Also, this is where we deal with
  # the crappyBrowser variable from the 
  # top of this page. The setTimeouts() are 
  # the only way I could get the crappyBrowser
  # to display the images.

  loadImage: ->
    if layoutsLoaded == 'true'
      capTxt = layouts[@txtNum].name
      if document.getElementById(capTxt)
        @capsOff()
        document.getElementById(capTxt).style.display = 'block'
      if @crappyBrowser
        setTimeout 'setIllustration(1)', 500
        if layouts[@txtNum].srcIllo2
          setTimeout 'setIllustration(2)', 1000
          if layouts[@txtNum].srcIllo3
            setTimeout 'setIllustration(3)', 1500
      else
        @setIllustration 1
        if layouts[@txtNum].srcIllo2
          @setIllustration 2
          if layouts[@txtNum].srcIllo3
            @setIllustration 3
    return

  loadImage2: ->
    # title, slug, text1, text2, text3, publisher, image_count
    if @layoutsLoaded
      capTxt = @layouts[@txtNum].name
      title = @layouts[@txtNum].title
      slug = @layouts[@txtNum].slug
      text = '<p>'+@layouts[@txtNum].text.join('</p><p>')+'</p>'
      text1 = @layouts[@txtNum].text1
      text2 = @layouts[@txtNum].text2
      text3 = @layouts[@txtNum].text3
      publisher = @layouts[@txtNum].publisher
      image_count = @layouts[@txtNum].image_count

      capTitle = document.getElementById('capTitle')
      capText = document.getElementById('capText')
      capPublisher = document.getElementById('capPublisher')

      capTitle.innerHTML = title
      capText.innerHTML = text
      capPublisher.innerHTML = publisher

      for i in [1..2] by 1
        if i <= image_count
          two_digit_number = ('0'+@txtNum).slice(-2)
          document.getElementById("illo#{i}").style.visibility = 'visible'
          document.getElementById("illo#{i}").src = "#{@image_prefix}#{two_digit_number}_#{slug}#{i}.jpg"

        else
          document.getElementById("illo#{i}").style.visibility = 'hidden'
          document.getElementById("illo#{i}").style.height = '150px'
          document.getElementById("illo#{i}").src = ''
    return

  # Setting the images to yellow jpgs between changes
  # is necessary because the program gets ahead of 
  # itself and changes the dimensions before changing 
  # the illustration, causing the old illustration to
  # stretch out weirdly before changing to the new one.

  clearImages: ->
    if layouts[@txtNum].srcIllo1
      document.getElementById('illo1').style.display = 'none'
      document.getElementById('illo1').src = './images/yellow.jpg'
    if layouts[@txtNum].srcIllo2
      document.getElementById('illo2').style.display = 'none'
      document.getElementById('illo2').src = './images/yellow.jpg'
    if layouts[@txtNum].srcIllo3
      document.getElementById('illo3').style.display = 'none'
      document.getElementById('illo3').src = './images/yellow.jpg'
    return

  capsOff: ->
    i = 0
    while i < layouts.length
      capTxt = layouts[i].name
      document.getElementById(capTxt).style.display = 'none'
      i++
    return

  cycleIllos: (direction) ->
    @clearImages()
    layoutsLength = layouts.length
    if direction == 'forward'
      @txtNum++
      if @txtNum >= layoutsLength
        @txtNum = 0
    else
      @txtNum--
      if @txtNum < 0
        @txtNum = layoutsLength - 1
    window.scrollTo 0, 0
    @loadImage()
    return

  cycleIllos2: (direction) ->
    layoutsLength = @layouts.length
    if direction == 'forward'
      @txtNum++
      if @txtNum >= layoutsLength
        @txtNum = 0
    else
      @txtNum--
      if @txtNum < 0
        @txtNum = layoutsLength - 1
    window.scrollTo 0, 0
    @loadImage2()
    return

  # CYCLE THROUGH TEXT AND IMAGES
  #---------------------------------------------------------------------------------------
  # OPEN WINDOW WITH IMAGE
  # This is the enlargement you get when
  # you click on an illustration. 

  displayImage: (imageSrc) ->
    document.getElementById('imageOverlay').style.display = 'block'
    document.getElementById('overlayImage').src = imageSrc
    return

  killImage: ->
    document.getElementById('imageOverlay').style.display = 'none'
    return

  ready: ->
    i = 0
    while i < @navButName.length
      @navButton[i] = new Image
      @navButton[i].src = 'images/button/' + @navButName[i] + '0.jpg'
      @navButton[i + @navButName.length] = new Image
      @navButton[i + @navButName.length].src = 'images/button/' + @navButName[i] + '1.jpg'
      @navButton[i + 2 * @navButName.length] = new Image
      @navButton[i + 2 * @navButName.length].src = 'images/button/' + @navButName[i] + '2.jpg'
      i++
    # LOAD SPECIFIC ILLUSTRATION
    #---------------------------------------------------------------------------------------
    # CYCLE THROUGH TEXT AND IMAGES
    # Each section begins with illustration 0 and
    # can be cycled forward or backward through the 
    # entire list, coming back to 0.
    @txtNum = 0
app.ready()