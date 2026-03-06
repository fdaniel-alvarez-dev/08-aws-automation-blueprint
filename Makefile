.PHONY: demo up down logs backup restore check gitops-validate security-validate test test-demo test-production

demo: up check backup
	@echo "Demo complete. Try: make logs"

up:
	docker compose up -d --build

down:
	docker compose down -v

logs:
	docker compose logs -f --tail=200

check:
	bash scripts/check_replication.sh

backup:
	bash scripts/backup.sh

restore:
	bash scripts/restore.sh

gitops-validate:
	@python3 scripts/gitops_validate.py

security-validate:
	@python3 scripts/security_validate.py

test: test-demo

test-demo:
	@TEST_MODE=demo python3 tests/run_tests.py

test-production:
	@TEST_MODE=production python3 tests/run_tests.py
