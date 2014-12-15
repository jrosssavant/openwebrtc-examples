//
//  ViewController.swift
//  SelfieSwift
//
//  Created by Joseph Ross on 12/12/14.
//  Copyright (c) 2014 Ericsson Research. All rights reserved.
//

import UIKit
import GLKit

let kSelfViewTag:String = "self-view"

class SelfViewController: UIViewController {

    @IBOutlet var selfView:GLKView? = nil
    var renderer:OwrVideoRenderer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        owr_init()
        println("OpenWebRTC initialized")
        
        println("Registering self view \(self.selfView)")
        let windowRegistry = owr_window_registry_get()
        var voidPtr: UnsafeMutablePointer<Void> = unsafeBitCast(self.selfView!, UnsafeMutablePointer<Void>.self)
        owr_window_registry_register(windowRegistry, kSelfViewTag.cStringUsingEncoding(NSUTF8StringEncoding)!, voidPtr)
        
        println("Getting capture sources...")
        var nilVoidPtr: UnsafeMutablePointer<Void> = nil;
        let p = UnsafeMutablePointer<(UnsafeMutablePointer<GList>, UnsafeMutablePointer<Void>)->()>.alloc(1)
        p.initialize(got_sources)
        let cp = COpaquePointer(p)
        let fp = CFunctionPointer<(UnsafeMutablePointer<GList>, UnsafeMutablePointer<Void>)->()>(cp)
        owr_get_capture_sources(OWR_MEDIA_TYPE_VIDEO, fp, nilVoidPtr)
    }

    func got_sources(sources:UnsafeMutablePointer<GList>, user_data:UnsafeMutablePointer<Void>)
    {
        println("got_sources")
//    g_assert(sources);
//    
//    while (sources) {
//        var source:OwrMediaSource? = nil
//        var media_type:OwrMediaType
//        var source_type:OwrMediaType
//    
//    source = sources.data;
//    g_assert(OWR_IS_MEDIA_SOURCE(source));
//    
//    g_object_get(source, "type", &source_type, "media-type", &media_type, NULL);
//    
//    if (media_type == OWR_MEDIA_TYPE_VIDEO && source_type == OWR_SOURCE_TYPE_CAPTURE) {
//    renderer = owr_video_renderer_new(SELF_VIEW_TAG);
//    g_assert(renderer);
//    
//    g_object_set(renderer, "width", 1280, "height", 720, "max-framerate", 60.0, NULL);
//    
//    owr_media_renderer_set_source(OWR_MEDIA_RENDERER(renderer), source);
//    break;
//    }
//    sources = sources->next;
    }


}

