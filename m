Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVALT2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVALT2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVALT0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:26:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:60883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261320AbVALTVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:21:44 -0500
Date: Wed, 12 Jan 2005 11:21:37 -0800
From: Chris Wright <chrisw@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112112137.Q24171@build.pdx.osdl.net>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112104407.N24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121051360.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0501121051360.2310@ppc970.osdl.org>; from torvalds@osdl.org on Wed, Jan 12, 2005 at 10:57:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> On Wed, 12 Jan 2005, Chris Wright wrote:
> > 
> > Right, I know you don't like the embargo stuff.
> 
> I'd very happy with a "private" list in the sense that people wouldn't 
> feel pressured to fix it that day, and I think it makes sense to have some 
> policy where we don't necessarily make them public immediately in order to 
> give people the time to discuss them. 

That's what I figured you meant.

> But it should be very clear that no entity (neither the reporter nor any
> particular vendor/developer) can require silence, or ask for anything more
> than "let's find the right solution". A purely _technical_ delay, in other
> words, with no politics or other issues involved.

Agreed.

> Otherwise it just becomes politics:  you end up having security firms that
> want a certain date because they want a PR blitz, and you end up having
> vendors who want a certain date because they have release issues.

There is value in coordinating with vendors, namely to keep them from
being caught with pants down.  But vendor-sec already does this part
well enough.

> Does that mean that vendor-sec would end up being used for some things,
> where people _want_ the politics and jockeying for position?  Probably.
> But having a purely technical alternative would be wonderful.
> 
> > > If that means that you can get only the list by invitation-only, that's
> > > fine. 
> > 
> > Opinions on where to set it up?  vger, osdl, ...?
> 
> I don't personally think it matters. Especially if we make it very clear 
> that it's purely technical, and no vendor politics can enter into it. 
> Whatever ends up being easiest. 

Well, easiest for me is here ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
