Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSKTVfn>; Wed, 20 Nov 2002 16:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSKTVfn>; Wed, 20 Nov 2002 16:35:43 -0500
Received: from whfirewall.nwtel.ca ([199.85.228.1]:41089 "EHLO
	whfirewall.nwtel.ca") by vger.kernel.org with ESMTP
	id <S261615AbSKTVfm>; Wed, 20 Nov 2002 16:35:42 -0500
Message-Id: <5.1.1.6.0.20021120133929.02485ae8@gnat.nwtel.ca>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 20 Nov 2002 13:42:42 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Richard Whittaker <rwhittak@gnat.nwtel.ca>
Subject: Re: Semaphore and Shared memory questions...
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1037829889.5122.89.camel@irongate.swansea.linux.org.uk>
References: <5.1.1.6.0.20021120131444.02482858@gnat.nwtel.ca>
 <5.1.1.6.0.20021120131444.02482858@gnat.nwtel.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:04 PM 11/20/2002 +0000, Alan Cox wrote:

>The sysctl interface and sysctl setting tools on boot exist precisely so
>you dont have to hack these things around

Allright... This is fine by me... One of my questions was (and still is), 
what do I pass to sysctl for setting /proc/sys/kernel/sem?...

Setting shmmax was easy, since it's only a single hex value, but sem is 
puzzling me... Is a space separated list of values going to work?...

Thanks,
Richard.

---
Richard Whittaker,
System Manager,
NorthwesTel Inc.
Whitehorse, Yukon, Canada.

