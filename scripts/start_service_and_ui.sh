nohup conda run --live-stream -n WavJourney python services.py > services_logs/service.out 2>&1 &
conda run --live-stream -n WavJourney python -u ui_client.py 2>&1 | stdbuf -oL tee services_logs/wavejourney.out