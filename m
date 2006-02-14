Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWBRMzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWBRMzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWBRMzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:55:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26779 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751225AbWBRMzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:55:06 -0500
Date: Tue, 14 Feb 2006 20:22:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, ak@suse.de
Subject: Re: [PATCH/RFC] arch/x86_common: more formal reuse of i386+x86_64 source code
Message-ID: <20060214192204.GE1609@openzaurus.ucw.cz>
References: <20060208225336.23539710.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208225336.23539710.rdunlap@xenotime.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> (not completed yet)
> (patch applies to 2.6.16-rc2)
> 
> Patch is 331 KB and is at
>   http://www.xenotime.net/linux/patches/x86-common1.patch
> 
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Move lots of i386 & x86_64 common code into arch/x86_common/
> and modify Makefiles to use it from there.

I like it... the way some files have main code in i386 and some is x86-64 is
rather ugly.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

