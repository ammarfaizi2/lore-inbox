Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbTKNQqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 11:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbTKNQqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 11:46:49 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:44194 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264530AbTKNQqr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 11:46:47 -0500
Date: Fri, 14 Nov 2003 08:46:40 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031114164640.GA1618@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Walrond <andrew@walrond.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311132057.53026.andrew@walrond.org> <20031114150047.GC30711@work.bitmover.com> <200311141624.32108.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311141624.32108.andrew@walrond.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 04:24:31PM +0000, Andrew Walrond wrote:
> On Friday 14 Nov 2003 3:00 pm, Larry McVoy wrote:
> > On Thu, Nov 13, 2003 at 08:57:53PM +0000, Andrew Walrond wrote:
> > > The point. You got one major o/s project hosted on bk when you ought to
> > > have them all. Loads more developers using bk at home means loads more
> > > demanding it at work.
> > >
> > > And all it would take is a lobotomised, redistributable, license free
> > > client so anyone can pull o/s software from bk repos.
> >
> > One of us is not getting it, maybe it's me.  To build something like
> > you describe is pretty easy IF AND ONLY IF all you are asking for is an
> > update mechanism.  As soon as you want revision history, diffs, rollbacks,
> > modifiable files, etc., you have to go to real BK.  Is that OK?  All you
> > want is a "keep me up to date" mechanism?  No diffs, no history, it's a
> > replacement for tarballs and patches?
> 
> Yes exactly. Fundamentally I want *anybody*, without restriction, to ge able 
> to pull and update sources from any open-source project hosted with bk.
> 
> The requirements are the equivalent functionality to:
> 
> lobobk clone ...

Sure.

> lobobk -r co

There are no local revision history files in lobobk, it's just a file transport.

> lobobk pull

Sure.

> lobobk export -r tag dest

That's 

	lobobk clone -r tag FROM DEST

And you of course realize that you as a BK user could code up this system with
zero changes needed from us, right?  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
