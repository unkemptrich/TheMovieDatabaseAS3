package com.rad.moviedatabase.events
{
	import flash.events.Event;
	
	public class MovieDatabaseResultEvent extends Event
	{
		public static const SEARCH_BY_TITLE:String = "searchByTitle";
		public static const SEARCH_BY_PEOPLE:String = "searchByPeople";
		public static const COLLECTION_INFO:String = "collectionInfo";
		public static const MOVIE_INFO:String = "movieInfo";
		public static const ALTERNATE_MOVIE_TITLES:String = "alternateMovieTitles";
		public static const MOVIE_CAST:String = "movieCast";
		public static const MOVIE_IMAGES:String = "movieImages";
		public static const MOVIE_KEYWORDS:String = "movieKeywords";
		public static const MOVIE_RELEASE_INFO:String = "movieReleaseInfo";
		public static const MOVIE_TRAILERS:String = "movieTrailers";
		public static const MOVIE_TRANSLATIONS:String = "movieTranslations";
		public static const SIMILAR_MOVIES:String = "similarMovies";
		public static const PERSON_INFO:String = "personInfo";
		public static const PERSON_CREDITS:String = "personCredits";
		public static const PERSON_IMAGES:String = "personImages";
		public static const MOVIES_IN_THEATRES:String = "moviesInTheatres";
		public static const POPULAR_MOVIES:String = "popularMovies";
		public static const TOP_RATED_MOVIES:String = "topRatedMovies";
		
		private var _result:Object;
		
		public function MovieDatabaseResultEvent(type:String, result:Object = null, bubbles:Boolean=false,  cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_result = result;
		}
		
		public function get result():Object
		{
			return _result;
		}
		
		override public function clone():Event
		{
			return new MovieDatabaseResultEvent(type, result);
		}
	}
}