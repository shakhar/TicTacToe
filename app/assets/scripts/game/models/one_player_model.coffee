@TicTacToe.module "GameApp", (GameApp, App, Backbone, Marionette, $, _) ->
  
  class GameApp.OnePlayerModel extends GameApp.GameModel
    constructor: ->
      super
      @validLocation = true
      @difficulty = "easy"
      @level = 6

    reset: ->
      super
      @validLocation = true

    alphaBeta: (validLocation) ->
      @movesLeft = Infinity
      if validLocation is true
        @validLocation = true
      else
        @validLocation = @parseLocation validLocation
      @maxValue this, -Infinity, Infinity, true, 1

    maxValue: (state, alpha, beta, isFirst = false, level) ->
      if state.isTerminal level
        score = state.boardScore()
        score *= (8 - level) if Math.abs score is 10000
        return score 
      v = -Infinity
      moves = state.getMoves()
      bestMove = moves[0]
      for move in moves
        unless @isFullBoard(@board.table[move[2]][move[3]].table)
          min = @minValue(state.getNext(move, "max"), alpha, beta, false, level + 1)
          if min > v
            v = min
            bestMove = move
          if v >= beta
            return move if isFirst
            return v
          alpha = v if v > alpha
      if isFirst then bestMove else v

    minValue: (state, alpha, beta, isFirst = false, level) ->
      if state.isTerminal(level)
        score = state.boardScore()
        score *= (8 - level) if Math.abs score is 10000
        return score 
      v = Infinity
      moves = state.getMoves()
      bestMove = moves[0]
      for move in moves
        unless @isFullBoard(@board.table[move[2]][move[3]].table)
          max = @maxValue(state.getNext(move, "min"), alpha, beta, false, level + 1)
          if max < v
            v = max
            bestMove = moves
          if v <= alpha
            return move if isFirst
            return v
          beta = v if v < beta
      if isFirst then bestMove else v

    subBoardScore: (location) ->
      nextBoard = @board.table[location[0]][location[1]]
      return -1 if @isFull 0, nextBoard.table
      return 1 if nextBoard.val isnt 0
      return 0

    getMoves: ->
      moves = new Array()
      moves1 = new Array()
      moves2 = new Array()
      moves3 = new Array()
      for i in [0...3]
        for j in [0...3]
          if @validLocation is true
            for k in [0...3]
              for l in [0...3]
                if @board.table[i][j].table[k][l].val is 0
                  subScore = @subBoardScore [k, l]
                  moves.push  [ i, j, k, l ] if @boardGoingToEnd [k, l] 
                  moves1.push [ i, j, k, l ] if subScore is 1
                  moves2.push [ i, j, k, l ] if subScore is 0
                  moves3.push [ i, j, k, l ] if subScore is -1
          else 
            if @board.table[@validLocation[0]][@validLocation[1]].table[i][j].val is 0
              subScore = @subBoardScore [i, j]
              moves.push  [ @validLocation[0], @validLocation[1], i, j ] if @boardGoingToEnd [i, j] 
              moves1.push [ @validLocation[0], @validLocation[1], i, j ] if subScore is 1
              moves2.push [ @validLocation[0], @validLocation[1], i, j ] if subScore is 0
              moves3.push [ @validLocation[0], @validLocation[1], i, j ] if subScore is -1
      if moves1.length > 0
        @movesLeft -= moves1.length
        return moves.concat moves1
      else if moves2.length > 0 
        @movesLeft -= moves2.length
        return moves.concat moves2
      else 
        @movesLeft -= moves3.length
        return moves.concat moves3

    isTerminal: (level) ->
      noSpaces = true
      for i in [0...3]
        for j in [0...3]
          noSpaces = false if @board.table[i][j].val is 0
      return noSpaces or @isGameOver() or level > @level or @movesLeft < 0

    isGameOver: ->
      Math.abs @boardScore() is 10000

    getNext: (move, player) ->
      if player is "max"
        player = 1
      else
        player = -1
      nextState = new GameApp.OnePlayerModel()
      nextState.board = @copyBoard @board
      nextState.board.table[move[0]][move[1]].table[move[2]][move[3]].val = player
      nextState.validLocation = [ move[2], move[3] ]
      return nextState

    boardGoingToEnd: (validLocation) ->
      subBoard = @board.table[validLocation[0]][validLocation[1]].table
      for i in [0...subBoard]
        return true if @twoCells([subBoard[i][0].val, subBoard[i][1].val, subBoard[i][2].val])
        return true if @twoCells([subBoard[0][i].val, subBoard[1][i].val, subBoard[2][i].val])
      return true if @twoCells([subBoard[0][0].val, subBoard[1][1].val, subBoard[2][2].val])
      return true if @twoCells([subBoard[0][2].val, subBoard[1][1].val, subBoard[2][0].val])
      return false

    twoCells: (row) ->
      return row[0] is row[1] isnt 0 or row[0] is row[2] isnt 0 or row[1] is row[2] isnt 0  

    boardScore: (subBoard) ->
      score = 0
      if subBoard?
        currentBoard = subBoard
      else
        currentBoard = @board
      return @columnScore(currentBoard.table) + @rowScore(currentBoard.table) + @crossScore(currentBoard.table) if currentBoard.val is 0
      return currentBoard.val * ((if subBoard? then 100 else 10000))

    rowScore: (currentBoard) ->
      score = 0
      for row in currentBoard
        if row[0].table?
          sum = abs = subSum = 0
          for cell in row
            val = @boardScore(cell)
            if Math.abs(val) is 100
              abs += Math.abs(val)
              sum += val 
            else
              subSum += val
          if abs is Math.abs(sum)
            if abs is 200  
              score += (sum + subSum) * 10
            else
              score += (sum + subSum)
          else
            score += subSum
        else
          sum = abs = 0
          for cell in row
              val = cell.val
              abs += Math.abs(val)
              sum += val
          if abs is Math.abs(sum)
            if abs is 2  
              score += sum * 10
            else
              score += sum
      return score

    columnScore: (currentBoard) ->
      score = 0
      for i in [0...currentBoard.length]
        if currentBoard[0][0].table?
          sum = abs = subSum = 0
          for j in [0...currentBoard[i].length]
            val = @boardScore(currentBoard[j][i])
            if Math.abs(val) is 100
              abs += Math.abs(val)
              sum += val 
            else
              subSum += val
          if abs is Math.abs(sum)
            if abs is 200  
              score += (sum + subSum) * 10
            else
              score += (sum + subSum)
          else
            score += subSum
        else
          sum = abs = 0
          for j in [0...currentBoard[i].length]
            val = currentBoard[j][i].val
            abs += Math.abs(val)
            sum += val
          if abs is Math.abs(sum)
            if abs is 2  
              score += sum * 10
            else
              score += sum
      return score

    crossScore: (currentBoard) ->
      abs = sum = score = subSum = 0
      for i in [0...currentBoard.length]
        if currentBoard[0][0].table?
          val = @boardScore(currentBoard[i][i])
          if Math.abs(val) is 100
            abs += Math.abs(val)
            sum += val 
          else
            subSum += val
          val = @boardScore(currentBoard[i][2 - i])
          if Math.abs(val) is 100
            abs += Math.abs(val)
            sum += val 
          else
            subSum += val
          if abs is Math.abs(sum)
            if abs is 200  
              score += (sum + subSum) * 10
            else
              score += (sum + subSum)
          else
            score += subSum
        else
          val = currentBoard[i][i].val
          abs += Math.abs(val)
          sum += val
          val = currentBoard[i][2 - i].val
          abs += Math.abs(val)
          sum += val
          if abs is Math.abs(sum)
            if abs is 2  
              score += sum * 10
            else
              score += sum
      return score

    isFullBoard: (board) ->
      for row in board
        for cell in row
          return false unless cell.val
      return true