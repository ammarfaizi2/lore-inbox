Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273227AbTHFB4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 21:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273238AbTHFB4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 21:56:16 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:30910 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S273227AbTHFB4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 21:56:14 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Andrew McGregor <andrew@indranet.co.nz>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.4 vs 2.6 versions of include/linux/ioport.h
Date: Tue, 5 Aug 2003 21:56:12 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200308051041.08078.gene.heskett@verizon.net> <200308051807.00179.gene.heskett@verizon.net> <82550000.1060129571@ijir>
In-Reply-To: <82550000.1060129571@ijir>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308052156.12613.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.12.168] at Tue, 5 Aug 2003 20:56:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 August 2003 20:26, Andrew McGregor wrote:
>--On Tuesday, August 05, 2003 06:07:00 PM -0400 Gene Heskett
>
><gene.heskett@verizon.net> wrote:
>> Now, the factory nvidia drivers will not build for 2.6, so I don't
>> have any X.  Whats the status of the kernel versions vis-a-vis
>> running a gforce2 MMX 32 megger?
>
>http://www.minion.de/
>
>Patches for several recent NVidia driver versions.  Works for me on
> a GeForce2go.
>
>Andrew

Thank you.  Patch instructions would have been nice as the patch is 
against the archives own unpacked usr/src/nv directory, not readily 
determined at a glance.  Took me 15 minutes to find the magic twanger 
to play that song, erroniously patching the root makefile many times. 
:)

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

