Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264705AbUEXWOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbUEXWOn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 18:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbUEXWOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 18:14:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:65198 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264705AbUEXWOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 18:14:34 -0400
Date: Mon, 24 May 2004 15:14:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <20040524220136.GC18532@colin2.muc.de>
Message-ID: <Pine.LNX.4.58.0405241512330.32189@ppc970.osdl.org>
References: <1YUY7-6fF-11@gated-at.bofh.it> <m3fz9pd2dw.fsf@averell.firstfloor.org>
 <Pine.LNX.4.58.0405241326400.32189@ppc970.osdl.org> <20040524220136.GC18532@colin2.muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 May 2004, Andi Kleen wrote:
> 
> In practice I guess it would end up with that maintainers would spend a lot
> of time explaining to everybody what this new policy is about and 
> possibly are forced to reject a lot of patches initially. 

...which is why we want to have a wide discussion of it now, the less to 
have to explain to people ;)

I don't expect this process to start taking effect for a while. Not only 
do we need to come to some level of agreement about it, but we need to 
give people the time to learn about it _without_ rejecting patches in the 
meantime. 

There is no real "flag-day" (and it's certainly not today), although I'm
hoping that by the time I start up 2.7.x we'd have this in place.

		Linus
