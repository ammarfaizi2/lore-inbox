Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTI2Ar6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 20:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbTI2Ar6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 20:47:58 -0400
Received: from hibernia.jakma.org ([213.79.33.168]:42118 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S261950AbTI2Ar5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 20:47:57 -0400
Date: Mon, 29 Sep 2003 01:47:23 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Steven Cole <elenstev@mesatop.com>
cc: Larry McVoy <lm@bitmover.com>, Timothy Miller <miller@techsource.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
In-Reply-To: <200309272113.18030.elenstev@mesatop.com>
Message-ID: <Pine.LNX.4.56.0309290139260.19081@fogarty.jakma.org>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com>
 <20030910151238.GC32321@work.bitmover.com> <Pine.LNX.4.56.0309280249030.19081@fogarty.jakma.org>
 <200309272113.18030.elenstev@mesatop.com>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Sep 2003, Steven Cole wrote:

> Since Larry is off doing other things for the next week and a half,
> I'll attemt to to answer that for him.  Larry was possibly
> referring to IRIX scaling to 1024 CPUs, e.g. the "Chapman" machine,
> mentioned here:
> http://www.sgi.com/company_info/awards/03_computerworld.html

An Origin 3k, Altix is essentially the Origin 3k architecture but
engineered around Itanic CPU boards. :)

> It appears that SGI is working to scale the Altix to 128 CPUs on Linux.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106323064611280&w=2

Working to? Nah, they did that a long time ago:

	http://mail.nl.linux.org/linux-mm/2001-03/msg00004.html

They've had another 2.5 years since to further work on Linux 
scaleability.

"SGI Altix 3000 superclusters scale up to hundreds of processors."

So, either they've already run Linux on Altix or Origin internally
with hundreds of CPUs or they're fairly confident there arent any
major problems they couldnt sort out in the time it would take to
build, test and deliver a hundred+ node Altix.

> Steven
> -

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
I owe the public nothing.
		-- J.P. Morgan
