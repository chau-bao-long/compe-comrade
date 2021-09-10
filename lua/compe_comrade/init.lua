local compe = require'compe'

local Source = {
  callback = nil;
}

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

--- Return table in form of { items = { word = 'candidate 1'}, { word = 'candidate 2'} }
local function transform_candidates(candidates)
  local items = {}

  for _, c in ipairs(candidates) do
    table.insert(items, { word = c.word, kind = c.kind })
  end

  return { items = items }
end

local function do_complete()
  local buf_id = vim.fn.bufnr()
  local buf_changedtick = vim.api.nvim_buf_get_changedtick(buf_id)
  local buf_name = vim.api.nvim_buf_get_name(buf_id)
  local row = vim.fn.line('.') - 1
  local col = vim.fn.col('.') - 1
  local new_request = true
  local results

  local timer = vim.loop.new_timer()

  timer:start(0, 100, function ()
    vim.schedule(function()
      local ret = {
        buf_id = buf_id,
        buf_name = buf_name,
        buf_changedtick = buf_changedtick,
        row = row,
        col = col,
        new_request = new_request,
      }
      new_request = false
      results = vim.fn["comrade#RequestCompletion"](buf_id, ret)

      if results["is_finished"] then
        local candidates = transform_candidates(results["candidates"])
        Source.callback(candidates)

        timer:close()
      end
    end)
  end)
end

--- complete
function Source.complete(_, context)
  Source.callback = context.callback

  do_complete()
end

--- confirm replace suffix
function Source.confirm(self, option)
end

function Source.documentation(self, context)
  -- will show the current selected item documentation
  -- context.callback({ doc[context.completed_item.word] })
  context.callback({})
end


return Source.new()
