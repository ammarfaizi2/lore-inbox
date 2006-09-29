Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161421AbWI2GW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161421AbWI2GW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161422AbWI2GW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:22:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23015 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161421AbWI2GW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:22:56 -0400
Date: Thu, 28 Sep 2006 23:22:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Neil Brown <neilb@suse.de>
cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Chase Venters <chase.venters@clientec.com>,
       Sergey Panov <sipan@sipan.org>, Patrick McFarland <diablod3@gmail.com>,
       Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <17692.26687.478584.156639@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0609282317580.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
 <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org> <1159415242.13562.12.camel@sipan.sipan.org>
 <200609272339.28337.chase.venters@clientec.com> <20060928135510.GR13641@csclub.uwaterloo.ca>
 <20060928141932.GA707@DervishD> <20060928144028.GA21814@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0609280748500.3952@g5.osdl.org> <Pine.LNX.4.64.0609280808450.3952@g5.osdl.org>
 <17692.26687.478584.156639@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Sep 2006, Neil Brown wrote:
> On Thursday September 28, torvalds@osdl.org wrote:
> > 
> > Btw, it should be stated here: I'm not advocating either of the above. If 
> > a license says "v2 or later", anybody who removes an explicit right 
> > granted by the people who originally wrote and worked on the code is just 
> > being a total a-hole.
> 
> But isn't that the whole point - to replace v2 by v3?

I'm sure it's the point for the FSF. Is it really the point for anybody 
else? Everybody else is better off with the more permissive license..

> Now I know that is what you would prefer, but it seems obvious that it
> isn't what the new FSF wants.
> I would be very surprised if new versions of any FSF-control code is
> available under v2 more than a few months after v3 becomes final.

I suspect the FSF might well be _very_ careful here. If they move to "v3 
or later", they had better be damn sure somebody won't license-fork that 
project, or they'll be left with nothing at all.

So I would not be entirely surprised if projects remain "v2 or later" just 
because it's to nobodys advantage to play chicken.

But who knows..

> I don't see the urgency.  Why are you "screwed forever"?  You can
> always take the last version that was available under a suitable
> license and fork from there, just like OpenSSH did.
> 
> Sure: the longer you leave it the harder it will be to get critical
> mass, but I don't see the need for it to be done immediately.

It obviously doesn't have to be, but it gets a lot harder to do later, if 
the project has any appreciable amount of real development.

Of course, a lot of projects probably don't have that much. I haven't 
followed, but I don't get the feeling that bash or fileutils have a huge 
amount of constant changes..

			Linus
