Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWFTVku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWFTVku (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWFTVkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:40:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25530 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751214AbWFTVks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:40:48 -0400
Date: Tue, 20 Jun 2006 14:40:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Neuer <mr.fred.smoothie@pobox.com>
cc: Al Viro <viro@ftp.linux.org.uk>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
In-Reply-To: <161717d50606201415t27d9b348y4b2069abb94e0fb3@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0606201426410.5498@g5.osdl.org>
References: <44954102.3090901@s5r6.in-berlin.de>  <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
  <20060620025552.GO27946@ftp.linux.org.uk>  <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org>
  <20060620175321.GA7463@flint.arm.linux.org.uk>  <44984CA1.5010308@s5r6.in-berlin.de>
  <20060620193422.GA10748@flint.arm.linux.org.uk> 
 <161717d50606201302o7b13a436wc733c522611b5531@mail.gmail.com> 
 <20060620202200.GT27946@ftp.linux.org.uk> <161717d50606201415t27d9b348y4b2069abb94e0fb3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Jun 2006, Dave Neuer wrote:
> > 
> > Of course, it can.
> 
> So "please pull git://somehost/myrepo.git mytag" is a solution?

Yes. As is "mybranch" etc. A lot of people use a special "for-linus" 
branch, which they update when they are ready to push to me, even if they 
might - for example - have a more "wild and crazy" main branch that they 
want others to pull for testing.

On the other hand, it really _is_ more important to just use some common 
sense. This is much less about technology than about a social protocol: 
people you know better you can be less strict with, and you can use slang 
with them, and you can call them "pinhead" rather than "Dr Torvalds". 

So people you work closely with you know how they work, they know you, and 
you may not be a total stickler for protocol.

And other people may your co-workers, but you don't actually talk daily 
with them, and you don't necessarily feel you "know" them, you are a bit 
more careful about. You follow company policy, you work through the 
channels ratehr than just showing up at his door to hang out.

See? There are pretty well-established rules for "please pull", but that 
doesn't mean that they are set in stone per se.  Don't sweat it.

Another way of sayign the same thing, and maybe clarifying: this _is_ 
about the human-to-human interaction. Git on its own can do the 
machine-to-machine part, and if you make the "please pull" be _purely_ 
automated, and you take the rules mindlessly, then you'd be kind of 
missing the point of the whole thing, wouldn't you?

So there's a protocol in place. But it's a _social_ protocol. Everybody 
starts out extra stiff and extra careful. But some day, you can give me a 
wedgie, ok?

			Linus
