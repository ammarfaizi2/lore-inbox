Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbRKHAue>; Wed, 7 Nov 2001 19:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281213AbRKHAuQ>; Wed, 7 Nov 2001 19:50:16 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:39727 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S281210AbRKHAuK>; Wed, 7 Nov 2001 19:50:10 -0500
Message-Id: <4.3.2.7.2.20011107164408.00c043f0@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 07 Nov 2001 16:44:50 -0800
To: antirez <antirez@invece.org>,
        "Brenneke, Matthew Jeffrey (UMR-Student)" <mbrennek@umr.edu>
From: Stephen Satchell <satch@concentric.net>
Subject: Re: Yet another design for /proc. Or actually /kernel.
Cc: "'H. Peter Anvin'" <hpa@zytor.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <20011108012051.C568@blu>
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu>
 <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:20 AM 11/8/01 +0100, antirez wrote:
>/proc/mounts will be:
>
>((rem)(mounted filesystems))
>((format)(device)(mountpoint)(type)(option)(dump)(fsck))
>((data)(dev/hda1)(/home/mbrennek/stuff and)(vfat)(rw)(0)(0))
>((data)(/dev/hda2)(/var/tmp)(ext2)(rw)(0)(0))
>((rem)(number of filesystems mounted))
>((format)(mount_count))
>((data)(2))

Looks a little like LISPTH.  Flex and Bison to the rescue!

(signed) anonymous

