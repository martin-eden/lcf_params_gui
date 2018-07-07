#!/usr/bin/env lua

require('workshop.base')

package.path = package.path .. ';./tek_project/?.lua'

local ui = require('tek.ui')

local group =
  function(name, ...)
    local result =
      ui.Group:new(
        {
          Orientation = 'vertical',
          Width = 'fill',
          Legend = '',
        }
      )
    result.Legend = name
    result.Children = {...}

    return result
  end

local h_group =
  function(header, ...)
    local result = group(header, ...)
    result.Orientation = 'horizontal'
    return result
  end

local v_group =
  function(header, ...)
    local result = group(header, ...)
    result.Orientation = 'vertical'
    return result
  end

local populate_params = request('lcf_params_gui.populate_params')
local generate_snippet = request('lcf_params_gui.generate_snippet')
local app

local command_line_text =
  -- ui.FloatText:new(
  -- ui.Text:new(
  ui.Input:new(
    {
      Style = 'font:ui-fixed',
    }
  )

local update_command_line_text =
  function()
    local config_params = populate_params(app)
    local snippet = generate_snippet(config_params)
    command_line_text:setValue('Text', snippet)
  end

local add_notification =
  function(obj, event_name, handler)
    assert_table(obj)
    assert_string(event_name)
    assert_function(handler)
    obj:addNotify(
      event_name,
      ui.NOTIFY_ALWAYS,
      {
        ui.NOTIFY_SELF,
        ui.NOTIFY_FUNCTION,
        handler,
      }
    )
  end

local rb =
  function(params)
    local result = ui.RadioButton:new(params)
    add_notification(result, 'Selected', update_command_line_text)
    return result
  end

local cm =
  function(id, value, text)
    local params =
      {
        Id = id,
        Text = text,
        Selected = value,
      }
    local result = ui.CheckMark:new(params)
    add_notification(result, 'Selected', update_command_line_text)
    return result
  end

local default_slider_value = 96

local slider_value =
  ui.Text:new(
    {
      Text = default_slider_value,
      Width = 'fill',
    }
  )

local slider =
  ui.ScrollBar:new(
    {
      Id = 'margins_max_line_len',
      Kind = 'number',
      Min = 15,
      Max = 200,
      Width = 'free',
      Step = 1,
      Value = default_slider_value,
    }
  )

add_notification(
  slider,
  'Value',
  function(_)
    slider_value:setValue('Text', slider.Value)
    update_command_line_text()
  end
)

local group_comments =
  v_group(
    'comments',
    cm('keep_comments', true, 'Keep comments')
  )

local group_unparsed_text =
  v_group(
    'unparsed text',
    cm('keep_unparsed_text', true, 'Keep unparsed text')
  )

local group_indent =
  v_group(
    'indent chunk',
    rb({Text = 'tabulation', Id = 'indent_tab'}),
    rb({Text = 'no indent', Id = 'indent_spc_0'}),
    rb({Text = '1 space', Id = 'indent_spc_1'}),
    rb({Text = '2 spaces', Id = 'indent_spc_2', Selected = true}),
    rb({Text = '3 spaces', Id = 'indent_spc_3'}),
    rb({Text = '4 spaces', Id = 'indent_spc_4'})
  )

local group_margins =
  v_group(
    'margins',
    h_group(
      'Max line length',
      slider_value,
      slider
    ),
    cm('count_indent_characters', true, 'Count indent characters')
  )
group_margins.MinWidth = 400

local group_command_line =
  ui.ScrollGroup:new(
    {
      HSliderMode = 'off',
      VSliderMode = 'off',
      Child =
        ui.Canvas:new(
          {
            AutoWidth = true,
            AutoHeight = true,
            Child = command_line_text,
          }
        ),
    }
  )

local group_main =
  v_group(
    nil,
    h_group(
      nil,
      group_indent,
      group_margins,
      group_comments,
      group_unparsed_text
    ),
    v_group(
      'Command line to type',
      group_command_line
    )
  )

local window =
  ui.Window:new(
    {
      Id = 'choices-window',
      Title = '`lua.reformat` command-line parameters generator',
      Status = 'hide',
      HideOnEscape = true,
      SizeButton = true,
      Orientation = 'horizontal',
      Children =
        {
          group_main,
        },
    }
  )

app = ui.Application:new()
ui.Application.connect(window)
app:addMember(window)
window:setValue('Status', 'show')

update_command_line_text()

app:run()

local config_params = populate_params(app)
print(generate_snippet(config_params))
