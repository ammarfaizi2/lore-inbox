Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbUEOOii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUEOOii (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 10:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUEOOii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 10:38:38 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:9962 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262766AbUEOOiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 10:38:09 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: "Justin Piszcz" <jpiszcz@hotmail.com>
Subject: Re: Linux 2.6.6 appears to be 3 to 4 times slower than 2.6.5.
Date: Sat, 15 May 2004 10:38:07 -0400
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <BAY18-F22R9sJzcccki00011d12@hotmail.com>
In-Reply-To: <BAY18-F22R9sJzcccki00011d12@hotmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405151038.07163.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.54.72] at Sat, 15 May 2004 09:38:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 May 2004 08:04, Justin Piszcz wrote:
>I have memory benchmarks and compile benchmarks,
>
>essentially
>
>compiling takes ~5 sec on a 2.53ghz (533mhz bus/2GB ram box) for
> lilgp - genetic program
>ram  =ddr 333
>compiling takes ~15-20 sec on a 3ghz (not sure on bus/4gb ram box)
> for lilgp - genetic program
>ram = ddr 400
>
>dd if=/dev/zero of=/mnt/ramdisk/file bs=409e size=(64 or 256mb)
>it is 12% faster on the slower (2.53ghz box) vs the box w/DDR 400mhz
> ram
>
>Is anyone else having SERIOUS PROBLEMS with the 2.6.6 kernel as
> well?

I noted that my epson C82 usb printer was running about 25% of its 
normal speed last night, it took gimp-print several hours to do half 
a dozen 8x10's in 720dpi.  gkrellm's display looks normal though, 
with setiathome currently taking 90+% of the cpu, which is normal.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
