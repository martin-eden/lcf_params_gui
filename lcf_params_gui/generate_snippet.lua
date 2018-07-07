local result =
  function(config_params)
    local result = {'lua.reformat'}

    local add =
      function(value)
        table.insert(result, value)
      end

    if config_params.indent_chunk then
      local indent_chunk_str
      do
        --[[
          Quote string of spaces or tab for bash command-line.

          (Worth creating special function in future.)

          Source info about bash quoting:

            http://www.gnu.org/software/bash/manual/html_node/
            ANSI_002dC-Quoting.html#ANSI_002dC-Quoting
        ]]
        if (config_params.indent_chunk == '\t') then
          indent_chunk_str = [[$'\t']]
        else
          indent_chunk_str = '"' .. config_params.indent_chunk .. '"'
        end
        indent_chunk_str = '--indent=' .. indent_chunk_str
      end
      add(indent_chunk_str)
    end

    if config_params.right_margin then
      add('--right-margin=' .. config_params.right_margin)
    end

    if config_params.max_text_width then
      add('--max-text-width=' .. config_params.max_text_width)
    end

    if is_boolean(config_params.keep_comments) then
      if config_params.keep_comments then
        add('--keep-comments')
      else
        add('--~keep-comments')
      end
    end

    -- Paramenter name ends in "tail", variable name ends in "text".
    if is_boolean(config_params.keep_unparsed_text) then
      if config_params.keep_unparsed_text then
        add('--keep-unparsed-tail')
      else
        add('--~keep-unparsed-tail')
      end
    end

    result = table.concat(result, ' ')

    return result
  end

return result
