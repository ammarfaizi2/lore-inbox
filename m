Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130670AbQL1Pny>; Thu, 28 Dec 2000 10:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130685AbQL1Pno>; Thu, 28 Dec 2000 10:43:44 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:7655 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S130670AbQL1Pnd>; Thu, 28 Dec 2000 10:43:33 -0500
Message-ID: <3A4B585C.4C6A0B16@home.net>
Date: Thu, 28 Dec 2000 10:12:29 -0500
From: Shawn Starr <shawn.starr@home.net>
Reply-To: shawn.starr@home.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan.Cox@linux.org, linux-kernel@vger.kernel.org
Subject: Re: Linux kernel 2.2.19ac2
In-Reply-To: <3A4B51AC.E27FF483@home.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bleh, ignore that. I fixed the problem. dont know what I did though but its
ok now..

Shawn Starr wrote:

Dec 28 09:31:59 coredump kernel: Filesystem panic (dev 03:41).

> Dec 28 09:31:59 coredump kernel:   FAT error
> Dec 28 09:31:59 coredump kernel:   File system has been set read-only
> Dec 28 09:31:59 coredump kernel: Directory 401: bad FAT
> Dec 28 09:32:16 coredump kernel: Filesystem panic (dev 03:41).
> Dec 28 09:32:16 coredump kernel:   FAT error
> Dec 28 09:32:16 coredump kernel:   File system has been set read-only
> Dec 28 09:32:16 coredump kernel: Directory 503: bad FAT
>
> hmmm, there appears to be a problem with the fat or vfat driver. Im
> using Windows 2000 on a different hard drive which is using FAT32 for
> the filesystem.
>
> When I rebooted into Win2k the system did not detect a corrupt FAT.
>
> Im going to compile 2.2.19ac3 today and see if this was a known issue or
> not.
>
> I dont know what information I can give you other then what the log
> shows.
>
> Thanks,
>
> Shawn Starr.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
