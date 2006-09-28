Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161352AbWI1Wrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161352AbWI1Wrq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161357AbWI1Wrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:47:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:54938 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161352AbWI1Wrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:47:45 -0400
Date: Thu, 28 Sep 2006 15:47:48 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Olaf Hering <olaf@aepfle.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [GIT PATCH] USB patches for 2.6.18
Message-ID: <20060928224748.GA24105@suse.de>
References: <Pine.LNX.4.44L0.0609281815170.10847-100000@iolanthe.rowland.org> <Pine.LNX.4.64.0609281521470.3952@g5.osdl.org> <20060928222518.GA12666@suse.de> <Pine.LNX.4.64.0609281540580.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609281540580.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 03:41:58PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 28 Sep 2006, Greg KH wrote:
> > > 
> > > Greg, can we please feed fixes to me faster?
> > 
> > Faster?  My god man, I just found out a few minutes ago that these were
> > causing problems for people.  I had only applied them to my local tree
> > about 12 hours ago :)
> 
> Umm. I'm just saying that that fix was apparently sent to the 
> linux-usb-devel people two days _before_ I even merged the USB changes..
> 
> Or did I misunderstand?

Sorry, no, I misunderstood and had missed the patch and didn't realize
that it was necessary for this series.  I've now queued up another tree
of stuff that I had missed, and a bunch of new device ids.

thanks,

greg k-h
