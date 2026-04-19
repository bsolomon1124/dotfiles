The file `image_list.txt` is a list of commonly-used Docker images for download:

```bash
failed=()
while read -r img || [[ -n "$img" ]]; do
  [[ -z "$img" || "$img" =~ ^[[:space:]]*# ]] && continue
  docker image pull "$img" || failed+=("$img")
done < "$(dirname "$0")/image_list.txt"

docker image ls
if (( ${#failed[@]} )); then
  printf 'FAILED: %s\n' "${failed[@]}" >&2
  exit 1
fi
```
