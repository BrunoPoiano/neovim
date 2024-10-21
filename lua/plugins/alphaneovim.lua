return {
  "goolord/alpha-nvim",
  -- dependencies = { 'echasnovski/mini.icons' },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local startify = require("alpha.themes.startify")

    startify.section.header.val = {
      [[#        ___           ___           ___                                      ___      #]],
      [[#       /  /\         /  /\         /  /\          ___            ___        /  /\     #]],
      [[#      /  /::|       /  /::\       /  /::\        /  /\          /__/\      /  /::|    #]],
      [[#     /  /:|:|      /  /:/\:\     /  /:/\:\      /  /:/          \__\:\    /  /:|:|    #]],
      [[#    /  /:/|:|__   /  /::\ \:\   /  /:/  \:\    /  /:/           /  /::\  /  /:/|:|__  #]],
      [[#   /__/:/ |:| /\ /__/:/\:\ \:\ /__/:/ \__\:\  /__/:/  ___    __/  /:/\/ /__/:/_|::::\ #]],
      [[#   \__\/  |:|/:/ \  \:\ \:\_\/ \  \:\ /  /:/  |  |:| /  /\  /__/\/:/~~  \__\/  /~~/:/ #]],
      [[#       |  |:/:/   \  \:\ \:\    \  \:\  /:/   |  |:|/  /:/  \  \::/           /  /:/  #]],
      [[#       |__|::/     \  \:\_\/     \  \:\/:/    |__|:|__/:/    \  \:\          /  /:/   #]],
      [[#       /__/:/       \  \:\        \  \::/      \__\::::/      \__\/         /__/:/    #]],
      [[#       \__\/         \__\/         \__\/           ~~~~                     \__\/     #]],
    }

    startify.file_icons.provider = "devicons"
    require("alpha").setup(startify.config)
  end,
}
