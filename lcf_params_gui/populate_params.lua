local subtract_table = request('!.table.subtract')

local skip_default_values = false

--[[
  These defaults should be equal defaults of "lua.reformat"
  command-line tool.
]]
local defaults =
  {
    keep_comments = true,
    keep_unparsed_text = true,
    indent_chunk = '  ',
    right_margin = 96,
  }

return
  --[[
    For passed application reference, represent selected parameters
    as a table with following fields:

      * opt keep_comments: bool
      * opt keep_unparsed_text: bool
      * opt indent_chunk: str
      * cho right_margin: int
            max_text_width: int

    If <skip_default_values> and parameter equals default value
    (from <defaults> table) it is not included in resulting table.

    These values later used for command line constructuon.
  ]]
  function(app)
    local is_set =
      function(id)
        return app:getById(id).Selected
      end

    local get_first_set_id =
      function(prefix, start_num, end_num)
        for i = start_num, end_num do
          if is_set(prefix .. i) then
            return i
          end
        end
      end

    local result =
      {
        keep_comments = is_set('keep_comments'),
        keep_unparsed_text = is_set('keep_unparsed_text'),
      }

    local indent_chunk
    if is_set('indent_tab') then
      indent_chunk = '\t'
    else
      local num_spaces = get_first_set_id('indent_spc_', 0, 4)
      assert(num_spaces)
      indent_chunk = (' '):rep(num_spaces)
    end
    result.indent_chunk = indent_chunk

    local margin_value = app:getById('margins_max_line_len').Value
    local count_indent_characters = is_set('count_indent_characters')
    if count_indent_characters then
      result.right_margin = margin_value
    else
      result.max_text_width = margin_value
    end

    if skip_default_values then
      subtract_table(result, defaults)
    end

    return result
  end
