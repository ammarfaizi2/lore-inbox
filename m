Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbTKRSmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 13:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTKRSmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 13:42:14 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:37613 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263751AbTKRSmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 13:42:10 -0500
Date: Tue, 18 Nov 2003 10:42:00 -0800
From: Larry McVoy <lm@bitmover.com>
To: Ben Collins <bcollins@debian.org>
Cc: Larry McVoy <lm@bitmover.com>, Sven Dowideit <svenud@ozemail.com.au>,
       Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031118184200.GA13966@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ben Collins <bcollins@debian.org>, Larry McVoy <lm@bitmover.com>,
	Sven Dowideit <svenud@ozemail.com.au>,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311141624.32108.andrew@walrond.org> <20031114164640.GA1618@work.bitmover.com> <200311141734.57122.andrew@walrond.org> <20031114174303.GC32466@work.bitmover.com> <1068959565.889.5.camel@sven> <20031118153054.GB10584@work.bitmover.com> <20031118183058.GS476@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031118183058.GS476@phunnypharm.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 18, 2003 at 01:30:58PM -0500, Ben Collins wrote:
> > Just to be clear, what we are talking about is a free client which talks to
> > a modified BK server.  The client has the ability to 
> 
> I just wanted to be clear on what you meant by "free". Is that free as
> in binary with less restrictive license than the current bk client, or
> "free" as in includes the source under the GPL? If the latter, you can
> bet your ass I'd use it. If the former, it would allow me to use it, but
> I can't guarantee I would.

It would be free as in w/ source, probably BSD rather than GPL but some
license you'd like.  About the only thing we'd need to worry about is
our commercial customers taking this and using it as a way to not pay
for some seats so there is some chance that we'd want to put in some
hook there, I'd have to think about that before promising anything.

I'm curious as to why you would think this is better than the CVS gateway.
The CVS gateway is actually a really nice thing.  The whiners think we
have somehow hamstrung the data in the gateway but that's only because
they haven't looked at the data, if they had done a careful comparison 
then they'd know it's all in there.

So what's the attraction?  Having a client that will work with any BK
server?  Do you realize that the client is just a way to get at the head?
And tagged releases?  It doesn't have 1/10th the functionality of BK itself.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
