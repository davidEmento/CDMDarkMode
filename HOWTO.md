# CDMDarkMode: Release Cheat Sheet

Follow these steps to publish a new version to CurseForge via GitHub Actions.

## Prerequisites
- Repo secret `CF_API_KEY` is set in GitHub → Settings → Secrets and variables → Actions.
- `.toc` version is tokenized as `@project-version@` in [CDMDarkMode.toc](CDMDarkMode.toc); no manual version bump needed.
- Project ID is present: `## X-Curse-Project-ID: 1440051` in [CDMDarkMode.toc](CDMDarkMode.toc).

## 1) Make Your Changes
- Edit files as needed, e.g. [Core.lua](Core.lua).
- Optional: Update README or other docs.

## 2) Commit Your Changes
Use PowerShell from the repo folder.

```powershell
Push-Location "d:\CDMDarkMode"
git status
git add .
git commit -m "Update functionality and docs"
```

## 3) Tag The Release
- Tags trigger the GitHub Actions workflow to build and upload.
- Use semantic tags like `v1.0.2`.

```powershell
git tag v1.0.2
git push origin main
git push origin v1.0.2
```

## 4) Verify The CI Run
- GitHub UI: go to [Actions](https://github.com/davidEmento/CDMDarkMode/actions) → "Release AddOn" → check the latest run for your tag.
- Optional CLI (if `gh` is in PATH):

```powershell
# Show recent runs
gh run list --workflow "Release AddOn" --limit 5
# Watch the latest run by ID and exit non-zero on failure
gh run watch <run-id> --exit-status
```

- Optional CLI (if `gh` is not in PATH), use the full path:

```powershell
# Show recent runs by workflow name
& "C:\Program Files\GitHub CLI\gh.exe" run list --workflow "Release AddOn" --limit 5
# Watch a specific run by ID
& "C:\Program Files\GitHub CLI\gh.exe" run watch <run-id> --exit-status
```

## 5) Confirm On CurseForge
- After success, the zip is uploaded to your CurseForge project (ID `1440051`).
- Ensure the file is marked as "Release" and the game version matches (retail 12.0.0).

## Notes
- Version substitution: The packager replaces `@project-version@` in [CDMDarkMode.toc](CDMDarkMode.toc) with the tag (e.g., `v1.0.2` → `1.0.2`).
- Packaging ignores repo-only files via [.pkgmeta](.pkgmeta) and [.gitignore](.gitignore).
- Changelog: Generated automatically from commit history for the tag.

## Fix Mistakes (Tag/Commit)
```powershell
# Delete a wrong tag locally and remotely
git tag -d v1.0.2
git push origin :refs/tags/v1.0.2

# Amend last commit message
git commit --amend -m "Corrected message"
# Force push only if necessary (coordinate if collaborating)
git push --force-with-lease
```

## Optional Enhancements
- Create GitHub Releases and attach the zip.
- Add additional distribution targets (WoWInterface/Wago) by including keys and packager args.
 - Add a shortcut: pin the [Actions](https://github.com/davidEmento/CDMDarkMode/actions) page and your CurseForge project page for quick checks.
