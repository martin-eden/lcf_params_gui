local workshop_path = '../../../../workshop/?.lua'
package.path = package.path .. ';' .. workshop_path

require('base')

local create_deploy_script = request('!.system.create_deploy_script')

local used_modules =
  {
    'base',
    'lcf_params_gui',
  }

create_deploy_script(used_modules)
