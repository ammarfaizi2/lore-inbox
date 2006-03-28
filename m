Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWC1IIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWC1IIX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 03:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWC1IIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 03:08:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14354 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751187AbWC1IIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 03:08:22 -0500
Date: Tue, 28 Mar 2006 10:08:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.1
Message-ID: <20060328080824.GB8186@suse.de>
References: <20060328075629.GA8083@kroah.com> <20060328080114.GC8097@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328080114.GC8097@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28 2006, Greg KH wrote:
> On Mon, Mar 27, 2006 at 11:56:29PM -0800, Greg KH wrote:
> > We (the -stable team) are announcing the release of the 2.6.16.1 kernel.
> > 
> > The diffstat and short summary of the fixes are below.
> > 
> > I'll also be replying to this message with a copy of the patch between
> > 2.6.16 and 2.6.16.1, as it is small enough to do so.
> > 
> > The updated 2.6.16.y git tree can be found at:
> >  	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y.git
> 
> Oops, that should be:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
> 
> sorry about that...
> 
> Hm, we shouldn't be using "rsync" as part of a git url these days.
> What's the recommended way of writing kernel.org git tree addresses now?

git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

?

-- 
Jens Axboe

