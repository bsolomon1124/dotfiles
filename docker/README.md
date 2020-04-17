The file `image_list.txt` is a list of commonly-used Docker images for download:

```bash
while read img; do
  if [[ -n "$img" ]]; then
    echo "PULLING: $img"
    docker pull "$img"
  fi
done <image_list.txt

docker image ls -a
```
