Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTLBUWR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbTLBUUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:20:07 -0500
Received: from intra.cyclades.com ([64.186.161.6]:27584 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264343AbTLBURn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:17:43 -0500
Date: Tue, 2 Dec 2003 18:05:37 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, <nathans@sgi.com>,
       <lm@work.bitmover.com>, <linux-kernel@vger.kernel.org>,
       <linux-xfs@oss.sgi.com>
Subject: Re: XFS for 2.4
In-Reply-To: <20031202205502.474755f3.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44.0312021802310.32164-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Dec 2003, Stephan von Krawczynski wrote:

> On Tue, 2 Dec 2003 09:22:48 -0200 (BRST)
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> 
> > [...]
> > A development tree is much different from a stable tree. You cant just
> > simply backport generic VFS changes just because everybody agreed with
> > them on the development tree.
> > 
> > My whole point is "2.6 is almost out of the door and its so much better".  
> > Its much faster, much cleaner. 
> 
> Even if I am a bit off-topic here, please reconsider your last sentence. Don't
> make people think that 2.6 is in a widely useable state right now. Just take a
> look at the history of 2.4. Don't forget 2.4 can be used in boxes beyond 4 GB
> only right _now_ (2.4.23), all previous versions fall completely apart on i386
> platform. 2.4 is right now nice, useable and pretty stable - and 2.6 has not
> even begun to see the real-and-ugly world yet. There will for sure be a lot of
> interesting test cases during the next months for 2.6, but there are quite an
> amount of people that need a real stable environment - and that's why they will
> have to use 2.4 for at least one year from now on.
> 
> This is no vote for or against XFS-inclusion, I don't know the thing at all. I
> only want to state: developer environment is pretty different from the real
> world, so don't dump 2.4 too early please.

I'm not dumping 2.4. It will enter "maintenance-only" mode in 2.4.25. It
will be update as long as there are problems in it, but no more features
will creep in.

As for XFS, Christoph will review the patches and tell me what he thinks. 

Also other people mailed me saying they reviewed the code.

That makes me more comfortable with merging the XFS modifications.





