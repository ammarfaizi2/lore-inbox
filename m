Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbULPCHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbULPCHt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 21:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbULPCFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 21:05:49 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:45780 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S262567AbULPCCT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 21:02:19 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: USB making time drift [was Re: dynamic-hz]
Date: Wed, 15 Dec 2004 21:02:17 -0500
User-Agent: KMail/1.7
Cc: Pavel Machek <pavel@suse.cz>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>
References: <20041213002751.GP16322@dualathlon.random> <200412151144.38785.gene.heskett@verizon.net> <20041215201618.GA5797@elf.ucw.cz>
In-Reply-To: <20041215201618.GA5797@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412152102.17888.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.42.94] at Wed, 15 Dec 2004 20:02:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 December 2004 15:16, Pavel Machek wrote:
>Hi!

Hi Pavel;

>> >> Which way?  I was running quite fast here, several minutes an
>
>Try idle=poll. That noise may be commig from cpu switching between
>powersave and full speed.
>        Pavel

I don't think I have that option set/enabled at all, and these
machines are running seti so the cpu stays at 100% anyway.

Where would I set that if I wanted to try it?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

