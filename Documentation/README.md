**Build your documentation:**

- Navigate to your project's root directory in your terminal.

- Run the following command to build your MkDocs site:

  Bash

  ```
  mkdocs build
  ```

   Use code [with caution.]()

  - This generates the static website files in the `site` directory.

**Deploy to GitHub Pages:**

- Run the following command to deploy your site:

  Bash

  ```
  mkdocs gh-deploy
  ```

   Use code [with caution.]()

  - This command does the following:
    - Builds your documentation (if not already built).
    - Uses the `ghp-import` tool to commit the built files to the `gh-pages` branch.
    - Pushes the `gh-pages` branch to your GitHub repository.