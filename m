Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271809AbRIHSpR>; Sat, 8 Sep 2001 14:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271805AbRIHSpG>; Sat, 8 Sep 2001 14:45:06 -0400
Received: from ip122-15.asiaonline.net ([202.85.122.15]:63667 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S271809AbRIHSoz>; Sat, 8 Sep 2001 14:44:55 -0400
Message-ID: <3B9A66B8.D165155B@rcn.com.hk>
Date: Sun, 09 Sep 2001 02:43:04 +0800
From: David Chow <davidchow@rcn.com.hk>
Organization: Resources Computer Network Ltd.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Contribution of the linux kernel development
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

First thanks to Linus who start this wonderful OS and giving out for
free. I am from Hong Kong and I would like to contribute on linux kerenl
developments. I am a newbie to linux kernel hacking. I started on memory
management system as my company is developing a linux native hardware
platform which is a diskless computer. Now I am writing experimental
filesystems using the idea from Erez who wrote the FiST which is a
powerful stackable filesystem. I am now debuging the code from him to
make the filesystem working properly on a production system. My work is
to improve the reliability, performance and manageability of the
platform. That makes me dig in deep into the kernel recently. I
sucessfully ported the code for nfsswap from Justus Heine to kernel from
2.4.0 to 2.4.6 , up to know my system is running 2.4.4 . I also improve
the code a bit to improve some of the overheads and now it is running
fine on the system. But I notice that the sources from the kernel seems
want a future of nfs swap support, but there are not official code for
this at the moment. I have tested the nfsswap code for a couple of
months and reporting no errors at all even under extreme high loaded
ethernet. I would be happy to make myself contributing the kernel
development and supporting the work for nfsswap and FiST . I would like
to share the code with others. If this message is heard by the VFS
maintainer, please contact me. Thanks.

regards,

David Chow
