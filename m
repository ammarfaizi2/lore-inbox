Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTLBTVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbTLBTVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:21:04 -0500
Received: from intra.cyclades.com ([64.186.161.6]:21154 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264319AbTLBTVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:21:01 -0500
Date: Tue, 2 Dec 2003 17:12:53 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Christoph Hellwig <hch@infradead.org>
Cc: Larry McVoy <lm@work.bitmover.com>,
       Murthy Kambhampaty <murthy.kambhampaty@goeci.com>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: XFS for 2.4
In-Reply-To: <20031202182746.A27964@infradead.org>
Message-ID: <Pine.LNX.4.44.0312021712160.13692-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Dec 2003, Christoph Hellwig wrote:

> On Tue, Dec 02, 2003 at 06:23:46PM +0000, Christoph Hellwig wrote:
> > On Tue, Dec 02, 2003 at 10:20:37AM -0800, Larry McVoy wrote:
> > > So what's wrong with asking $VFS_MAINTAINER to refresh Marcelo's memory
> > > about that?
> > 
> > There is no such thing as a VFS maintainer.  At least Al doesn't want
> > to be in that position and I guess no one else would qualify (maybe
> > akpm)
> 
> And akpm queued up most of these patches in -mm and revieved them
> before they went into 2.5, but he is (fortunately for him :))  on
> vacation so you shouldn't expect any respone from him here.

Ok, Christoph agreed to review the changes. He has a clue about VFS.

If he is OK with them, I'll merge the generic XFS changes.



