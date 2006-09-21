Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWIUEW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWIUEW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 00:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWIUEW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 00:22:29 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:41098 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750754AbWIUEW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 00:22:29 -0400
Message-ID: <45121382.1090403@garzik.org>
Date: Thu, 21 Sep 2006 00:22:26 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19 -mm merge plans
References: <20060920135438.d7dd362b.akpm@osdl.org>
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> A wander through the -mm patch queue, along with some commentary on my
> intentions.
> 
> 
> When replying to this email, please rewrite the Subject: to something
> appropriate.  Please also attempt to cc the appropriate developer(s).
> 
> 
> There are quite a lot of patches here which belong in subsystem trees. 
> I'll patchbomb the relevant maintainers soon.  Could I pleeeeeze ask that
> they either merge the patches or solidly nack them (with reasons)?  Don't
> just ignore it all and leave me hanging onto this stuff for ever.  Thanks.

I know this is probably heresy, but what would happen if we didn't merge 
all that stuff at once, and then committed to having a real 4-week cycle?

The cycles seem to be stretching out again, and I don't really think 
it's worth it to hold up the entire kernel for every single piddly 
little regression to get fixed.  We'll _never_ be perfect, even if we 
weren't slackers.

	Jeff


