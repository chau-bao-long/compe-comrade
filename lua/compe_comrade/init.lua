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
  context.callback({
    items = {
      { word = 'January'; };
      { word = 'February'; };
      { word = 'March'; };
      { word = 'April'; };
      { word = 'May'; };
      { word = 'June'; };
      { word = 'July'; };
      { word = 'August'; };
      { word = 'September'; };
      { word = 'October'; };
      { word = 'November'; };
      { word = 'December'; };
    };
  })
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
  context.callback({ doc[context.completed_item.word] })
end


return Source.new()
