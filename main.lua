require("string")

function inc(tape, head)
	if tape[head] == 255 then
		tape[head] = 0
	else
		tape[head] = tape[head] + 1
	end
end

function dec(tape, head)
	if tape[head] == 0 then
		tape[head] = 255
	else
		tape[head] = tape[head] - 1
	end
end

function main()
	local tape = setmetatable({}, {
		__index = function()
			return 0
		end,
	})
	local head = 1
	local idx = 1
	local stack = {}

	local line = io.read("*a")

	while idx <= #line do
		local symbol = line:sub(idx, idx)

		if symbol == ">" then
			head = head + 1
		elseif symbol == "<" then
			head = head - 1
		elseif symbol == "+" then
			inc(tape, head)
		elseif symbol == "-" then
			dec(tape, head)
		elseif symbol == "." then
			io.write(string.char(tape[head]))
		elseif symbol == "," then
			tape[head] = string.byte(io.read(1) or "\000")
		elseif symbol == "[" then
			if tape[head] == 0 then
				local loop = 1
				while loop > 0 do
					idx = idx + 1
					if line:sub(idx, idx) == "[" then
						loop = loop + 1
					elseif line:sub(idx, idx) == "]" then
						loop = loop - 1
					end
				end
			else
				table.insert(stack, idx)
			end
		elseif symbol == "]" then
			idx = stack[#stack] - 1
			table.remove(stack)
		end

		idx = idx + 1
	end

	print()
end

main()
