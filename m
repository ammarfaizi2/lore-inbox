Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbVIVN4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbVIVN4m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbVIVN4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:56:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63304 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030352AbVIVN4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:56:40 -0400
Date: Thu, 22 Sep 2005 15:57:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Rolf Offermanns <roffermanns@sysgo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linus GIT tree disappeared from http://www.kernel.org/git/?
Message-ID: <20050922135706.GL4262@suse.de>
References: <200509221514.44027.roffermanns@sysgo.com> <20050922133228.GB26438@flint.arm.linux.org.uk> <20050922133621.GJ4262@suse.de> <20050922134238.GC26438@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922134238.GC26438@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22 2005, Russell King wrote:
> On Thu, Sep 22, 2005 at 03:36:22PM +0200, Jens Axboe wrote:
> > On Thu, Sep 22 2005, Russell King wrote:
> > > On Thu, Sep 22, 2005 at 03:14:43PM +0200, Rolf Offermanns wrote:
> > > > Maybe I am dreaming, but I could have sworn it has been there yesterday...
> > > 
> > > It seems that kernel.org hasn't finished updating the mirrors yet -
> > > and it seems to be taking hours.  Unfortunately, this has left Linus'
> > > public git tree in an inconsistent state.
> > 
> > Actually it's getting closer to days (last I checked it was over half a
> > day), which really is a shame as it basically destroys the usability of
> > having git repos available there... Lets hope it gets fixed soon.
> 
> I think it isn't taking days, based upon the start times of the
> processes I saw earlier today and yesterday.

No not days, half a day at least :)

> If not already done, maybe the kernel.org ftp admins would prefer
> to be informed about the problem?  Reporting the problems with
> kernel.org to lkml might only reach folk who use the services, not
> those who provide them.

I already informed hpa earlier today. I did the same thing a while back
when we were getting close to 4-6 hour sync time and they did fix
"something" back then. So hopefully they can figure it out again...

-- 
Jens Axboe

