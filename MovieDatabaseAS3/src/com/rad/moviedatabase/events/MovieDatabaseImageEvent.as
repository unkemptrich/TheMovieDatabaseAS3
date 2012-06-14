package com.rad.moviedatabase.events
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class MovieDatabaseImageEvent extends Event
	{
		
		public static const ON_PROGRESS:String = "onProgress";
		public static const ON_COMPLETE:String = "onComplete";
		
		private var _bytesLoaded:Number;
		private var _bytesTotal:Number;
		private var _content:Bitmap;
		
		public function MovieDatabaseImageEvent(type:String, bytesLoaded:Number = 0, bytesTotal:Number = 0, content:Bitmap = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_bytesLoaded = bytesLoaded;
			_bytesTotal = bytesTotal;
			_content = content;
			
		}

		public function get content():Bitmap
		{
			return _content;
		}

		public function get bytesTotal():Number
		{
			return _bytesTotal;
		}

		public function get bytesLoaded():Number
		{
			return _bytesLoaded;
		}
		
		override public function clone():Event
		{
			return new MovieDatabaseImageEvent(type, bytesLoaded, bytesTotal, content);
		}

	}
}