Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVCTDE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVCTDE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 22:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVCTDE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 22:04:27 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:61691 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261504AbVCTDEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 22:04:21 -0500
Date: Sat, 19 Mar 2005 22:04:19 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.12-rc1 breaks dosemu
In-reply-to: <20050320021141.GA4449@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, linux-msdos@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503192204.19804.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050320021141.GA4449@stusta.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 March 2005 21:11, Adrian Bunk wrote:
>xdosemu 1.2.2 runs fine under 2.6.11.5, but fails under 2.6.12-rc1
> with the following error:
>
I just tried it here, and its ok while running 2.6.12-rc1

><--  snip  -->
>
>$ xdosemu
>ERROR: cpu exception in dosemu code outside of VM86()!
>trapno: 0x0e  errorcode: 0x00000005  cr2: 0xffffff8e
>eip: 0x000069ee  esp: 0xbfdbffcc  eflags: 0x00010246
>cs: 0x0073  ds: 0x007b  es: 0x007b  ss: 0x007b
>Page fault: read instruction to linear address: 0xffffff8e
>CPU was in user mode
>Exception was caused by insufficient privilege
>
><--  snip  -->
>
>cu
>Adrian

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
