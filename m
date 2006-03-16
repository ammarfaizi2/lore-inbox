Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWCPUVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWCPUVR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWCPUVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:21:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:9863 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750861AbWCPUVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:21:17 -0500
Date: Thu, 16 Mar 2006 21:20:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nigel Kukard <nkukard@lbsd.net>
cc: Mariusz Mazur <mmazur@kernel.pl>, llh-announce@lists.pld-linux.org,
       VMiklos <vmiklos@frugalware.org>, linux-kernel@vger.kernel.org,
       Dan Kegel <dank@kegel.com>
Subject: Re: [llh-announce] [ANNOUNCE] linux-libc-headers dead
In-Reply-To: <20060316083716.jnfgt8wilcgoo4ws@webmail.lbsd.net>
Message-ID: <Pine.LNX.4.61.0603162118080.11776@yvahk01.tjqt.qr>
References: <200603141619.36609.mmazur@kernel.pl> <20060316083716.jnfgt8wilcgoo4ws@webmail.lbsd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> If there is no-one else willing to maintain linux-libc-headers, I'll be more
> than happy to take it over and try get more developers interested.
>

Some linux distributions (I know of Novell who do it for SUSE Linux)
seem to roll their own thing AFAICS. The glibc.src.rpm from them contains
a userspacified copy of the kernel headers.
Well, it's probably not bleeeeding edge uptodate, but provides a starting 
point.


Jan Engelhardt
-- 
