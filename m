Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261909AbSIYEE3>; Wed, 25 Sep 2002 00:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261910AbSIYEE3>; Wed, 25 Sep 2002 00:04:29 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:20486
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261909AbSIYEE2>; Wed, 25 Sep 2002 00:04:28 -0400
Date: Tue, 24 Sep 2002 21:09:08 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Slansky <slansky@usa.net>
cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: hpt370 raid driver
In-Reply-To: <20020924132445Z261665-8740+289@vger.kernel.org>
Message-ID: <Pine.LNX.4.10.10209242107460.6896-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drwxr-xr-x    2 root          270 Sep 24 21:02 .
drwxr-xr-x   82 root         3296 Sep 24 21:00 ..
-rw-------    1 root         1163 Apr  1 08:06 Makefile
-rw-------    1 root        37777 Apr  5 12:34 hpt.c
-rw-------    1 root         1925 Feb 26  2002 hpt.h
-rw-r--r--    1 root        63639 Apr  5 12:35 hpt37x2lib.o
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Binary RAID Library,  Thank you, have a nice day "TAINT"

-rw-r--r--    1 root        55051 Apr 18 10:14 hpt3xx-opensource-v13.tgz
-rw-rw-rw-    1 root        28789 Apr  3 12:46 hptglb.h
-rw-------    1 root         1765 Mar 28 08:52 hptkern.h
-rw-rw-rw-    1 root         5402 Apr  5 12:38 readme.txt
-rw-------    1 root          841 Mar  1  2002 rules.mak


On Tue, 24 Sep 2002, Petr Slansky wrote:

> Hi Alan!
> do you know that there is a source code of driver for HPT370 raid at the
> manufacturer web?
> 
> http://www.highpoint-tech.com/370drivers_down.htm
> http://www.highpoint-tech.com/hpt3xx-opensource-v13.tgz
> 
> Maybe that this can be added to the kernel, there are many motherboards on the
> market with such controller onboard. Is there any poblem with this driver?
> 
> As I know, hpt370 is supported only in IDE mode by kernel 2.4.18.
> 
> With regards,
> Petr
> 
> 
> ---------------------------------
>   Petr Slansky, slansky@usa.net
> ---------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

