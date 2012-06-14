package
{
	import com.rad.moviedatabase.MovieDatabaseConfig;
	import com.rad.moviedatabase.MovieDatabaseService;
	import com.rad.moviedatabase.events.MovieDatabaseImageEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Main extends Sprite
	{
		private var s:MovieDatabaseService;
		public function Main()
		{
			s = new MovieDatabaseService();
			s.addEventListener(MovieDatabaseImageEvent.ON_PROGRESS, onP);
			s.addEventListener(MovieDatabaseImageEvent.ON_COMPLETE, onC);
			var config:MovieDatabaseConfig = new MovieDatabaseConfig();
			config.profileSize = config.profileSizes[3];
			s.getProfileImage("/w8zJQuN7tzlm6FY9mfGKihxp3Cb.jpg", config.profileSize);
		}
		
		protected function onC(event:MovieDatabaseImageEvent):void
		{
			trace("complete");
		}
		
		protected function onP(event:MovieDatabaseImageEvent):void
		{
			trace(event.bytesLoaded);

		}
	}
}