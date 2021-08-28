local compe = require'compe'

local Source = {}

function Source.new(client, source)
	return setmetatable({}, { __index = Source })
end


--- get_metadata
function Source.get_metadata(_)
	return {
		priority = 5000;
		menu = '[IJ]';
	}
end

--- determine
function Source.determine(_, context)
  return compe.helper.determine(context)
end

--- complete
function Source.complete(self, context)
  local buf_id = vim.fn.bufnr()
  local buf_changedtick = vim.api.nvim_buf_get_changedtick(buf_id)
  local buf_name = vim.api.nvim_buf_get_name(buf_id)
  local row = vim.fn.line('.')
  local col = vim.fn.col('.')
  local ret = {
    buf_id = buf_id,
    buf_name = buf_name,
    buf_changedtick = buf_changedtick,
    row = row,
    col = col,
    new_request = true,
  }

  local results = vim.fn["comrade#RequestCompletion"](buf_id, ret)

  context.callback(results["candidates"])
end

--- confirm replace suffix
function Source.confirm(self, option)
end

function Source.documentation(self, context)
   local doc = {
     January = 'Documentation for January';
     February = 'Documentation for February';
     March = 'Documentation for March';
     April = 'Documentation for April';
     May = 'Documentation for May';
     June = 'Documentation for June';
     July = 'Documentation for July';
     August = 'Documentation for August';
     September = 'Documentation for September';
     October = 'Documentation for October';
     November = 'Documentation for November';
     December = 'Documentation for December';
  }

  -- will show the current selected item documentation
  -- context.callback({ doc[context.completed_item.word] })
  context.callback({})
end


return Source.new()
