package
{
	import cadet.core.CadetScene;
	import cadet.core.ComponentContainer;
	import cadet.events.RendererEvent;
	
	import cadet2D.components.core.Entity;
	import cadet2D.components.geom.RectangleGeometry;
	import cadet2D.components.transforms.Transform2D;
	import cadet2D.renderPipeline.starling.components.renderers.Renderer2D;
	import cadet2D.renderPipeline.starling.components.skins.GeometrySkin;
	
	import cadet2DBox2D.components.behaviours.RigidBodyBehaviour;
	import cadet2DBox2D.components.processes.PhysicsProcess;
	import cadet2DBox2D.renderPipeline.starling.components.behaviours.RigidBodyMouseDragBehaviour;
	
	import components.behaviours.ApplyTorqueBehaviour;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF( width="700", height="400", backgroundColor="0x002135", frameRate="60" )]
	public class Main extends Sprite
	{
		private var cadetScene	: CadetScene;
		
		public function Main()
		{
			cadetScene = new CadetScene();
			
			var renderer:Renderer2D = new Renderer2D();
			renderer.addEventListener(RendererEvent.INITIALISED, rendererInitialisedHandler );
			renderer.viewportWidth = stage.stageWidth;
			renderer.viewportHeight = stage.stageHeight;
			cadetScene.children.addItem(renderer);
			renderer.enable(this);
		}
		
		private function rendererInitialisedHandler( event:Event ):void
		{
			initScene();
		}
		
		private function initScene():void
		{
			cadetScene.children.addItem( new PhysicsProcess() );
			
			for ( var i:int = 0; i < 30; i++ )
			{
				var x:Number = Math.random() * stage.stageWidth;
				var y:Number = Math.random() * 100;
				var width:Number = 20 + Math.random() * 20;
				var height:Number = 20 + Math.random() * 20;
				addRectangleEntity( x, y, width, height );
			}
			
			var rotatingRectangle:Entity = addRectangleEntity( 0, 0, 100, 100 );
			rotatingRectangle.children.addItem( new ApplyTorqueBehaviour(50,2) );
			
			// Create the floor. We pass 'true' as the 'fixed' property to make the floor static.
			addRectangleEntity( 0, stage.stageHeight-50, stage.stageWidth, 50, true );
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);			
		}
		
		private function addRectangleEntity( x:Number, y:Number, width:Number, height:Number, fixed:Boolean = false ):Entity
		{
			var entity:Entity = new Entity();
			entity.children.addItem( new Transform2D(x, y) );
			entity.children.addItem( new GeometrySkin() );
			entity.children.addItem( new RectangleGeometry(width, height) );
			entity.children.addItem( new RigidBodyBehaviour(fixed) );
			entity.children.addItem( new RigidBodyMouseDragBehaviour() );
			
			cadetScene.children.addItem(entity);
			
			return entity;
		}
		
		private function enterFrameHandler( event:Event ):void
		{
			cadetScene.step();
		}
	}
}