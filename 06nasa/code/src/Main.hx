package ;

import jQuery.*;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class Main
{

	private var currentOffset:Int = 0;

	private var document = js.Browser.document;
	private var window = js.Browser.window;


	function new()
	{
		//when document is ready
		new JQuery(function():Void
		{
			//your magic
			trace ("NASA images");

			buildUI();

			// Ajax
			JQuery._static.ajax({
				url: "https://api.nasa.gov/planetary/apod",
				data: {
					date : randomDate(),
					concept_tags: "True",
					api_key : "DEMO_KEY"
				},
				success: function( data ) {
					trace ("data.url : " + data.url );
					trace ("data.media_type : " + data.media_type);
					trace ("data.explanation : " + data.explanation);
					trace ("data.concepts : " + data.concepts);
					trace ("data.title : " + data.title);


					new JQuery( "#nasa-container" ).html( "<h2>"+data.title+"</h2><img src='" + data.url + "' alt='"+data.title+"' class='img-responsive center-block' ><p>"+data.explanation+"</p>" );

					new JQuery (".back-in-time").click(onClickHandler);

				}
			});
		});
	}

	public function buildUI()
	{
		// <div class="container"></div>
		var _div = document.createDivElement();
		_div.className = "container";
		document.body.appendChild(_div);

		// h2
		var _h2 = document.createElement('h2');
		_h2.innerText = "NASA";
		_div.appendChild(_h2);

		// link
		var _ahref = document.createAnchorElement();
		_ahref.href = "https://api.nasa.gov/api.html#apod";
		_ahref.appendChild (document.createTextNode("https://api.nasa.gov/api.html#apod"));

		trace (_ahref);

		var _p = document.createParagraphElement();
		_p.innerText = "Thx to NASA for suppling there open API ("+ _ahref +")";
		_div.appendChild(_p);

		var _image = document.createDivElement();
		_image.id = "nasa-container";
		_image.appendChild(document.createTextNode("This text will replaced with an image"));
		_div.appendChild(_image);

		var _btn = document.createButtonElement();
		_btn.innerText = "back in time";
		_btn.className = "back-in-time";
		_div.appendChild(_btn);

		_div.appendChild(document.createComment(".container"));
	}

	function onClickHandler(e)
	{
		trace('go back in time');
	}

	function randomDate():String
	{
		var date = Date.now();
		var year = date.getFullYear();
		var month = date.getMonth()+1; // start from zero
		var day = date.getDate();
		// return "1999-01-01";
		return year + "-" + StringTools.lpad (Std.string(month),"0",2) + "-" + StringTools.lpad (Std.string(day),"0",2);
	}

    static public function main() : Void
    {
        var main = new Main();
	}
}