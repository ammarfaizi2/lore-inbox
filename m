Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbREXVNA>; Thu, 24 May 2001 17:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262315AbREXVMu>; Thu, 24 May 2001 17:12:50 -0400
Received: from server1.cosmoslink.net ([208.179.167.101]:39180 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S262297AbREXVMl>; Thu, 24 May 2001 17:12:41 -0400
Message-Id: <l03130306b7332a134958@[209.239.217.188]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 24 May 2001 14:15:54 -0700
To: linux-kernel@vger.kernel.org
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
Subject: Ramdisk Initialization Problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I am using kernel 2.4.1 with compressed Ramdisk on  Hitachi SH board ,
with no battery.   When i run kernel first time , it works fine , it
uncompress Ramdisk and i get my shell prompt .    But when i restart it
second time (with out  removing power cable ) kernel dies when
uncompressing Ramdisk.   But , if i remove my power supply for more than 5
minutes , and then i start again , it works again.   It seems that in 2.4.1
and/or later versions has  Ramdisk Initailization or uninitialised memory
problem. But i faced no problem  with 2.2.12 kernel.   Thank you,  

Best Regards,   Jaswinder (and his wonder machine).
--
These are my opinions not  3Di.


