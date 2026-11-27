"""Demo AI agent handler — example only, no live model call."""
import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def handler(event, context):
    body = event.get("body") or "{}"
    try:
        data = json.loads(body)
    except json.JSONDecodeError:
        data = {}
    prompt = str(data.get("prompt", ""))[:500]
    # Log that a request happened, never log the full prompt or any secret.
    logger.info("demo agent request received, prompt length=%s", len(prompt))
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({
            "reply": "This is a demo reply from the AgentCare example setup. "
                     "In a real setup this is where the agent would answer, "
                     "with limits, logging and a spending control in place.",
            "prompt_length": len(prompt),
        }),
    }
