Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbSJDVCc>; Fri, 4 Oct 2002 17:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262720AbSJDVCc>; Fri, 4 Oct 2002 17:02:32 -0400
Received: from bitmover.com ([192.132.92.2]:31187 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262715AbSJDVCb>;
	Fri, 4 Oct 2002 17:02:31 -0400
Date: Fri, 4 Oct 2002 14:08:02 -0700
From: Larry McVoy <lm@bitmover.com>
To: tom_gall@mac.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
Message-ID: <20021004140802.E24148@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>, tom_gall@mac.com,
	linux-kernel@vger.kernel.org
References: <AD47B5CD-D7DB-11D6-A2D4-0003939E069A@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <AD47B5CD-D7DB-11D6-A2D4-0003939E069A@mac.com>; from tom_gall@mac.com on Fri, Oct 04, 2002 at 03:55:55PM -0500
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I noticed Larry recently changed the license on bk.  Once clause in 

This isn't a recent change at all, I know it is at least 6 months old
because it was included in 

BitKeeper version is bk-2.1.6-pre5 20020330075529 for x86-glibc22-linux
Built by: lm@redhat71.bitmover.com in /build/bk-2.1.x-lm/src
Built on: Sat Mar 30 00:14:45 PST 2002

>         (d)  Notwithstanding any other terms in this License, this
>              License is not available to You if  You  and/or  your
>              employer  develop,  produce,  sell,  and/or  resell a
>              product which contains substantially similar capabil-
>              ities  of  the BitKeeper Software, or, in the reason-
>              able opinion of BitMover, competes with the BitKeeper
>              Software.
> 
> Doesn't this affect maintainers all across the map that work for 
> distros such as RedHat, SuSE, Connectiva, etc?  Obviously these distros 
> SELL as part of their respective products CVS and similar tools. Or 
> even non-distro open source shops, you even resell CVS or the like in 
> some way and you'd be in trouble.

Distributions do not *SELL* CVS, they distribute CVS.  We choose those
words with care for exactly that reason.  All the clause is saying is
that if you are a competitor you don't get to use our product for free.
That it, in our opinion, a perfectly reasonable position to take.

> While I am all for Larry having a profitable business, this would seem 
> to be a change which is not Open Source developer friendly.

The clause is specifically designed to target those companies which 
produce or sell commercial SCM systems.  That's why we explicitly 
left out "distribute".  The open source developers have nothing to
worry about.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
