Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUBWPwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUBWPwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:52:37 -0500
Received: from buserror-extern.convergence.de ([212.84.236.66]:15494 "EHLO
	heck") by vger.kernel.org with ESMTP id S261931AbUBWPwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:52:14 -0500
Date: Mon, 23 Feb 2004 16:52:09 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: fbdv/fbcon pending problems
Message-ID: <20040223155209.GB302@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	James Simmons <jsimmons@infradead.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1077497593.5960.28.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077497593.5960.28.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> 
> Here's a list of pending issues with fbdev (either upstream or in the
> fbdev bk treee), I figured posting it here may help getting more people
> on those issues as my time is sparse and I suppose James too.
...
> Ok, that's all that comes to my mind right now, help is welcome :)

IMHO it is rather discouraging that:

FRAMEBUFFER LAYER
P:      James Simmons, Geert Uytterhoeven       
M:      jsimmons@infradead.org, geert@linux-m68k.org    
L:      linux-fbdev-devel@lists.sourceforge.net 
W:      http://www.linux-fbdev.org

$ host www.linux-fbdev.org
Nameserver not responding
www.linux-fbdev.org A record not found, try again


http://linux-fbdev.sourceforge.net/ has no halfway up-to-date information about
the state of 2.6 fbdev devlopment. Sure, one can dig through the mailing list
archives, but if a project is looking for developers I would at least expect a
link to
- the current fbdev source tree
- a TODO that lets me see what work is currently been done by others,
  and what work could be contributed by me

(This is just a suggestion, I don't have time to work on fbdev myself.)

Johannes
