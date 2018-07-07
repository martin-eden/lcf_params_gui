#!/usr/bin/env lua

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

local rb =
  function(params)
    return ui.RadioButton:new(params)
  end

local cm =
  function(params)
    return ui.CheckMark:new(params)
  end

local default_slider_value = 120

local slider_value =
  ui.Text:new(
    {
      Id = 'margins_max_line_len_text',
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

slider:addNotify(
  'Value',
  ui.NOTIFY_ALWAYS,
  {
    ui.NOTIFY_ID,
    'margins_max_line_len_text',
    'setValue',
    'Text',
    ui.NOTIFY_VALUE,
  }
)

local window =
  ui.Window:new(
    {
      Id = 'choices-window',
      Title = ui.ProgName,
      Status = 'hide',
      HideOnEscape = true,
      SizeButton = true,
      Orientation = 'horizontal',
      Children =
        {
          slider_value,
          slider,
        },
    }
  )

local app = ui.Application:new()
ui.Application.connect(window)
app:addMember(window)
window:setValue('Status', 'show')

app:run()

package.path = package.path .. ';../../../workshop/?.lua'
require('base')
local t2s = request('!.table.as_string')

local test_object = app:getById('margins_max_line_len')
print(t2s(test_object))
