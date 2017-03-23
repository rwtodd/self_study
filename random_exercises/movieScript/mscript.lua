-- This is just a throwaway program to convert a specific
-- movie script I found on the internet into semantic XML.
-- 
-- The script was an HTML file with the entire text in
-- a <pre> tag.  Not even broken into paragraphs (<p>).
-- Several lines were bolded with <b> tags,
-- which always appeared on the left margin.
--
-- I noted that different kinds of text were indented
-- by different amounts, so this script semantically 
-- labels the parts via their indentation. 
-- 
-- The only ambiguous ones were scene titles and descriptive
-- text, and I used some context to discern which is which.
-- Scene titles are always after a blank line, and always
-- in ALL CAPS.

function trim(s) return s:match("^%s*(.*)") end

function noTags(ln)
	local idx = (ln:match("^</?b>") or ""):len() + 1
	return idx == 1 and ln or noTags(ln:sub(idx))
end

function flet(ln)  -- first non-space letter index 
	return ln:find("%S") or 0
end

function inCaps(ln)
	return ln == ln:upper()
end

-- the state of our output
tagState = {		
	tags = { },  -- a stack of XML tags
	lbb = true   -- "last line was blank"
}

function openTag(t)
	tagState.tags[#tagState.tags + 1] = t
	io.write("\n<",t,">")
end

function closeTag()
	local ct = table.remove(tagState.tags)
	io.write("</",ct,">")
end

function inTag(t) return tagState.tags[#tagState.tags] == t end

function closeTo(what) 
	while not inTag(what) do closeTag() end 
end

function takeBlank()
	if inTag("p") then closeTag() end
end

function takeScene(ln) 
	closeTo("script")
	openTag("scene")
	io.write('<title>',trim(ln),'</title>')
end

function takeSpeaker(ln)
	closeTo("scene")
	io.write('\n')
	openTag("speaker")
	io.write('<name>',trim(ln),'</name>')
end

function takeSpeech(ln)
	if inTag("sdir") then closeTag() end 
	if not inTag("p") then openTag("p") end
	io.write(trim(ln), '\n')
end

function takeDesc(ln)
	if not inTag("p") then
		if not inTag("desc") then
			closeTo("scene")
			io.write("\n")
			openTag("desc")
		end
		openTag("p")
	end
	io.write(trim(ln), '\n')
end

function takeStageDir(ln)
	if not inTag("sdir") then
		if inTag("p") then closeTag() end
		openTag("sdir")
	end
	io.write(trim(ln),'\n')
end

function startScript()
	openTag("script")
	tagState.llb = true
end

function endScript() closeTo(nil) end

-- --------------------------------
--  0 blank
-- 15 description / SCENE
-- 25 speech
-- 30 stagedir
-- 37 speaker  
-- --------------------------------
function procLine(ln)
	ln = noTags(ln)
	local loc = flet(ln)
	if loc == 0 then takeBlank() 
	elseif loc == 16 and tagState.llb and inCaps(ln) then takeScene(ln)
	elseif loc == 16 then takeDesc(ln)
	elseif loc == 26 then takeSpeech(ln)
	elseif loc == 31 then takeStageDir(ln)
	elseif loc == 38 then takeSpeaker(ln)
	else
		print('\n**********')
		print('**********BAD LINE ', loc, trim(ln))
		print('**********')
	end
	tagState.llb = (loc == 0)  -- remember if the line was blank
end 

function process(fn)
	startScript()
	for ln in io.lines(fn) do procLine(ln) end
	endScript()
end

process('Script.input')
