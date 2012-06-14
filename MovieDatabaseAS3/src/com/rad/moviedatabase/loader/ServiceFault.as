package com.rad.moviedatabase.loader
{

	public class ServiceFault extends Error
	{
		
		private var _httpStatus:int;
		public function get httpStatus():int { return _httpStatus; }
		
		private var _faultCode:String;
		/**
		 * Fault Code from Service. 
		 * @return 
		 * 
		 */		
		public function get faultCode():String
		{
			return _faultCode;
		}
		
		private var _faultString:String;
		/**
		 * Simple Fault Information. 
		 * @return 
		 * 
		 */		
		public function get faultString():String
		{
			return _faultString;
		}
		
		private var _faultDetail:String;

		public function get faultDetail():String
		{
			return _faultDetail;
		}
		
		public function ServiceFault(faultCode:String, faultString:String, faultDetail:String = null, httpStatus:int=0)
		{
			super(faultCode);
			_faultCode = faultCode;
			_faultString = faultString;
			_faultDetail = faultDetail;
			_httpStatus = httpStatus;
		}
		
		public function toString():String
		{
			return "Code: "+faultCode+"\n" +
				"String: "+faultString+"\n" +
				"Detail: "+faultDetail+"\n" +
				"Http Status: "+httpStatus+"\n"
		}
		
	}
}