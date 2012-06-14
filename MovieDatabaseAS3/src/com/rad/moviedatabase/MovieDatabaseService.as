package com.rad.moviedatabase
{
	import com.rad.moviedatabase.events.MovieDatabaseFaultEvent;
	import com.rad.moviedatabase.events.MovieDatabaseImageEvent;
	import com.rad.moviedatabase.events.MovieDatabaseResultEvent;
	import com.rad.moviedatabase.loader.MovieDatabaseLoader;
	import com.rad.moviedatabase.loader.ServiceFault;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	[Event(name="searchByTitle", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="searchByPeople", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="collectionInfo", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="movieInfo", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="alternateMovieTitles", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	
	[Event(name="movieCast", type="com.rad.moviedatabase.MovieDatabaseResultEvent")]
	[Event(name="movieImages", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="movieKeywords", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="movieReleaseInfo", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	
	[Event(name="movieTrailers", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="movieTranslations", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="similarMovies", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="personInfo", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="personCredits", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="personImages", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="moviesInTheatres", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="popularMovies", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	[Event(name="topRatedMovies", type="com.rad.moviedatabase.events.MovieDatabaseResultEvent")]
	
	[Event(name="backdropImage", type="com.rad.moviedatabase.events.MovieDatabaseImageEvent")]
	[Event(name="posterImage", type="com.rad.moviedatabase.events.MovieDatabaseImageEvent")]
	[Event(name="profileImage", type="com.rad.moviedatabase.events.MovieDatabaseImageEvent")]
	
	public class MovieDatabaseService extends EventDispatcher
	{
		public static const MOVIE_DB_BASE_URL:String = "http://api.themoviedb.org/3/";
		
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
		
		public static const ON_PROGRESS:String = "onProgress";
		public static const ON_COMPLETE:String = "onComplete";
		
		private var _urlLoaders:Vector.<MovieDatabaseLoader>;
		private var _inUseLoaders:Object;
		private var _imgLoader:Loader;
		private var _loader:MovieDatabaseLoader;
		public var api_key:String;
		
		public function MovieDatabaseService()
		{
			super();
		}
		
		/////////
		// PUBLIC METHODES
		/////////
		public function searchByTitle(title:String, page:int=1, includeAdult:Boolean = false):void
		{
			var url:String = MOVIE_DB_BASE_URL+"search/movie?query="+title+"&api_key="+api_key+"&page="+page+"&include_adult="+includeAdult;
			_loader =  _getUrlLoader(url);
			_loader.type = SEARCH_BY_TITLE;
			_loader.returnType = MovieDatabaseResultEvent.SEARCH_BY_TITLE;
			_loader.load(new URLRequest(url));
		}
		
		public function searchByPeople(name:String, page:int=1, includeAdult:Boolean = false):void
		{
			var url:String = MOVIE_DB_BASE_URL+"search/person?query="+name+"&api_key="+api_key+"&page="+page+"&include_adult="+includeAdult;
			_loader =  _getUrlLoader(url);
			_loader.type = SEARCH_BY_PEOPLE;
			_loader.returnType = MovieDatabaseResultEvent.SEARCH_BY_PEOPLE;
			_loader.load(new URLRequest(url));
		}
		
		public function getCollectionInfo(id:String):void
		{
			var url:String = MOVIE_DB_BASE_URL+"collection/"+id+"?api_key="+api_key;
			_loader =  _getUrlLoader(url);
			_loader.type = MOVIE_INFO;
			_loader.returnType = MovieDatabaseResultEvent.MOVIE_INFO;
			_loader.load(new URLRequest(url));
		}
		
		public function getMovieInfo(id:String):void
		{
			var url:String = MOVIE_DB_BASE_URL+"movie/"+id+"?api_key="+api_key;
			_loader =  _getUrlLoader(url);
			_loader.type = MOVIE_INFO;
			_loader.returnType = MovieDatabaseResultEvent.MOVIE_INFO;
			_loader.load(new URLRequest(url));	
		}
		
		public function getAlternateMovieTitles(id:String):void
		{
			var url:String = MOVIE_DB_BASE_URL+"movie/"+id+"alternative_titles?api_key="+api_key;
			_loader =  _getUrlLoader(url);
			_loader.type = ALTERNATE_MOVIE_TITLES;
			_loader.returnType = MovieDatabaseResultEvent.ALTERNATE_MOVIE_TITLES;
			_loader.load(new URLRequest(url));
		}
		
		public function getMovieCast(id:String):void
		{
			var url:String = MOVIE_DB_BASE_URL+"movie/"+id+"casts?api_key="+api_key;
			_loader =  _getUrlLoader(url);
			_loader.type = MOVIE_CAST;
			_loader.returnType = MovieDatabaseResultEvent.MOVIE_CAST;
			_loader.load(new URLRequest(url));
		}
		
		public function getMovieImages(id:String):void
		{
			var url:String = MOVIE_DB_BASE_URL+"movie/"+id+"images?api_key="+api_key;
			_loader =  _getUrlLoader(url);
			_loader.type = MOVIE_IMAGES;
			_loader.returnType = MovieDatabaseResultEvent.MOVIE_IMAGES;
			_loader.load(new URLRequest(url));
		}
		
		public function getMovieKeywords(id:String):void
		{
			var url:String = MOVIE_DB_BASE_URL+"movie/"+id+"keywords?api_key="+api_key;
			_loader =  _getUrlLoader(url);
			_loader.type = MOVIE_KEYWORDS;
			_loader.returnType = MovieDatabaseResultEvent.MOVIE_KEYWORDS;
			_loader.load(new URLRequest(url));
		}
		
		public function getMovieReleaseInfo(id:String):void
		{
			var url:String = MOVIE_DB_BASE_URL+"movie/"+id+"release?api_key="+api_key;
			_loader =  _getUrlLoader(url);
			_loader.type = MOVIE_RELEASE_INFO;
			_loader.returnType = MovieDatabaseResultEvent.MOVIE_RELEASE_INFO;
			_loader.load(new URLRequest(url));
		}
		
		public function getMovieTrailers(id:String):void
		{
			var url:String = MOVIE_DB_BASE_URL+"movie/"+id+"trailers?api_key="+api_key;
			_loader =  _getUrlLoader(url);
			_loader.type = MOVIE_TRAILERS;
			_loader.returnType = MovieDatabaseResultEvent.MOVIE_TRAILERS;
			_loader.load(new URLRequest(url));
		}
		
		public function getMovieTranslations(id:String):void
		{
			var url:String = MOVIE_DB_BASE_URL+"movie/"+id+"translations?api_key="+api_key;
			_loader =  _getUrlLoader(url);
			_loader.type = MOVIE_TRANSLATIONS;
			_loader.returnType = MovieDatabaseResultEvent.MOVIE_TRANSLATIONS;
			_loader.load(new URLRequest(url));
		}
		
		public function getSimilarMovies(id:String, page:int=1):void
		{
			var url:String = MOVIE_DB_BASE_URL+"movie/"+id+"similar_movies?api_key="+api_key+"&page="+page;
			_loader =  _getUrlLoader(url);
			_loader.type = SIMILAR_MOVIES;
			_loader.returnType = MovieDatabaseResultEvent.SIMILAR_MOVIES;
			_loader.load(new URLRequest(url));
		}
		
		public function getPersonInfo(id:String):void
		{
			var url:String = MOVIE_DB_BASE_URL+"person/"+id+"?api_key="+api_key;
			_loader =  _getUrlLoader(url);
			_loader.type = PERSON_INFO;
			_loader.returnType = MovieDatabaseResultEvent.PERSON_INFO;
			_loader.load(new URLRequest(url));
		}
		
		public function getPersonCredits(id:String):void
		{
			var url:String = MOVIE_DB_BASE_URL+"person/"+id+"/credits?api_key="+api_key;
			_loader =  _getUrlLoader(url);
			_loader.type = PERSON_CREDITS;
			_loader.returnType = MovieDatabaseResultEvent.PERSON_CREDITS;
			_loader.load(new URLRequest(url));
		}
		
		public function getPersonImages(id:String):void
		{
			var url:String = MOVIE_DB_BASE_URL+"person/"+id+"/images?api_key="+api_key;
			_loader =  _getUrlLoader(url);
			_loader.type = PERSON_IMAGES;
			_loader.returnType = MovieDatabaseResultEvent.PERSON_IMAGES;
			_loader.load(new URLRequest(url));
		}
		
		public function getMoviesInTheatres(page:int=1):void
		{
			var url:String = MOVIE_DB_BASE_URL+"movie/now-playing?api_key="+api_key+"&page="+page;
			_loader =  _getUrlLoader(url);
			_loader.type = MOVIES_IN_THEATRES;
			_loader.returnType = MovieDatabaseResultEvent.MOVIES_IN_THEATRES;
			_loader.load(new URLRequest(url));
		}
		
		public function getPopularMovies(page:int=1):void
		{
			var url:String = MOVIE_DB_BASE_URL+"movie/popular?api_key="+api_key+"&page="+page;
			_loader =  _getUrlLoader(url);
			_loader.type = POPULAR_MOVIES;
			_loader.returnType = MovieDatabaseResultEvent.POPULAR_MOVIES;
			_loader.load(new URLRequest(url));
		}
		
		public function getTopRatedMovies(page:int = 1):void
		{
			var url:String = MOVIE_DB_BASE_URL+"movie/top-rated?api_key="+api_key+"&page="+page;
			_loader =  _getUrlLoader(url);
			_loader.type = TOP_RATED_MOVIES;
			_loader.returnType = MovieDatabaseResultEvent.TOP_RATED_MOVIES;
			_loader.load(new URLRequest(url));
		}
		
		//////////
		// IMAGES
		//////////
		
		public function getBackdropImage(backdropPath:String, backdropSize:String = MovieDatabaseConfig.DEFAULT_BACKDROP_SIZE):void
		{
			var url:URLRequest = new URLRequest(MovieDatabaseConfig.BASE_URL+backdropSize+backdropPath+"?api_key="+api_key);
			if(_imgLoader)
			{
				_imgLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadProgress);
				_imgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
				_imgLoader.close();
				_imgLoader = null;
			}
			_imgLoader = new Loader();
			_imgLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress, false, 0, true);
			_imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete, false, 0, true);
			_imgLoader.load(url);
		}
		
		public function getPosterImage(posterPath:String, posterSize:String = MovieDatabaseConfig.DEFAULT_POSTER_SIZE):void
		{
			var url:URLRequest = new URLRequest(MovieDatabaseConfig.BASE_URL+posterSize+posterPath+"?api_key="+api_key);
			if(_imgLoader)
			{
				_imgLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadProgress);
				_imgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
				_imgLoader.close();
				_imgLoader = null;
			}
			_imgLoader = new Loader();
			_imgLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress, false, 0, true);
			_imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete, false, 0, true);
			_imgLoader.load(url);
		}
		
		public function getProfileImage(profilePath:String, profileSize:String = MovieDatabaseConfig.DEFAULT_PROFILE_SIZE):void
		{
			var url:URLRequest = new URLRequest(MovieDatabaseConfig.BASE_URL+profileSize+profilePath+"?api_key="+api_key);
			if(_imgLoader)
			{
				_imgLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadProgress);
				_imgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
				_imgLoader.close();
				_imgLoader = null;
			}
			_imgLoader = new Loader();
			_imgLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress, false, 0, true);
			_imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete, false, 0, true);
			_imgLoader.load(url);

		}
		protected function loadProgress(event:ProgressEvent):void
		{
			dispatchEvent(new MovieDatabaseImageEvent(MovieDatabaseImageEvent.ON_PROGRESS, event.bytesLoaded, event.bytesTotal));
		}
		protected function loadComplete(event:Event):void
		{
			dispatchEvent(new MovieDatabaseImageEvent(MovieDatabaseImageEvent.ON_COMPLETE,NaN,NaN,event.target.content));
		}
		///////////
		// HANDLERS
		//////////
		private function _onLoader_ActivateHandler(event:Event):void
		{
			if(hasEventListener(event.type))
				dispatchEvent(event.clone());
		}
		
		private function _onLoader_DeactivateHandler(event:Event):void
		{
			if(hasEventListener(event.type))
				dispatchEvent(event.clone());
		}
		
		private function _onLoader_OpenHandler(event:Event):void
		{
			if(hasEventListener(event.type))
				dispatchEvent(event.clone());
		}
		
		private function _onLoader_ProgressHandler(event:ProgressEvent):void
		{
			if(hasEventListener(event.type))
				dispatchEvent(event.clone());
		}
		
		private function _onLoader_StatusHandler(event:HTTPStatusEvent):void
		{
			if(hasEventListener(event.type))
				dispatchEvent(event.clone());
			_loader = event.target as MovieDatabaseLoader;
			_loader.httpStatus = event.status;
		}
		
		private function _onLoader_IOErrorHandler(event:IOErrorEvent):void
		{
			_loader = event.target as MovieDatabaseLoader;
			_releaseUrlLoader(_loader.url);
		}
		
		private function _onLoader_CompleteHandler(event:Event):void
		{
			_loader = event.target as MovieDatabaseLoader;
			if(_loader.data.toString().indexOf("Unrecognized domain")>-1)
			{
				dispatchEvent(new MovieDatabaseFaultEvent(MovieDatabaseFaultEvent.FAULT, new ServiceFault("Unknown",_loader.data.toString(), "Service Request Error", _loader.httpStatus)));
				return;
			}
			var results:Object;
			var data:Object = JSON.parse(_loader.data);
			_releaseUrlLoader(_loader.url);
			if(data.error)
			{
				dispatchEvent(new MovieDatabaseFaultEvent(MovieDatabaseFaultEvent.FAULT, new ServiceFault("Unknown",data.error, "Service Request Error", _loader.httpStatus)));
				return;
			}
			if(event.target.data)
			{
				results = JSON.parse(event.target.data);
			}
			if(hasEventListener(_loader.returnType))
			{
				dispatchEvent(new MovieDatabaseResultEvent(_loader.returnType, results));
			}
		}
		
		private function _onLoader_SecurityHandler(event:SecurityErrorEvent):void
		{
			_loader = event.target as MovieDatabaseLoader;
			_releaseUrlLoader(_loader.url);
		}
		
		///////////////
		// METHODES
		//////////////
		private function _getUrlLoader(url:String):MovieDatabaseLoader
		{
			if(!_urlLoaders)
				_urlLoaders = new Vector.<MovieDatabaseLoader>();
			if(!_inUseLoaders)
				_inUseLoaders = {};
			
			if(_loader)
			{
				_loader.removeEventListener(Event.ACTIVATE, _onLoader_ActivateHandler);
				_loader.removeEventListener(Event.COMPLETE, _onLoader_CompleteHandler);
				_loader.removeEventListener(Event.DEACTIVATE, _onLoader_DeactivateHandler);
				_loader.removeEventListener(Event.OPEN, _onLoader_OpenHandler);
				_loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, _onLoader_StatusHandler);
				_loader.removeEventListener(IOErrorEvent.IO_ERROR, _onLoader_IOErrorHandler);
				_loader.removeEventListener(ProgressEvent.PROGRESS, _onLoader_ProgressHandler);
				_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onLoader_SecurityHandler);
				_loader = null;
			}
			if(_urlLoaders.length==0)
			{
				_loader = new MovieDatabaseLoader();
				_loader.addEventListener(Event.ACTIVATE, _onLoader_ActivateHandler);
				_loader.addEventListener(Event.COMPLETE, _onLoader_CompleteHandler);
				_loader.addEventListener(Event.DEACTIVATE, _onLoader_DeactivateHandler);
				_loader.addEventListener(Event.OPEN, _onLoader_OpenHandler);
				_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, _onLoader_StatusHandler);
				_loader.addEventListener(IOErrorEvent.IO_ERROR, _onLoader_IOErrorHandler);
				_loader.addEventListener(ProgressEvent.PROGRESS, _onLoader_ProgressHandler);
				_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onLoader_SecurityHandler);
				
				_loader.dataFormat = URLLoaderDataFormat.TEXT;
			} else {
				_loader = _urlLoaders.pop();
			}
			
			_loader.url = url;
			_inUseLoaders[url] = _loader;
			
			return _loader;
		}
		
		private function _releaseUrlLoader(url:String):void
		{
			_urlLoaders.push( _inUseLoaders[url] );
			delete _inUseLoaders[url];
		}
	}
}