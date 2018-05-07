
def ulam(a,b):
  sofar = [a]
  backlog = [(b,False)]

  yield a

  def merge_sums(sums):
     nonlocal backlog
     merged = []
     sIdx, bIdx, bMax = 0, 0, len(backlog)
     while bIdx < bMax:
       diff = backlog[bIdx][0] - sums[sIdx]
       if diff == 0:
          merged.append( (sums[sIdx], True) )
          sIdx, bIdx = sIdx+1, bIdx+1
       elif diff < 0:
          merged.append( backlog[bIdx] )
          bIdx = bIdx + 1
       else:
          merged.append( (sums[sIdx], False) )
          sIdx = sIdx + 1
     merged.extend((s, False) for s in sums[sIdx:])
     backlog = merged 

  def pop_backlog():
     nonlocal backlog
     idx = 0
     while backlog[idx][1]:
        idx += 1
     ans = backlog[idx][0]
     backlog = backlog[idx+1:]
     return ans

  while True:
     nxt = pop_backlog()
     merge_sums( [ sf + nxt for sf in sofar ] )
     sofar.append(nxt)
     yield nxt

 
   
    
