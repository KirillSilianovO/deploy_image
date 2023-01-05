# Deploy Image ##

## Commands ##
### Build ###
```bash
docker build -t kirillsilianov/deploy-image:0.10 -t kirillsilianov/deploy-image:latest .
```

### Push ###
```bash
docker push kirillsilianov/deploy-image --all-tags
```