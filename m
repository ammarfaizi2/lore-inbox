Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932666AbVLGAI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbVLGAI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 19:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbVLGAI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 19:08:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22021 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932666AbVLGAI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 19:08:59 -0500
Date: Wed, 7 Dec 2005 01:08:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Takahiro Hirofuchi <taka-hir@is.naist.jp>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.15-rc5-mm1: USB_IP problems
Message-ID: <20051207000858.GA25910@stusta.de>
References: <20051204232153.258cd554.akpm@osdl.org> <20051205214055.GN9973@stusta.de> <20051207000216.GA17953@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207000216.GA17953@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 04:02:16PM -0800, Greg KH wrote:
> On Mon, Dec 05, 2005 at 10:40:55PM +0100, Adrian Bunk wrote:
> > On Sun, Dec 04, 2005 at 11:21:53PM -0800, Andrew Morton wrote:
> > >...
> > >  Subsystem trees
> > >...
> > > +gregkh-usb-usbip.patch
> > > 
> > >  USB tree updates
> > >...
> > 
> > Problems with this patch:
> > - USB_IP: no need for a "default N"
> 
> Why not?  Is that the "default"?
>...

Yes.

> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

