Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161217AbWI2A11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbWI2A11 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWI2A1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:27:25 -0400
Received: from mx1.suse.de ([195.135.220.2]:65002 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161214AbWI2A1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:27:11 -0400
From: Neil Brown <neilb@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Date: Fri, 29 Sep 2006 10:26:39 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17692.26687.478584.156639@cse.unsw.edu.au>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Chase Venters <chase.venters@clientec.com>,
       Sergey Panov <sipan@sipan.org>, Patrick McFarland <diablod3@gmail.com>,
       Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: message from Linus Torvalds on Thursday September 28
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
	<Pine.LNX.4.64.0609271945450.3952@g5.osdl.org>
	<1159415242.13562.12.camel@sipan.sipan.org>
	<200609272339.28337.chase.venters@clientec.com>
	<20060928135510.GR13641@csclub.uwaterloo.ca>
	<20060928141932.GA707@DervishD>
	<20060928144028.GA21814@wohnheim.fh-wedel.de>
	<Pine.LNX.4.64.0609280748500.3952@g5.osdl.org>
	<Pine.LNX.4.64.0609280808450.3952@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday September 28, torvalds@osdl.org wrote:
> 
> 
> On Thu, 28 Sep 2006, Linus Torvalds wrote:
> > 
> > It should also be pointed out that even a "GPLv2 or later" project can be 
> > forked two different ways: you can turn it into a "GPLv3" (with perhaps a 
> > "or later" added too) project, but you can _equally_ turn it into a "GPLv2 
> > only" project.
> 
> Btw, it should be stated here: I'm not advocating either of the above. If 
> a license says "v2 or later", anybody who removes an explicit right 
> granted by the people who originally wrote and worked on the code is just 
> being a total a-hole.

But isn't that the whole point - to replace v2 by v3?
As v3 is almost uniformly more restrictive than v2, anyone having the
option of choosing v2 or v3 would naturally choose v2.
If there is to be no removal of the v2 license from "v2 or later"
code, then there is absolutely no point in the new license being a new
version of the GPL.  Rather it is a totally new license.
Now I know that is what you would prefer, but it seems obvious that it
isn't what the new FSF wants.
I would be very surprised if new versions of any FSF-control code is
available under v2 more than a few months after v3 becomes final.

> 
> Quite frankly, if the FSF ever relicenses any of their projects to be 
> "GPLv3 or later", I will hope that everybody immediately forks, and 
> creates a GPLv2-only copy (and yes, you have to do it immediately, or 
> you're screwed forever). That way the people involved can all vote with 
> their feet.

I don't see the urgency.  Why are you "screwed forever"?  You can
always take the last version that was available under a suitable
license and fork from there, just like OpenSSH did.

Sure: the longer you leave it the harder it will be to get critical
mass, but I don't see the need for it to be done immediately.

NeilBrown
