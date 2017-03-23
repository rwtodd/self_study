# This is just a throwaway program to convert a specific
# movie script I found on the internet into semantic XML.
#
# The script was an HTML file with the entire text in
# a <pre> tag.  Not even broken into paragraphs (<p>).
# Several lines were bolded with <b> tags,
# which always appeared on the left margin.
#
# I noted that different kinds of text were indented
# by different amounts, so this script semantically 
# labels the parts via their indentation. 
# 
# The only ambiguous ones were scene titles and descriptive
# text, and I used some context to discern which is which.
# Scene titles are always after a blank line, and always
# in ALL CAPS.

def noTag(ln):
  """strips out B tags"""
  if ln.startswith('<b>'):
     return noTag(ln[3:])
  if ln.startswith('</b>'):
     return noTag(ln[4:])
  return ln

def firstLetter(ln):
  """Gives the position for the first non-space"""
  n = 0
  for c in ln:
    if c != ' ':
       return n
    n = n + 1
  # nothing found
  return 0

def inCaps(ln):
  """tells if a line has all its letters capitalized"""
  return all(c.isupper() for c in ln if c.isalpha())

class TagState:
  def __init__(self):
     self.tags = ['-1']
     self.__tag('script')
     self.llb = True  # last line blank
  def __tag(self,t):
     self.tags.append(t)
     print(f'\n<{t}>', end='')
  def __close(self):
     t = self.tags.pop()
     print(f'</{t}>', end='')
  def closeTo(self,what):
     """close up to but not including the named tag"""
     t = self.tags[-1]
     while t != what:
       self.__close()
       t = self.tags[-1]
  def newBlank(self):
     if self.tags[-1] == 'p':
       self.__close()
  def newScene(self,l):
     self.closeTo('script')   
     self.__tag('scene')
     print(f'<title>{l.strip()}</title>')
  def newSpeaker(self,s):
     self.closeTo('scene')
     print()
     self.__tag('speaker')
     print(f'<name>{s.strip()}</name>',end='')
  def newSpeech(self,s):
     # close and open stage directions
     if self.tags[-1] == 'sdir':
        self.__close()
     # open a paragraph if we aren't in one
     if self.tags[-1] != 'p':
        self.__tag('p')
     print(s.strip())
  def newDesc(self,d):
     if self.tags[-1] != 'p':
        # we are not already in a paragraph...
        if self.tags[-1] != 'desc':
          # we aren't in a desc, so back up to scene level
          self.closeTo('scene')
          print()
          self.__tag('desc')
        self.__tag('p')
     print(d.strip())
  def newStageDir(self, sd):
     if self.tags[-1] != 'sdir':
        if self.tags[-1] == 'p': 
           self.__close()
        self.__tag('sdir')
     print(sd.strip())
  def done(self):
     self.closeTo('-1')

# ################
#  0 blank
# 15 description / SCENE
# 25 speech
# 30 stagedir
# 37 speaker  
# ################
def procline(ts, l):
  """process line 'l', using TagState 'ts'"""
  loc = firstLetter(l)   
  if loc == 0:
    ts.newBlank() 
  elif loc == 15 and ts.llb and inCaps(l):
    ts.newScene(l)
  elif loc == 15:
    ts.newDesc(l)
  elif loc == 25:
    ts.newSpeech(l)
  elif loc == 30:
    ts.newStageDir(l)
  elif loc == 37:
    ts.newSpeaker(l)
  else:
    print('**********')
    print(f'**********BAD LINE {loc} <{l}>')
    print('**********')
  ts.llb = (loc == 0)   # remember if the line was blank
 
def process(fn):
  with open(fn,"r") as ifile:
    ts = TagState()
    for line in ifile:
       line = noTag(line)
       procline(ts,line)
    ts.done()

process('Script.input')

