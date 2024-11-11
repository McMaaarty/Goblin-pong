extends Node

var signals = {}
	
func emit_event(event_name: String, data = null) :
	if event_name in signals :
		for callback in signals[event_name]:
			if data == null :
				callback.call()
			else : 
				callback.callv(data)

func subscribe(event_name : String, callback: Callable) :
	if event_name not in signals:
		signals[event_name] = []
	
	signals[event_name].append(callback)
	
func unsubscribe(event_name : String, callback : Callable) :
	if event_name in signals :
		signals[event_name].erase(callback)
