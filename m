Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266796AbUHaS7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266796AbUHaS7c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUHaS7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:59:32 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:57997 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S266796AbUHaS7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:59:16 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2 nvidia breakage
Date: Tue, 31 Aug 2004 14:59:12 -0400
User-Agent: KMail/1.7
Cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>, jason@stdbev.com,
       Sid Boyce <sboyce@blueyonder.co.uk>, akpm@osdl.org
References: <4134A5EE.5090003@blueyonder.co.uk> <d40d2dbcd4c9aaaeb94073ca00d7b3b7@stdbev.com> <200408311448.55974.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200408311448.55974.norberto+linux-kernel@bensa.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408311459.12426.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.62.54] at Tue, 31 Aug 2004 13:59:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 August 2004 13:48, Norberto Bensa wrote:
>Jason Munro wrote:
>> I also had to change calls to pci_find_class in nv.c to
>> pci_get_class to get the module to load with 2.6.9-rc1-mm2.
>
>Yup. But KDE 3.3 doesn't load with this kernel. No oops, no crash.
> It just hangs at "Initializing peripherals..." and stays there
> forever...
>
Odd, I'm running kde3.3 built by konstruct, and linux-2.6.9-rc1-mm2 
without any quickly noticeable problems, for about 15 minutes now.

>Regards,
>Norberto

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
