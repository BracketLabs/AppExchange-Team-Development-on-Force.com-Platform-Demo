/**
 * Copyright (c) 2009 Sergiy Kovalchuk (serg472@gmail.com)
 * 
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *  
 * Following code is based on Element.mask() implementation from ExtJS framework (http://extjs.com/)
 *
 */
//loadmask = ui-overlay
//loadmask-msg = ui-widget ui-widget-content ui-corner-all
;(function($){
	
	/**
	 * Displays loading mask over selected element(s). Accepts both single and multiple selectors.
	 *
	 * @param label Text message that will be displayed on top of the mask besides a spinner (optional). 
	 * 				If not provided only mask will be displayed without a label or a spinner.  	
	 * @param delay Delay in milliseconds before element is masked (optional). If unmask() is called 
	 *              before the delay times out, no mask is displayed. This can be used to prevent unnecessary 
	 *              mask display for quick processes.   	
	 */
	$.fn.mask = function(label, delay){
		$(this).each(function() {
			if(delay !== undefined && delay > 0) {
		        var element = $(this);
		        element.data("_mask_timeout", setTimeout(function() { $.maskElement(element, label)}, delay));
			} else {
				$.maskElement($(this), label);
			}
		});
	};
	
	/**
	 * Removes mask from the element(s). Accepts both single and multiple selectors.
	 */
	$.fn.unmask = function(){
		$(this).each(function() {
			$.unmaskElement($(this));
		});
	};
	
	/**
	 * Checks if a single element is masked. Returns false if mask is delayed or not displayed. 
	 */
	$.fn.isMasked = function(){
		return this.hasClass("masked");
	};

    $.fn.center = function () {
        return this.each(function() {
                var top = ($(window).height() - $(this).outerHeight()) / 2;
                var left = ($(window).width() - $(this).outerWidth()) / 2;
                $(this).css({position:'absolute', margin:0, top: (top > 0 ? top : 0)+'px', left: (left > 0 ? left : 0)+'px'});
        });
    }

	$.maskElement = function(element, label){
	
		//if this element has delayed mask scheduled then remove it and display the new one
		if (element.data("_mask_timeout") !== undefined) {
			clearTimeout(element.data("_mask_timeout"));
			element.removeData("_mask_timeout");
		}

		if(element.isMasked()) {
			$.unmaskElement(element);
		}
		
		if(element.css("position") == "static") {
			element.addClass("masked-relative");
		}
		
		element.addClass("masked");
		
        var maskDivContainer = $('<div class="ui-overlay"></div>');
		var maskDiv = $('<div class="ui-widget-overlay"></div>');
		
		//auto height fix for IE
		if(navigator.userAgent.toLowerCase().indexOf("msie") > -1){
			maskDiv.height(element.height() + parseInt(element.css("padding-top")) + parseInt(element.css("padding-bottom")));
			maskDiv.width(element.width() + parseInt(element.css("padding-left")) + parseInt(element.css("padding-right")));
		}
		
		//fix for z-index bug with selects in IE6
		if(navigator.userAgent.toLowerCase().indexOf("msie 6") > -1){
			element.find("select").addClass("masked-hidden");
		}
		
        maskDivContainer.append(maskDiv);

		element.append(maskDivContainer);
		
		if(label !== undefined) {
			var maskMsgDiv = $('<div class="ui-widget ui-widget-content ui-corner-all" style="display:none;position:absolute;"></div>');
            var maskShadow = $('<div class="ui-widget-shadow ui-corner-all" style="display:none;position:absolute;"></div>');
            maskDivContainer.append(maskShadow);

            maskMsgDiv.css("padding", "10px");
            //position: absolute; width: 280px; height: 130px; left: 50px; top: 30px; padding: 10px;
            if (typeof label == 'string') {
                    maskMsgDiv.append('<div class=\"ui-overlay-loading\">' + label + '</div>');
            } else {
                    maskMsgDiv.append($(label));
            } 
			
			element.append(maskMsgDiv);
			
			//calculate center position
            //var top = Math.round(element.height() / 2 - (maskMsgDiv.height() - parseInt(maskMsgDiv.css("padding-top")) - parseInt(maskMsgDiv.css("padding-bottom"))) / 2);
            //var left = Math.round(element.width() / 2 - (maskMsgDiv.width() - parseInt(maskMsgDiv.css("padding-left")) - parseInt(maskMsgDiv.css("padding-right"))) / 2);
            var top = ($(element).height() - $(maskMsgDiv).outerHeight()) / 2;
            var left = ($(element).width() - $(maskMsgDiv).outerWidth()) / 2;
			maskMsgDiv.css("top", top+"px");
			maskMsgDiv.css("left", left+"px");
			
            maskShadow.css("top", top+"px");
            maskShadow.css("left", left+"px");
            maskShadow.css("width", (maskMsgDiv.width() + 22)+"px");
            maskShadow.css("height", (maskMsgDiv.height() + 22)+"px");

            maskShadow.show();
			maskMsgDiv.show();
		}
		
	};
	
	$.unmaskElement = function(element){
		//if this element has delayed mask scheduled then remove it
		if (element.data("_mask_timeout") !== undefined) {
			clearTimeout(element.data("_mask_timeout"));
			element.removeData("_mask_timeout");
		}
		
		element.find(".ui-overlay,.ui-widget.ui-widget-content.ui-corner-all").remove();
		element.removeClass("masked");
		element.removeClass("masked-relative");
		element.find("select").removeClass("masked-hidden");
	};
 
})(jQuery);