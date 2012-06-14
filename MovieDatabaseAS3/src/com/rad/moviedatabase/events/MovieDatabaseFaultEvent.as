package com.rad.moviedatabase.events
{
	import com.rad.moviedatabase.loader.ServiceFault;
	
	import flash.events.Event;

	public class MovieDatabaseFaultEvent extends Event
	{
	
		public static const FAULT:String = "fault";

		private var _fault:com.rad.moviedatabase.loader.ServiceFault;
	
		public function get fault():ServiceFault{ return _fault; }

		private var _serviceType:String;
	
		public function get serviceType():String { return _serviceType; }
	
		public function MovieDatabaseFaultEvent(type:String, fault:ServiceFault = null, serviceType:String = null)
		{
			super(type);
			_fault = fault;
			_serviceType = serviceType;
		}

		override public function clone():Event
		{
			return new MovieDatabaseFaultEvent(type, fault, serviceType);
		}

	}
}