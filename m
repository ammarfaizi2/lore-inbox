Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVGOUSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVGOUSp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVGOUSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:18:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19615 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262023AbVGOURa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:17:30 -0400
Date: Fri, 15 Jul 2005 13:16:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
Message-Id: <20050715131610.25c25c15.akpm@osdl.org>
In-Reply-To: <20050715150034.GA6192@infradead.org>
References: <20050715013653.36006990.akpm@osdl.org>
	<20050715150034.GA6192@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jul 15, 2005 at 01:36:53AM -0700, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> > 
> > (http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-rc3-mm1.gz until
> > kernel.org syncs up)
> > 
> > 
> > - Added the CKRM patches.  This is just here for people to look at at this
> >   stage.
> 
> Andrew, do we really need to add every piece of crap lying on the street
> to -mm?  It's far away from mainline enough already without adding obviously
> unmergeable stuff like this.

My gut reaction to ckrm is the same as yours.  But there's been a lot of
work put into this and if we're to flatly reject the feature then the
developers are owed a much better reason than "eww yuk".

Otherwise, if there are certain specific problems in the code then it's
best that they be pointed out now rather than later on.

What, in your opinion, makes it "obviously unmregeable"?
