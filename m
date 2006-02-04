Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWBDAGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWBDAGE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWBDAGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:06:04 -0500
Received: from beauty.rexursive.com ([218.214.6.102]:48569 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S1946114AbWBDAGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:06:02 -0500
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
From: Bojan Smojver <bojan@rexursive.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, nigel@suspend2.net,
       suspend2-devel@lists.suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060203235546.GB3291@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org>
	 <200602030918.07006.nigel@suspend2.net>
	 <20060203120055.0nu3ym4yuck0os84@imp.rexursive.com>
	 <20060202171812.49b86721.akpm@osdl.org>
	 <20060203124253.m6azcn4wg88gsogc@imp.rexursive.com>
	 <20060203114948.GC2972@elf.ucw.cz>
	 <1139010204.2191.14.camel@coyote.rexursive.com>
	 <20060203235546.GB3291@elf.ucw.cz>
Content-Type: text/plain
Date: Sat, 04 Feb 2006 11:05:59 +1100
Message-Id: <1139011559.2191.29.camel@coyote.rexursive.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-04 at 00:55 +0100, Pavel Machek wrote:

> The weird reasons were stated few times already. My favourite weird
> reason is "can be done in userspace" these days.

OK, let me give you the user perspective again:

- can I use vanilla kernel suspend support now: NO
- can I use suspend2 suspend support now: YES
- would I like things to improve even more: YES

I don't know why we have to wait a year to have decent suspend support.
By developing uswsusp, you are pretty much agreeing with me - current
kernel stuff isn't working to your (or mine) satisfaction. Now, I know
uswsusp is going to be better than sliced bread, but wouldn't it be nice
if more people could actually use their notebooks properly in the
meantime?

-- 
Bojan

