Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbVKJN1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVKJN1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVKJN1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:27:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50909 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750856AbVKJN1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:27:40 -0500
Date: Thu, 10 Nov 2005 14:26:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, len.brown@intel.com, jgarzik@pobox.com,
       tony.luck@intel.com, bcollins@debian.org, scjody@modernduck.com,
       dwmw2@infradead.org, rolandd@cisco.com, davej@codemonkey.org.uk,
       axboe@suse.de, shaggy@austin.ibm.com, sfrench@us.ibm.com
Subject: Re: merge status
Message-ID: <20051110132636.GB9584@elf.ucw.cz>
References: <20051109133558.513facef.akpm@osdl.org> <1131573041.8541.4.camel@mulgrave> <Pine.LNX.4.64.0511091358560.4627@g5.osdl.org> <1131575124.8541.9.camel@mulgrave> <20051109150141.0bcbf9e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109150141.0bcbf9e3.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > it's my contributors who drop me in it
> > by leaving their patch sets until you declare a kernel, dumping the
> > integration testing on me in whatever time window is left.
> 
> Yes, I think I'm noticing an uptick in patches as soon as a kernel is
> released.
> 
> It's a bit irritating, and is unexpected (here, at least).  I guess people
> like to hold onto their work for as long as possible so when they release
> it, it's in the best possible shape.
> 
> I guess all we can do is to encourage people to merge up when it's working,
> not when it's time to merge it into mainline.

Well, merge when previous stuff is way easier, because you can just do
cg-diff. When my previous changes enter mainline, it is suddenly very
easy to generate next patch. [And it makes sense, it is

cg-diff -r origin:

"let's see what I missed].

								Pavel
-- 
Thanks, Sharp!
