Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWBCBBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWBCBBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWBCBBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:01:04 -0500
Received: from beauty.rexursive.com ([218.214.6.102]:14729 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S1751217AbWBCBBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:01:02 -0500
Message-ID: <20060203120055.0nu3ym4yuck0os84@imp.rexursive.com>
Date: Fri, 03 Feb 2006 12:00:55 +1100
From: Bojan Smojver <bojan@rexursive.com>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Andrew Morton <akpm@osdl.org>, suspend2-devel@lists.suspend2.net,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	<20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org>
	<200602030918.07006.nigel@suspend2.net>
In-Reply-To: <200602030918.07006.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nigel Cunningham <nigel@suspend2.net>:

> It reminds me why I started working on this in the first place. It wasn't
> because I wanted to be a big shot kernel developer or the like, or have my
> name in the kernel credits. It was because I wanted to use the code.

And what a superb job you have done with suspend2! Kudos Nigel!

Here are the facts from my notebook suspend2 actually does work, works 
reliably, is fast and pretty, none of which is true for swsusp. From my 
user perspective, the refusal to merge suspend2 into mainline etc. is 
just contributing to one thing - Linux not having decent suspend/resume 
in vanilla tree.

I travel on the train every day and I can confidently say that I'm the 
only person there with a Linux based notebook. Everyone else is having 
Windows or an occasional Mac. These people *never* have to worry about 
suspending and resuming - it just works for them. That's because 
Microsoft and Apple decided this was important many, many years ago.

Unless mainline kernel folks decide to give people something that works 
and works reliably, this thing will drag on for many more years, I'm 
afraid. Ah well, as long as you keep the great job releasing suspend2 
for the up-to-date kernels, at least one more Linux notebook will be 
able to suspend/resume properly.

Bottom line: With your code, my machine works. Without it, it doesn't.

-- 
Bojan
