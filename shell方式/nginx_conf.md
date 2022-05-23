## 1.http

	#webp
	map $http_accept $webp_suffix {
	    default "";
	    "~*webp" ".webp";
	}
## 2.server

```shell
set $webp_suffix "";

if ($http_accept ~* "webp") {
	set $webp_suffix ".webp";
}
location ~ \.(gif|jpg|png)$ {
	add_header Vary "Accept-Encoding";
	try_files $uri$webp_suffix $uri $uri/ =404;
}
```

