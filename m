Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbUKDXyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbUKDXyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbUKDXxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:53:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:4264 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262506AbUKDXwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:52:35 -0500
Date: Thu, 4 Nov 2004 15:52:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adam Heath <doogie@debian.org>
cc: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
Message-ID: <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org>
 <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Nov 2004, Adam Heath wrote:
> 
> But slowness doesn't mean wrong, just by being slow.

No.

"Right" and "wrong" have _nothing_ to do with anything.

he only thing that matters is "what is the best tool". And yes, 
performance _is_ an issue in selecting the best tool. It's not the only 
one, but it's a major one.

You said so yourself when you claimed people should just buy faster 
hardware. Again, the machine you use is just another tool. Why should you 
buy a faster machine if performance doesn't matter?

I don't understand why you first dismiss performance, and then go on to
ignore all the _other_ issues I told you about too.

And your argument about "things will get fixed if you use the newer
version" is also not actually true. First off, if it ain't broke in the 
older version, then things _literally_ will get fixed by not upgrading in 
the first place.

And telling a developer "I'm not using your new version because it sucks
compared to the old one" is actually a perfectly valid thing to do, and is 
likely to be _more_ motivational for the developer to get it fixed than 
having users that just follow the newest version like stupid sheep.

There are people out there using Linux-2.0. There are probably people even
using linux-1.2. And hey, that's OK. For older machines it may really be
the right choice, especially if they are still doing the same thing they
did several years ago. The notion that you somehow "have to" upgrade to
the newest version of software is BOGUS.

		Linus
