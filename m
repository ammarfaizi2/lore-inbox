Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266067AbTLISx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbTLISx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:53:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:50098 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266067AbTLISxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:53:51 -0500
Date: Tue, 9 Dec 2003 10:53:15 -0800
From: cliff white <cliffw@osdl.org>
To: Larry McVoy <lm@bitmover.com>
Cc: lm@bitmover.com, hannal@us.ibm.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Minutes from OSDL talk at LSE call today
Message-Id: <20031209105315.6a2b4ab7.cliffw@osdl.org>
In-Reply-To: <20031204234454.GA15799@work.bitmover.com>
References: <189470000.1070500829@w-hlinder>
	<20031204033535.GA2370@work.bitmover.com>
	<20031204134517.0c7a4ec4.cliffw@osdl.org>
	<20031204234454.GA15799@work.bitmover.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003 15:44:54 -0800
Larry McVoy <lm@bitmover.com> wrote:

> On Thu, Dec 04, 2003 at 01:45:17PM -0800, cliff white wrote:
> > On Wed, 3 Dec 2003 19:35:35 -0800
> > Larry McVoy <lm@bitmover.com> wrote:
> > 
> > > On Wed, Dec 03, 2003 at 05:20:29PM -0800, Hanna Linder wrote:
> > > > The Mozilla Tinderbox is based on CVS and can do fancy things with
> > > > triggers. The kernel one is not as fancy because they are still
> > > > working out issues with BK.
> > > 
> > > If we could get a list of these issues we'll try and see what we can do
> > > to help.  My response has been a bit spotty lately, I've needed to take
> > > some personal time, so pinging support@bitmover.com is more likely to
> > > get you help.
> > 
> > We've exchanged some email with support@bitmover.com, and they've been
> > a great help.  Really, there are two things.
> > 
> > The first is triggers. The Mozilla tinderbox is driven by triggers from
> > CVS commits.  I believe that triggers are resevered for the commercial
> > version of BK.
> 
> That's not true.  Trigger support is identical in both versions.
> 
> > However, unlike CVS, BK has a nice way of asking the remote repository
> > if new changes exist, so we really don't need a trigger to tell us when
> > to start a build.  
> 
> Right.  Your problem is deciding which trees you want to track.  There is 
> Linus/Marcelo trees but there are probably another 200+ trees of the kernel
> on bkbits.net and who knows how many elsewhere (we've counted over 10,000
> before we stopped counting).  Obviously you don't want to track all of those
> but some of them might be interesting.
> 
> > The main issue here is finding the proper syntax for the bkweb url so
> > we get all of the changesets included in the commit. We've recieved a
> > few examples from your support people, and we're using one currently.
> 
> So are there any open issues?  The call implied there were.

I don't think there are any open issues for BK. The tinderbox crew still has some 
work to do.
cliffw

> -- 
> ---
> Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
