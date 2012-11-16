// =================================================================================================
//
//	CadetEngine Framework
//	Copyright 2012 Unwrong Ltd. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package cadet2D.components.transforms
{
	import cadet.core.Component;
	
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	import flox.core.events.PropertyChangeEvent;

	[Cadet( inheritFromTemplate='false' )]
	public class Transform2D extends Component
	{
		private var shape	:Shape;
		
		public function Transform2D( x:Number = 0, y:Number = 0, rotation:Number = 0, scaleX:Number = 1, scaleY:Number = 1 )
		{
			name = "Transform";
			
			shape = new Shape();
			this.x = x;
			this.y = y;
			this.rotation = rotation;
			this.scaleX = scaleX;
			this.scaleY = scaleY;
		}
		
		[Inspectable( priority="1" )]
		public function set x( value:Number ):void
		{
			shape.x = value;
			invalidate("transform");
			dispatchEvent( new PropertyChangeEvent( "propertyChange_x", null, value ) );
		}
		public function get x():Number { return shape.x; }
		
		[Inspectable( priority="2" )]
		public function set y( value:Number ):void
		{
			shape.y = value;
			invalidate("transform");
			dispatchEvent( new PropertyChangeEvent( "propertyChange_y", null, value ) );
		}
		public function get y():Number { return shape.y; }
		
		[Inspectable( label="Scale X", priority="3" )]
		public function set scaleX( value:Number ):void
		{
			shape.scaleX = value;
			invalidate("transform");
			dispatchEvent( new PropertyChangeEvent( "propertyChange_scaleX", null, value ) );
		}
		public function get scaleX():Number { return shape.scaleX; }
		
		[Inspectable( label="Scale Y", priority="4" )]
		public function set scaleY( value:Number ):void
		{
			shape.scaleY = value;
			invalidate("transform");
			dispatchEvent( new PropertyChangeEvent( "propertyChange_scaleY", null, value ) );
		}
		public function get scaleY():Number { return shape.scaleY; }
		
		[Inspectable( label="Rotation", priority="5" )]
		public function set rotation( value:Number ):void
		{
			shape.rotation = value;
			invalidate("transform");
			dispatchEvent( new PropertyChangeEvent( "propertyChange_rotation", null, value ) );
		}
		public function get rotation():Number { return shape.rotation; }
		
		public function set matrix( value:Matrix ):void
		{
			shape.transform.matrix = value;
			invalidate( "transform" );
			dispatchEvent( new PropertyChangeEvent( "propertyChange_x", null, shape.x ) );
			dispatchEvent( new PropertyChangeEvent( "propertyChange_y", null, shape.y ) );
			dispatchEvent( new PropertyChangeEvent( "propertyChange_scaleX", null, shape.scaleX ) );
			dispatchEvent( new PropertyChangeEvent( "propertyChange_scaleY", null, shape.scaleY ) );
			dispatchEvent( new PropertyChangeEvent( "propertyChange_rotation", null, shape.rotation ) );
		}
		public function get matrix():Matrix { return shape.transform.matrix; }
		
		[Serializable(alias="matrix")]
		public function set serializedMatrix( value:String ):void
		{
			var split:Array = value.split( "," );
			matrix = new Matrix( split[0], split[1], split[2], split[3], split[4], split[5] );
		}
		
		public function get serializedMatrix():String 
		{ 
			var m:Matrix = matrix;
			return m.a + "," + m.b + "," + m.c + "," + m.d + "," + m.tx + "," + m.ty;
		}
	}
}