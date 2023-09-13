describe('flake8', function()
  it('can lint', function()
    local ft = require('guard.filetype')
    ft('python'):lint('flake8')
    require('guard').setup()

    local diagnostics = require('test.linter.helper').test_with('python', {
      [[import os]],
      [[]],
      [[def foo(n):]],
      [[    if n == 0:]],
      [[         return  bar]],
      [[print('too long sentence to be displayed in one line blah blah blah blah blah blah blah blah blah blah blah blah blah')]],
    })
    assert.are.same({
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 0,
        lnum = 0,
        message = "'os' imported but unused [401]",
        namespace = 4,
        severity = 3,
        source = 'flake8',
      },
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 2,
        lnum = 2,
        message = 'expected 2 blank lines, found 1 [302]',
        namespace = 4,
        severity = 1,
        source = 'flake8',
      },
      {
        bufnr = 3,
        col = 14,
        end_col = 14,
        end_lnum = 4,
        lnum = 4,
        message = 'multiple spaces after keyword [271]',
        namespace = 4,
        severity = 1,
        source = 'flake8',
      },
      {
        bufnr = 3,
        col = 16,
        end_col = 16,
        end_lnum = 4,
        lnum = 4,
        message = "undefined name 'bar' [821]",
        namespace = 4,
        severity = 3,
        source = 'flake8',
      },
      {
        bufnr = 3,
        col = 19,
        end_col = 19,
        end_lnum = 4,
        lnum = 4,
        message = 'trailing whitespace [291]',
        namespace = 4,
        severity = 2,
        source = 'flake8',
      },
    }, diagnostics)
  end)
end)
