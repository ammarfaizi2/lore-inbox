Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTLBSN5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLBSNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:13:53 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:4100 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262731AbTLBSL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:11:57 -0500
Date: Tue, 2 Dec 2003 18:11:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Larry McVoy <lm@work.bitmover.com>,
       Murthy Kambhampaty <murthy.kambhampaty@goeci.com>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: XFS for 2.4
Message-ID: <20031202181146.A27567@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Larry McVoy <lm@work.bitmover.com>,
	Murthy Kambhampaty <murthy.kambhampaty@goeci.com>,
	'Marcelo Tosatti' <marcelo.tosatti@cyclades.com>,
	Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
	Andrew Morton <akpm@osdl.org>
References: <2D92FEBFD3BE1346A6C397223A8DD3FC0924C8@THOR.goeci.com> <20031202180251.GB17045@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031202180251.GB17045@work.bitmover.com>; from lm@bitmover.com on Tue, Dec 02, 2003 at 10:02:51AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 10:02:51AM -0800, Larry McVoy wrote:
> Not your call, it's Marcelo's call.  And I and he have both suggested
> that the way to get XFS in is to have someone with some clout in the file
> system area agree that it is fine.  It's a perfectly reasonable request
> and the longer it goes unanswered the less likely it is that XFS will get
> integrated.  The fact that $XFS_USER wants it in is $XFS_USER's problem.
> $VFS_MAINTAINER needs to say "hey, this looks good, what's the fuss about?"
> and I suspect that Marcelo would be more interested.

I think you're missing the point.  The patches have been review many
times, they've been posted to lkml many time with the request for comment
and they've been merged into 2.5 in almost exactly that form. 

> It is also not unreasonable to reject a set of changes right before
> freezing 2.4.  2.4 is supposed to be dead.

That's indeed a point and a very resonable one.  But a few of the patches
Nathan has in that BK repo have been submited for more than year again
and again, and Marcelo's reply (for those 10% of the cases that a reply
existed at all) was something along the lines "let's postpone it after
the next release".  In my opinion that's not the right attitude from
a kernel maintainer to someone who wants to contribute major work.

