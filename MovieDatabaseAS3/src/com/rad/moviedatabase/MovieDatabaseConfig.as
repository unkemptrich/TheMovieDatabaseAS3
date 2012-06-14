package com.rad.moviedatabase
{
	public class MovieDatabaseConfig
	{
		public static const BASE_URL:String = "http://cf2.imgobject.com/t/p/";	
		public static const DEFAULT_BACKDROP_SIZE:String = "w780";
		public static const DEFAULT_POSTER_SIZE:String = "w500";
		public static const DEFAULT_PROFILE_SIZE:String = "h632";

		private var _backdropSizes:Array = ["w300", "w780", "w1280", "original"];
		private var _posterSizes:Array = ["w92", "w154", "w185", "w342", "w500", "original"];
		private var _profileSizes:Array = ["w45", "w185", "h632", "original"];
		
		private var _backdropSize:String = "w780";
		private var _posterSize:String = "w500";
		private var _profileSize:String = "h632";
		
		public function MovieDatabaseConfig()
		{
			
		}
		
		public function get profileSize():String
		{
			return _profileSize;
		}

		public function set profileSize(value:String):void
		{
			_profileSize = value;
		}

		public function get posterSize():String
		{
			return _posterSize;
		}

		public function set posterSize(value:String):void
		{
			_posterSize = value;
		}

		public function get backdropSize():String
		{
			return _backdropSize;
		}

		public function set backdropSize(value:String):void
		{
			_backdropSize = value;
		}

		public function get profileSizes():Array
		{
			return _profileSizes;
		}

		public function get posterSizes():Array
		{
			return _posterSizes;
		}

		public function get backdropSizes():Array
		{
			return _backdropSizes;
		}

	}
}