Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312939AbSDKUuS>; Thu, 11 Apr 2002 16:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312943AbSDKUuR>; Thu, 11 Apr 2002 16:50:17 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:33664 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S312939AbSDKUuQ>; Thu, 11 Apr 2002 16:50:16 -0400
Date: Thu, 11 Apr 2002 22:50:11 +0200 (CEST)
From: Michael De Nil <linux@aerythmic.be>
X-X-Sender: linux@LiSa
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Stolen Memory <- i830M video chip
Message-ID: <Pine.LNX.4.44.0204112244480.4745-100000@LiSa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey


working here on an Asus L1-laptop which contains the Intel 830M graphical
chip. when loading the agpgart module, it prints in syslog that there is
only 1 Meg 'stolen ram'. like that, it's not possable to run X @ 1024x768
with more then 256 colors.

i searched on the intel-website, which told me hat i should be able to
change this setting in my bios. *not*

can't i reserve any more ram myselve by selecting linux only to use 256 -
8 Meg or something @ boot-time ?


tnx !!
	michael


btw: sry for my n00b'ism ;)


-----------------------------------------------------------------------
                Michael De Nil -- michael@aerythmic.be
       Linux LiSa 2.4.18 #4 SMP ma apr 1 11:11:48 CEST 2002 i686
      22:44:01 up  4:46,  3 users,  load average: 1.07, 0.46, 0.21
-----------------------------------------------------------------------

