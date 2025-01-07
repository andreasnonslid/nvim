return {
    "andreasnonslid/justlists",
    config = function()
      require("justlists").setup({
        list = { "My First Task", "Another Task" }, -- Custom initial list
      })
    end,
  }
