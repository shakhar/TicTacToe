@TicTacToe.module "GameApp", (GameApp, App, Backbone, Marionette, $, _) ->
  
  class GameApp.GameModel
    constructor: ->
      @board = @buildBoard()

    reset: ->
      @board = @buildBoard()

    changeBoard: (parentLocation, location, player) ->
      parsedLocation = @parseLocation(parentLocation.className, location.className)
      if parsedLocation.length > 2
        @board.table[parsedLocation[0]][parsedLocation[1]].table[parsedLocation[2]][parsedLocation[3]].val = player
        @checkBoard player, parsedLocation.slice(0, 2)
      else
        @board.table[parsedLocation[0]][parsedLocation[1]].val = player
        @checkBoard player

    checkLocation: (parentLocation, location) ->
      parsedLocation = @parseLocation(parentLocation.className, location.className)
      if parsedLocation.length > 2
        return true if @board.table[parsedLocation[0]][parsedLocation[1]].table[parsedLocation[2]][parsedLocation[3]].val is 0
        return false
      else
        return true if @board.table[parsedLocation[0]][parsedLocation[1]].val is 0
        return false

    checkBoard: (player, location) ->
      if location?
        if (@checkRows(player, location) or @checkColumns(player, location) or @checkCross(player, location)) and @board.table[location[0]][location[1]].val is 0
          @board.table[location[0]][location[1]].val = player
          return true
        return false
      else
        if @checkRows(player) or @checkColumns(player) or @checkCross(player)
          @board.val = player
          return true
        return false

    isFull: (location, subBoard) ->
      currentBoard = @board.table
      unless subBoard?
        if location?
          parsedLocation = @parseLocation(location)
          currentBoard = @board.table[parsedLocation[0]][parsedLocation[1]].table
      else
        currentBoard = subBoard
      for row in currentBoard
        for cell in row
          return false if (location? or not @isFull(0, cell.table)) and cell.val is 0
      return true

    parseBackLocation: (x, y, parentLocation) ->
      parsedBackLocation = Array()
      switch x
        when 0
          parsedBackLocation.push "up"
        when 1
          parsedBackLocation.push "center"
          parsedBackLocation.push "centers"  if y is 1
        when 2
          parsedBackLocation.push "down"
      switch y
        when 0
          parsedBackLocation.push "left"
        when 1
          parsedBackLocation.push "center"  unless x is 1
        when 2
          parsedBackLocation.push "right"
      if parentLocation?
        parsedBackLocation.push "in"
        return $("." + parentLocation.className.split(" ").join(".") + " ." + parsedBackLocation.join("."))[0]
      else
        parsedBackLocation.push "out"
        return $("." + parsedBackLocation.join("."))[0]

    checkRows: (player, location) ->
      if location?
        currentBoard = @board.table[location[0]][location[1]].table
      else
        currentBoard = @board.table
      for i in [0..2]
        return true if player is currentBoard[i][0].val is currentBoard[i][1].val is currentBoard[i][2].val
      return false

    checkColumns: (player, location) ->
      if location?
        currentBoard = @board.table[location[0]][location[1]].table
      else
        currentBoard = @board.table
      for i in [0..2]
        return true if player is currentBoard[0][i].val is currentBoard[1][i].val is currentBoard[2][i].val
      return false

    checkCross: (player, location) ->
      if location?
        currentBoard = @board.table[location[0]][location[1]].table
      else
        currentBoard = @board.table
      return true if player is currentBoard[0][0].val is currentBoard[1][1].val is currentBoard[2][2].val
      return true if player is currentBoard[2][0].val is currentBoard[1][1].val is currentBoard[0][2].val
      return false

    getMoves: (validLocation) ->
      moves = []
      if validLocation isnt true
        validLocation = @parseLocation validLocation
        subBoard = @board.table[validLocation[0]][validLocation[1]].table
        for i in [0..2]
          for j in [0..2]
            moves.push [validLocation[0], validLocation[1], i, j] if subBoard[i][j].val is 0
      else
        for i in [0..2]
          for j in [0..2]
            for k in [0..2]
              for l in [0..2]
                moves.push [i, j, k, l] if @board.table[i][j].table[k][l].val is 0
      return moves

    getWinningLines: ->
      winner = @board.val
      board = @board.table
      lines = []
      
      for i in [0...board.length]
        if board[i][0].val is board[i][1].val is board[i][2].val is winner
          start = $(@parseBackLocation i, 0)
          end = $(@parseBackLocation i, 2)
          start = 
            x: start.position().left + 10
            y: start.position().top + start.width() / 2
          end =
            x: end.position().left + end.width() - 10
            y: end.position().top + end.width() / 2 
        else if board[0][i].val is board[1][i].val is board[2][i].val is winner
          start = $(@parseBackLocation 0, i)
          end = $(@parseBackLocation 2, i)
          start = 
            x: start.position().left + start.width() / 2
            y: start.position().top + 10
          end =
            x: end.position().left + end.width() / 2
            y: end.position().top + end.width() - 10 
        else
          continue

        lines.push 
          start: start 
          end: end

      if board[0][0].val is board[1][1].val is board[2][2].val is winner
        start = $(@parseBackLocation 0, 0)
        end = $(@parseBackLocation 2, 2)
        start = 
          x: start.position().left + 10
          y: start.position().top + 10
        end =
          x: end.position().left + end.width() - 10
          y: end.position().top + end.width() - 10
        
        lines.push 
          start: start 
          end: end

      if board[0][2].val is board[1][1].val is board[2][0].val is winner
        start = $(@parseBackLocation 0, 2)
        end = $(@parseBackLocation 2, 0)
        start = 
          x: start.position().left + start.width()
          y: start.position().top
        end =
          x: end.position().left
          y: end.position().top + end.width()

        lines.push 
          start: start 
          end: end

      return lines

    parseLocation: (parentLocation, location) ->
      parsedLocation = Array()
      parentLocations = parentLocation.split " "
      for i in [0...parentLocations.length]
        if parentLocations[i] in ["in", "out", "active"]
          parentLocations.splice i, 1
      if parentLocations[1] in ["up", "down"]
        temp = parentLocations[0]
        parentLocations[0] = parentLocations[1]
        parentLocations[1] = temp
      for loc in parentLocations
        switch loc
          when "up", "left"
            parsedLocation.push 0
          when "center", "centers"
            parsedLocation.push 1
          when "down", "right"
            parsedLocation.push 2
      if location?
        locations = location.split " "
        for i in [0...locations.length]
          if locations[i] in ["in", "out", "active"]
            locations.splice i, 1
        if locations[1] in ["up", "down"]
          temp = locations[0]
          locations[0] = locations[1]
          locations[1] = temp
        for loc in locations
          switch loc
            when "up", "left"
              parsedLocation.push 0
            when "center", "centers"
              parsedLocation.push 1
            when "down", "right"
              parsedLocation.push 2
      parsedLocation
    
    buildBoard: ->
      newBoard =
        table: new Array 3
        val: 0
      for column in [0...newBoard.table.length]
        newBoard.table[column] = new Array 3
        for subBoard in [0...newBoard.table[column].length]
          newBoard.table[column][subBoard] =
            table: new Array 3
            val: 0
          for subColumn in [0...newBoard.table[column][subBoard].table.length]
            newBoard.table[column][subBoard].table[subColumn] = new Array 3
            for val in [0...newBoard.table[column][subBoard].table[subColumn].length]
              newBoard.table[column][subBoard].table[subColumn][val] = val: 0
      return newBoard

    copyBoard: (board) ->
      newBoard =
        table: new Array 3
        val: 0
      for column in [0...newBoard.table.length]
        newBoard.table[column] = new Array 3
        for subBoard in [0...newBoard.table[column].length]
          newBoard.table[column][subBoard] =
            table: new Array 3
            val: 0
          for subColumn in [0...newBoard.table[column][subBoard].table.length]
            newBoard.table[column][subBoard].table[subColumn] = new Array 3
            for val in [0...newBoard.table[column][subBoard].table[subColumn].length]
              newBoard.table[column][subBoard].table[subColumn][val] = 
                val: board.table[column][subBoard].table[subColumn][val].val
      return newBoard