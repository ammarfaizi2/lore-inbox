Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262051AbTCLVUf>; Wed, 12 Mar 2003 16:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262052AbTCLVUf>; Wed, 12 Mar 2003 16:20:35 -0500
Received: from crack.them.org ([65.125.64.184]:41114 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262051AbTCLVUe>;
	Wed, 12 Mar 2003 16:20:34 -0500
Date: Wed, 12 Mar 2003 16:31:08 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312213108.GA7700@nevyn.them.org>
Mail-Followup-To: Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030312174244.GC13792@work.bitmover.com> <Pine.LNX.4.44.0303121324510.14172-100000@xanadu.home> <20030312195120.GB7275@work.bitmover.com> <20030312210513.GA6948@nevyn.them.org> <20030312211832.GA6587@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312211832.GA6587@work.bitmover.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 01:18:32PM -0800, Larry McVoy wrote:
> > Larry, this brings up something I was meaning to ask you before this
> > thread exploded.  What happens to those "logical change" numbers over
> > time?
> 
> They are stable in the CVS tree because the CVS tree isn't distributed.
> So "Logical change 1.900" in the context of the exported CVS tree is 
> always the same thing.  That's one advantage centralized has, things
> don't shift around on you.

OK, so the logical change numbers there are only related to the CVS
tree, not related to revision numbers in the BK tree being converted? 
That makes more sense, thank you.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
