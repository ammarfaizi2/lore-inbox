Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVALTAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVALTAp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVALTAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:00:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:31169 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261301AbVALS54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:57:56 -0500
Date: Wed, 12 Jan 2005 10:57:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wright <chrisw@osdl.org>
cc: akpm@osdl.org, alan@lxorguk.ukuu.org.uk, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
In-Reply-To: <20050112104407.N24171@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0501121051360.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112104407.N24171@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jan 2005, Chris Wright wrote:
> 
> Right, I know you don't like the embargo stuff.

I'd very happy with a "private" list in the sense that people wouldn't 
feel pressured to fix it that day, and I think it makes sense to have some 
policy where we don't necessarily make them public immediately in order to 
give people the time to discuss them. 

But it should be very clear that no entity (neither the reporter nor any
particular vendor/developer) can require silence, or ask for anything more
than "let's find the right solution". A purely _technical_ delay, in other
words, with no politics or other issues involved.

Otherwise it just becomes politics:  you end up having security firms that
want a certain date because they want a PR blitz, and you end up having
vendors who want a certain date because they have release issues.

Does that mean that vendor-sec would end up being used for some things,
where people _want_ the politics and jockeying for position?  Probably.
But having a purely technical alternative would be wonderful.

> > If that means that you can get only the list by invitation-only, that's
> > fine. 
> 
> Opinions on where to set it up?  vger, osdl, ...?

I don't personally think it matters. Especially if we make it very clear 
that it's purely technical, and no vendor politics can enter into it. 
Whatever ends up being easiest. 

		Linus
