Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTL1LBI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 06:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbTL1LBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 06:01:07 -0500
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:30430 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S265069AbTL1LBD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 06:01:03 -0500
Date: Sun, 28 Dec 2003 21:48:57 +1100 (EST)
From: Michael Still <mikal@stillhq.com>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Fixing 2.6.0's broken documentation references
In-Reply-To: <Pine.LNX.4.58.0312272222500.14915@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0312282145070.18079-100000@diskbox.stillhq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Dec 2003, Thomas Molina wrote:

> I agree that having a documentation maintainer would be a good idea.  Hans 
> could volunteer or I could if no one else wants it.  Whoever does it 
> though, needs some assurance that patches won't be dropped on the floor.

I would think that any such maintainer would also have to deal with 
kernel-doc, and making sure all of those scripts work / don't produce 
errors. I got a bunch of patches into the late 2.5 cycle to deal with 
that, but someone needs to keep that stuff working.

I'm happy to keep playing with those scripts, if other people are happy 
with that.

My point is that documentation is more complex than just keeping the 
comments in the source pointing at the right places -- there is a bunch of 
infrastructure there as well.

On the dropped patch front, I had a lot of success getting patches into 
the kernel via the Trivial Patch Monkey. Given the menial nature of this 
sort of work, wouldn't this best be done by the janitors and sending 
patches to trivial?

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 11                          |    -- Homer Simpson

