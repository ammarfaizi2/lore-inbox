Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbTJ0OBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 09:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTJ0OBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 09:01:46 -0500
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:52096 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S263190AbTJ0OBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 09:01:45 -0500
From: jlnance@unity.ncsu.edu
Date: Mon, 27 Oct 2003 09:01:42 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Message-ID: <20031027140142.GA2832@ncsu.edu>
References: <16282.45806.428547.279213@zeus.local> <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 11:37:05AM -0700, Linus Torvalds wrote:
> Face it, a good graphics driver needs more than just "set up the ROM". It
> needs DMA access, and the ability to use interrupts. It needs a real 
> driver.
> 
> It basically needs something like what the DRI modules tend to do.

On Tue, 16 Jan 1996, Linus Torvalds wrote:
> X goes to hardware directly, but that's just because it should do it. 
> And exactly _because_ it's an application, it can be just about as
> complex as it wants (and needs) to be.  So you have a user-level device
> driver: is that not a good idea? The microkernel people are jumping up
> and down and wetting themselves in excitement over things like that. 

Its not that I dont think you are entitled to change your mind.  Its just
that the second version is so quotable that it has stuck in my mind oh
these many years.

Jim
