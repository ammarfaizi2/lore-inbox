Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWAQUJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWAQUJD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWAQUJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:09:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:19667 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964798AbWAQUJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:09:00 -0500
Date: Tue, 17 Jan 2006 21:08:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc1
In-Reply-To: <Pine.LNX.4.64.0601170946050.3240@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0601172104350.11929@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
 <20060117183916.399b030f.diegocg@gmail.com> <Pine.LNX.4.64.0601170946050.3240@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Can I ask if it's possible to "mark" new features/important changes?
>
>Well, I'd rather not do it in the source control management itself, simply 
>because people are notoriously bad at deciding what is "important".
>
>It goes something like this: "By definition, anything _you_ work for is 
>crap and unimportant, while _my_ work is the most important thing ever, 
>even if it happens to be just fixing typos".
>
Important is what is important for all members of an "independent" group.
We already have a small example: kerneltraffic. Though it's just one person 
and therefore possibly biased, the magazine picks out what's [deemed] 
important.
Typos don't really advance to important IMO, even if they fix oopses (e.g. 
a missing ! somewhere). More important are world news, news that Joe 
Default User thinks is good - "full double preemption", "O(0.5) scheduler" 
and other illusory things. Just think of if you had to commercially sell 
a Linux kernel CD what features you would print on the cover.
As for me, it was important to see SCHED_BATCH going in, as I started 
to look through the big changelog :)
Well, my 2 euros. (Yeah, 200 cents!)



Jan Engelhardt
-- 
