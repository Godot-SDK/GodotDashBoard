class_name BiLinRepo
const base_url = "https://pan.bilnn.cn/s/paGySE"
const repo_info = "此源为网盘源"
var aar_url = {
	"3.2.2" : "https://bilnn1.sharepoint.cn/sites/pan003/_layouts/15/download.aspx?UniqueId=8f80f78a-df51-4804-bde8-3dd18618781c&Translate=false&tempauth=eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIn0.eyJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvYmlsbm4xLnNoYXJlcG9pbnQuY25AN2MwZWNhMjAtYTE1Yi00MTJjLTg1MTAtZTI3MzFlZmU1MzMxIiwiaXNzIjoiMDAwMDAwMDMtMDAwMC0wZmYxLWNlMDAtMDAwMDAwMDAwMDAwIiwibmJmIjoiMTY1ODY2ODQ0MyIsImV4cCI6IjE2NTg2NzIwNDMiLCJlbmRwb2ludHVybCI6InBrRmNaczMvYWd5UHNvRm5lSU9aRTA0R2p5RlcwakhoT2I0YUZ0eW40RTQ9IiwiZW5kcG9pbnR1cmxMZW5ndGgiOiIxMjkiLCJpc2xvb3BiYWNrIjoiVHJ1ZSIsImNpZCI6IllqZG1NelJpT1RjdFkyUTJNaTAwTUdSaUxXSmxZamN0WkdWbE9UaGlaRGcwWmpobCIsInZlciI6Imhhc2hlZHByb29mdG9rZW4iLCJzaXRlaWQiOiJNalkzT1dFMU1ETXRaamd5TmkwME5HUXdMVGswTVdVdE9HWm1PRFpqTWpFME9UbGwiLCJhcHBfZGlzcGxheW5hbWUiOiJwYW5fc3AiLCJzaWduaW5fc3RhdGUiOiJbXCJrbXNpXCJdIiwiYXBwaWQiOiI4YjQxYTE2Mi02MmE4LTQ0ZTgtYjBhNi1jOTExMGExOWE1ZDciLCJ0aWQiOiI3YzBlY2EyMC1hMTViLTQxMmMtODUxMC1lMjczMWVmZTUzMzEiLCJ1cG4iOiJhZG1pbkBiaWxubjEucGFydG5lci5vbm1zY2hpbmEuY24iLCJwdWlkIjoiMTAwMzMyMzBDNTVDQjIyNiIsImNhY2hla2V5IjoiMGguZnxtZW1iZXJzaGlwfDEwMDMzMjMwYzU1Y2IyMjZAbGl2ZS5jb20iLCJzY3AiOiJhbGxmaWxlcy53cml0ZSIsInR0IjoiMiIsInVzZVBlcnNpc3RlbnRDb29raWUiOm51bGwsImlwYWRkciI6IjQwLjcyLjc0LjE5MiJ9.M0RtQVNhNjVLQ0ZuMXNiN3B3elhkK2puL3BVWlA2c1JGUlhPU082dFZRYz0&ApiVersion=2.0",
	"3.4.2" : "https://bilnn1.sharepoint.cn/sites/pan003/_layouts/15/download.aspx?UniqueId=80a53a7b-69c3-4fd1-9883-5594cc94d18f&Translate=false&tempauth=eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIn0.eyJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvYmlsbm4xLnNoYXJlcG9pbnQuY25AN2MwZWNhMjAtYTE1Yi00MTJjLTg1MTAtZTI3MzFlZmU1MzMxIiwiaXNzIjoiMDAwMDAwMDMtMDAwMC0wZmYxLWNlMDAtMDAwMDAwMDAwMDAwIiwibmJmIjoiMTY1ODY2ODQ4NSIsImV4cCI6IjE2NTg2NzIwODUiLCJlbmRwb2ludHVybCI6InRsRXVtbmUvV1BnK1JuSWFqSnlydFA3VEN0b0czazcrZUFWckgzTE8vVk09IiwiZW5kcG9pbnR1cmxMZW5ndGgiOiIxMjkiLCJpc2xvb3BiYWNrIjoiVHJ1ZSIsImNpZCI6Ik5XWXlZbU0wTURrdE5EWXdNeTAwTTJOakxXRTRaV1F0TkdRMU9HSTNPVFkzWkdVdyIsInZlciI6Imhhc2hlZHByb29mdG9rZW4iLCJzaXRlaWQiOiJNalkzT1dFMU1ETXRaamd5TmkwME5HUXdMVGswTVdVdE9HWm1PRFpqTWpFME9UbGwiLCJhcHBfZGlzcGxheW5hbWUiOiJwYW5fc3AiLCJzaWduaW5fc3RhdGUiOiJbXCJrbXNpXCJdIiwiYXBwaWQiOiI4YjQxYTE2Mi02MmE4LTQ0ZTgtYjBhNi1jOTExMGExOWE1ZDciLCJ0aWQiOiI3YzBlY2EyMC1hMTViLTQxMmMtODUxMC1lMjczMWVmZTUzMzEiLCJ1cG4iOiJhZG1pbkBiaWxubjEucGFydG5lci5vbm1zY2hpbmEuY24iLCJwdWlkIjoiMTAwMzMyMzBDNTVDQjIyNiIsImNhY2hla2V5IjoiMGguZnxtZW1iZXJzaGlwfDEwMDMzMjMwYzU1Y2IyMjZAbGl2ZS5jb20iLCJzY3AiOiJhbGxmaWxlcy53cml0ZSIsInR0IjoiMiIsInVzZVBlcnNpc3RlbnRDb29raWUiOm51bGwsImlwYWRkciI6IjQwLjcyLjc0LjE5MiJ9.VUNkUnVhb2o4bDdRZEV5eWx2RFpoQjBoSDZtcXZrRDd3dWEyYW1ZcGEwQT0&ApiVersion=2.0",
	"3.4.4" : "https://bilnn1.sharepoint.cn/sites/pan003/_layouts/15/download.aspx?UniqueId=1bd883ba-fe69-46c4-9ed3-693c6b6be7ce&Translate=false&tempauth=eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIn0.eyJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvYmlsbm4xLnNoYXJlcG9pbnQuY25AN2MwZWNhMjAtYTE1Yi00MTJjLTg1MTAtZTI3MzFlZmU1MzMxIiwiaXNzIjoiMDAwMDAwMDMtMDAwMC0wZmYxLWNlMDAtMDAwMDAwMDAwMDAwIiwibmJmIjoiMTY1ODY2ODAyNyIsImV4cCI6IjE2NTg2NzE2MjciLCJlbmRwb2ludHVybCI6IkNZa3F3SHp3dkpFMk1ZZ29TdzF0bU50NkZsN1kwVlpvZm9Ec01CVlAvUE09IiwiZW5kcG9pbnR1cmxMZW5ndGgiOiIxMjkiLCJpc2xvb3BiYWNrIjoiVHJ1ZSIsImNpZCI6Ik5XTXdOVFZrTTJVdE1XWTRZeTAwWlRrNUxUa3pNREl0TUdSbE4yTmtOR1UxTURoaCIsInZlciI6Imhhc2hlZHByb29mdG9rZW4iLCJzaXRlaWQiOiJNalkzT1dFMU1ETXRaamd5TmkwME5HUXdMVGswTVdVdE9HWm1PRFpqTWpFME9UbGwiLCJhcHBfZGlzcGxheW5hbWUiOiJwYW5fc3AiLCJzaWduaW5fc3RhdGUiOiJbXCJrbXNpXCJdIiwiYXBwaWQiOiI4YjQxYTE2Mi02MmE4LTQ0ZTgtYjBhNi1jOTExMGExOWE1ZDciLCJ0aWQiOiI3YzBlY2EyMC1hMTViLTQxMmMtODUxMC1lMjczMWVmZTUzMzEiLCJ1cG4iOiJhZG1pbkBiaWxubjEucGFydG5lci5vbm1zY2hpbmEuY24iLCJwdWlkIjoiMTAwMzMyMzBDNTVDQjIyNiIsImNhY2hla2V5IjoiMGguZnxtZW1iZXJzaGlwfDEwMDMzMjMwYzU1Y2IyMjZAbGl2ZS5jb20iLCJzY3AiOiJhbGxmaWxlcy53cml0ZSIsInR0IjoiMiIsInVzZVBlcnNpc3RlbnRDb29raWUiOm51bGwsImlwYWRkciI6IjQwLjcyLjc0LjE5MiJ9.NGFVZzYxK29rOFdLNUZhd1VqT1JpQzFjMEhRUmZTMy9Hbll6b3lSYWpZdz0&ApiVersion=2.0"
}