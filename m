Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268596AbRHGP1T>; Tue, 7 Aug 2001 11:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268614AbRHGP1J>; Tue, 7 Aug 2001 11:27:09 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:51460
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S268596AbRHGP0u>; Tue, 7 Aug 2001 11:26:50 -0400
Date: Tue, 07 Aug 2001 11:26:50 -0400
From: Chris Mason <mason@suse.com>
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Working reiserfsck?
Message-ID: <146010000.997198010@tiny>
In-Reply-To: <20010802133051.A88@toy.ucw.cz>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, August 02, 2001 01:30:55 PM +0000 Pavel Machek <pavel@ucw.cz>
wrote:

> Hi!
> 
> On one of my machines, I installed reiserfs on / fs.... and got to habit
> of just powering that machine down with powerswitch. I was running
> various kernels at least from 2.4.3 on it.
> 
> Now I tried to run reiserfsck, and (besides it having very ugly UI) it
> reported some problems. Question is, how to correct those? reiserfsck
> attitude seems to be "run me and I'll kill your filesystem". Is it really
> that dangerous? Where to get working reiserfsck?
> 								Pavel

The best reiserfsck version right now is in
ftp.namesys.com/pub/reiserfsprogs/pre

It should fix the problem, backups are always handy though.

-chris

