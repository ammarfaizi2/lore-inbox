Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVAMVjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVAMVjG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVAMVeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:34:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:41110 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261715AbVAMVbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:31:51 -0500
Date: Thu, 13 Jan 2005 13:31:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       marcelo.tosatti@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: security contact draft
In-Reply-To: <1105647058.4624.134.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501131325560.2310@ppc970.osdl.org>
References: <20050113125503.C469@build.pdx.osdl.net>
 <1105647058.4624.134.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jan 2005, Alan Cox wrote:
> 
> It's not documenting the stuff Linus seems to be talking about which is
> a public list ? Or does Linus want both ?

I see myself as pretty extreme when it comes to my approach to security.

And I actually distrust extremes. I'm at one end of the spectrum, and
vendor-sec is at the other (I'm not even counting the head-in-the-sand
approach as part of the spectrum ;). Knowing that, I'd expect that most
people are somewhere in between.

Which to me implies that while what I personally _want_ is total openness, 
that's not necessarily what makes the most sense in real life.

So I want to give people choice. I want to encourage openness. But hell, 
if we have a closed list with a declared short embargo that is known to 
not play games (ie clock starts ticking from original discovery, not from 
somebody elses embargo), that's good too.

Let people vote with their feet. If vendor-sec ends up being where all the
"important" things are discussed - so be it. We've not lost anything, and
at worst a "kernel-security" list would be a way to discuss stuff that was
already released by vendor-sec.

			Linus
