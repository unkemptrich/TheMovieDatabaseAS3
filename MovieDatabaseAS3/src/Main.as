package
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.rad.moviedatabase.MovieDatabaseConfig;
	import com.rad.moviedatabase.MovieDatabaseService;
	import com.rad.moviedatabase.events.MovieDatabaseImageEvent;
	import com.rad.moviedatabase.events.MovieDatabaseResultEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Main extends Sprite
	{
		private var s:MovieDatabaseService;
		public function Main()
		{
			MonsterDebugger.initialize(this);
			s = new MovieDatabaseService();
			s.api_key="553dee63dc0bd7b3118f4599eb7f1435";
			//s.searchByTitle("black swan");
			s.searchByPeople("brad pitt");
			s.addEventListener(MovieDatabaseResultEvent.SEARCH_BY_PEOPLE, people);
		}
		
		protected function people(event:MovieDatabaseResultEvent):void
		{
			MonsterDebugger.trace(this, event.result);

			trace("yooo");

		}
		
		protected function searchMovies(event:MovieDatabaseResultEvent):void
		{
			trace("yp");
		}
		
		protected function onC(event:MovieDatabaseImageEvent):void
		{
			trace("complete");
			addChild(event.content);
		}
		
		protected function onP(event:MovieDatabaseImageEvent):void
		{
			trace(event.bytesLoaded);

		}
	}
}