# action-release-branch

Removes source files, then pushes a commit to the release branch.

## Inputs

### `email`

**Required** Email address to associate with the release commit.

### `username`

**Required** GitHub username to associate with the release commit.

### `token`

**Optional** A [GitHub token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token) with the `repo` scope, or with the `contents: write` fine-grained permission. By default, [`token` from the `github` context](https://docs.github.com/en/actions/learn-github-actions/contexts#github-context) is used, but this [GitHub Actions-provided token](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#about-the-github_token-secret) is scoped to the repo containing your workflow. If you are releasing another repo, you must provide `GITHUB_TOKEN`.

### `release_branch`

**Optional** Release branch name. Default: `"dist"`.

## Example usage

```YAML
- name: Update release branch
  uses: smockle/action-release-branch@main
  with:
    email: ${{ secrets.EMAIL }}
    username: ${{ secrets.USERNAME }}
```
