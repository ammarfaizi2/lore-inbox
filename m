Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbTCLVXT>; Wed, 12 Mar 2003 16:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262048AbTCLVXT>; Wed, 12 Mar 2003 16:23:19 -0500
Received: from bitmover.com ([192.132.92.2]:60848 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262046AbTCLVXS>;
	Wed, 12 Mar 2003 16:23:18 -0500
Date: Wed, 12 Mar 2003 13:33:57 -0800
From: Larry McVoy <lm@bitmover.com>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312213357.GC30788@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <20030312174244.GC13792@work.bitmover.com> <Pine.LNX.4.44.0303121324510.14172-100000@xanadu.home> <20030312195120.GB7275@work.bitmover.com> <20030312210513.GA6948@nevyn.them.org> <20030312211832.GA6587@work.bitmover.com> <20030312213108.GA7700@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312213108.GA7700@nevyn.them.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 04:31:08PM -0500, Daniel Jacobowitz wrote:
> On Wed, Mar 12, 2003 at 01:18:32PM -0800, Larry McVoy wrote:
> > > Larry, this brings up something I was meaning to ask you before this
> > > thread exploded.  What happens to those "logical change" numbers over
> > > time?
> > 
> > They are stable in the CVS tree because the CVS tree isn't distributed.
> > So "Logical change 1.900" in the context of the exported CVS tree is 
> > always the same thing.  That's one advantage centralized has, things
> > don't shift around on you.
> 
> OK, so the logical change numbers there are only related to the CVS
> tree, not related to revision numbers in the BK tree being converted? 

Correct.  The BK revs are in there though, that's what

BKrev: <long string of bits>

is in the change log.

> That makes more sense, thank you.

Hey cool, you're welcome!
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
