Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264244AbUFGBQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbUFGBQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 21:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264247AbUFGBQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 21:16:31 -0400
Received: from mail48-s.fg.online.no ([148.122.161.48]:4841 "EHLO
	mail48-s.fg.online.no") by vger.kernel.org with ESMTP
	id S264244AbUFGBQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 21:16:29 -0400
From: Kenneth =?iso-8859-1?q?Aafl=F8y?= <keaafloy@online.no>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux crashing on amd athlons?
Date: Mon, 7 Jun 2004 03:16:53 +0200
User-Agent: KMail/1.6.2
References: <001701c44bf7$c8991f20$0200a8c0@laptop> <20040606235730.GA10458@merlin.emma.line.org>
In-Reply-To: <20040606235730.GA10458@merlin.emma.line.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406070316.53812.keaafloy@online.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 June 2004 01:57, Matthias Andree wrote:
> On Sun, 06 Jun 2004, Ameer Armaly wrote:
> > While installing linux on an amd athlon, the kernel is oopsing and
> > shuting down the computer at random places  within the install.  This is
> > a custom built kernel off of kernel.org I built, which I optimized for
> > athlon then i386 afterwards, but with no luck.
>
> I have several Athlons (from the venerable 500 to the new XP 2600+) in
> use at various sites, no problems. Among them an XP 1700+ in server use
> with vanilla 2.4.26, rock solid.
>
> Check you've used a supported compiler and binutils, then check the
> hardware. Cooling (heat sink), RAM (try memtest86), power supply, proper
> clock speed and core voltage, proper RAM timing -- these are all
> contributing factors to instability if not carefully chosen and
> installed.

I have a dual Athlon MP2400+ running very stable on Linux Kernel (.org) 
2.6.7-rc1, only the last week I have had random segfaults while compiling 
kernels and the like. So I popped open the case and vacuumed it, every thing, 
with special care on fans and ribbons. After this it's been running 
flawlessly again :)

My point beeing, better know your hardware before checking for flaws in Linux!

Kenneth
