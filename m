Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbUEWQUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUEWQUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 12:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUEWQUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 12:20:10 -0400
Received: from 213-0-214-141.dialup.nuria.telefonica-data.net ([213.0.214.141]:13702
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S263149AbUEWQT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 12:19:59 -0400
Date: Sun, 23 May 2004 18:20:08 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Billy Biggs <vektor@dumbterm.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tvtime and the Linux 2.6 scheduler
Message-ID: <20040523162008.GA14482@localhost>
Mail-Followup-To: Billy Biggs <vektor@dumbterm.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040523154859.GC22399@dumbterm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523154859.GC22399@dumbterm.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 23 May 2004, at 10:48:59 -0500,
Billy Biggs wrote:

>   "[...] it starts up fine, but after a few seconds (when the scheduler
> gathered some stats) ... well, it looks funny: the scene goes roughly
> exponentially into slow motion, then there is a frame drop and the
> process starts over.  this behaviour can be observed at any priority,
> which is clearly against the claim "no normally priorized interactive
> process will preempt a highly priorized cpu-hog" that i've read
> somewhere.  the xserver priority does not change anything, either;"
> 
I am currently using tvtime 0.9.12-2 from Debian SID on a Linux kernel
version 2.6.6 compiled with Sid's gcc 3.3.3 and haven't seen such
problems so far. I use tvtime often to watch TV on my monitor, and it
works OK, no artifacts and no slowdown (even when I download my email
and spamassassin starts to eat CPU cicles like mad).

With my current configuration tvtime at full screen (1024x768) takes
about 40% CPU from a AMD XP 1477 MHz (1700 rating). I have just tried
launching three copies of "yes" on several aterm's and tvtime still
looks as smooth as before, althoug CPU is always at 100%

Please ask for more information should you need it.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.6)
