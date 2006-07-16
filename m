Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWGPSW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWGPSW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 14:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWGPSW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 14:22:26 -0400
Received: from tomts24-srv.bellnexxia.net ([209.226.175.187]:50389 "EHLO
	tomts24-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750885AbWGPSW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 14:22:26 -0400
Date: Sun, 16 Jul 2006 11:20:37 -0700
From: Greg KH <gregkh@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [stable] Linux 2.6.16.25
Message-ID: <20060716182037.GA4346@suse.de>
References: <20060715025906.GA11167@kroah.com> <20060715032907.GB5944@kroah.com> <19700101132635.GB3561@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19700101132635.GB3561@ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 1970 at 01:26:35PM +0000, Pavel Machek wrote:
> Hi!
> 
> > > We (the -stable team) are announcing the release of the 2.6.16.25 kernel.
> > 
> > Oops, please note that we now have some reports that this patch breaks
> > some versions of HAL.  So if you're relying on HAL, you might not want
> > to use this fix just yet (please evaluate the risks of doing this on
> > your own.)
> > 
> > Note that HAL usually does not run on servers, so this should be safe
> > there.  We'll try to provide a better fix soon...
> 
> So there's going to be one more 2.6.16, good.

Already went out :)

> Did you receive that fix-pdflush-after-wakeup? I believe I mailed it
> to stable@kernel.org, but I got no reply...

Yes, it's in our queue.  Did you want that for 2.6.16 or 2.6.17?  I
assumed .17.

thanks,

greg k-h
