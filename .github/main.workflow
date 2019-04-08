workflow "Publish GitHub Pages" {
  on = "push"
  resolves = ["publish"]
}

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@e96fd9a"
  args = "branch master"
}

action "Install publish dependencies" {
  uses = "docker://node:11-alpine"
  runs = "yarn install --frozen-lockfile"
  needs = ["Filters for GitHub Actions"]
}

action "Build Project" {
  uses = "docker://node:11-alpine"
  runs = "yarn run build"
  needs = ["Install publish dependencies"]
}

action "publish" {
  uses = "xiaoxiangmoe/gh-pages-action@master"
  needs = ["Build Project"]
  secrets = ["GITHUB_TOKEN"]
  args = "--dist=build"
}


workflow "Publish on new member issue" {
  on = "issues"
  resolves = ["Update commit"]
}

action "Install issue dependencies" {
  uses = "docker://node:11-alpine"
  runs = "yarn install --frozen-lockfile"
}

action "Update commit" {
  uses = "docker://node:11-alpine"
  secrets = ["GITHUB_TOKEN"]
  runs = "yarn workspace filter-issue run start"
  needs = ["Install issue dependencies"]
}
