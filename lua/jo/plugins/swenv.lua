return {
  'AckslD/swenv.nvim',
  dependencies = {
    'stevearc/dressing.nvim',
  },
  config = function()
    local swenv = require 'swenv'
    swenv.setup {
      -- Should return a list of tables with a `name` and a `path` entry each.
      -- Gets the argument `venvs_path` set below.
      -- By default just lists the entries in `venvs_path`.
      get_venvs = function(venvs_path)
        return require('swenv.api').get_venvs(venvs_path)
      end,

      cond = function()
        return vim.bo.filetype == 'python'
      end,

      -- Path passed to `get_venvs`.
      venvs_path = vim.fn.expand '~/venvs',
      -- Something to do after setting an environment, for example call vim.cmd.LspRestart
      post_set_venv = function()
        vim.cmd 'LspRestart'
      end,
    }

    vim.keymap.set('n', '<leader>lpe', "cmd:lua require('swenv.api).pick_venv()<CR>", { desc = '[L]anguage [P]ython select [E]nvironment' })

    local wK = require 'which-key'
    wK.add {
      { '<leader>lp', group = '[L]anguage [P]ython' },
      { '<leader>lpe', desc = 'select [E]nvironment' },
    }

    local sApi = require 'swenv.api'
    vim.api.nvim_create_autocmd({ 'BufReadPre', 'FileType' }, {
      pattern = 'python',
      callback = function()
        local cur_env = sApi.get_current_venv()
        if cur_env == nil then
          local repo_name = vim.loop.cwd():match '([^/]+)$'
          sApi.set_venv(repo_name)
          if sApi.get_current_venv() == nil then
            sApi.pick_venv()
          end
        end
      end,
    })
  end,
}
