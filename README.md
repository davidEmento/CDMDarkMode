# CDM Dark Mode

Darkens the Cooldown Manager icons during GCD.

## AddOn Info
- Interface: 120000
- Title: CDM Dark Mode
- Author: Gladarg
- SavedVariables: `CDMDarkModeDB`
- CurseForge Project ID: `1440051`

## Installation
- Copy the `CDMDarkMode` folder into your WoW `Interface/AddOns` directory.

## Release Workflow
- GitHub Actions triggers on pushing a Git tag (e.g. `v1.0.1`).
- The workflow uses `BigWigsMods/packager@v2` to build and upload to CurseForge.
- Ensure the repo has the secret `CF_API_KEY` set in GitHub:
  - Settings → Secrets and variables → Actions → New secret → Name `CF_API_KEY`.

## Versioning
- The `.toc` uses `@project-version@` and is automatically replaced by the tag version.
- To release:
  1. Update code.
  2. Create a tag and push:
     ```powershell
     Push-Location "d:\CDMDarkMode"
     git tag v1.0.1
     git push origin v1.0.1
     ```

## Packaging Notes
- `.pkgmeta` configures packaging and ignores repo-only files.
- The `X-Curse-Project-ID` in `.toc` points uploads to the correct CurseForge project.

## Links
- GitHub: https://github.com/davidEmento/CDMDarkMode
- CurseForge: https://www.curseforge.com/wow/addons/cdm-dark-mode (ensure this matches the project ID)
