Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268079AbTBMQDv>; Thu, 13 Feb 2003 11:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268080AbTBMQDu>; Thu, 13 Feb 2003 11:03:50 -0500
Received: from bitmover.com ([192.132.92.2]:4578 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S268079AbTBMQDt>;
	Thu, 13 Feb 2003 11:03:49 -0500
Date: Thu, 13 Feb 2003 08:13:37 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@imladris.surriel.com>
Cc: Jamie Lokier <jamie@shareable.org>, Andrea Arcangeli <andrea@e-mind.com>,
       linux-kernel@vger.kernel.org
Subject: Re: openbkweb-0.0
Message-ID: <20030213161337.GA9654@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@imladris.surriel.com>,
	Jamie Lokier <jamie@shareable.org>,
	Andrea Arcangeli <andrea@e-mind.com>, linux-kernel@vger.kernel.org
References: <20030206021029.GW19678@dualathlon.random> <20030213024751.GA14016@bjl1.jlokier.co.uk> <Pine.LNX.4.50L.0302130946541.21354-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0302130946541.21354-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 09:55:28AM -0200, Rik van Riel wrote:
> On Thu, 13 Feb 2003, Jamie Lokier wrote:
> > Andrea Arcangeli wrote:
> > > I guess the bitkeeper network protocol could be also implemented on the
> > > longer run, it should be much faster to fetch all the database that way,
> >
> > Nobody (who is covered by copyright laws) is allowed to use the _free_
> > version of BitKeeper to reverse engineer the protocol.  I may be
> > mistaken - perhaps the BitKeeper "anti-competition" clause would be
> > found unenforcable.. but I'm not interested in going there.
> 
> Reverse engineering the protocol is probably allowed, as long
> as you don't create an alternative implementation yourself.

We'd view reverse engineering the protocol as falling under the "you're
working on a competing implementation".  

The general message is that you are free to use BK but you aren't free
to use BK in any way which could hurt the business which produces BK.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
