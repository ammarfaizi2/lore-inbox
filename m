Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbREMNad>; Sun, 13 May 2001 09:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261342AbREMNaX>; Sun, 13 May 2001 09:30:23 -0400
Received: from ecstasy.ksu.ru ([193.232.252.41]:57479 "EHLO ecstasy.ksu.ru")
	by vger.kernel.org with ESMTP id <S261264AbREMNaJ>;
	Sun, 13 May 2001 09:30:09 -0400
X-Pass-Through: Kazan State University network
Content-Type: text/plain;
  charset="us-ascii"
From: Art Boulatov <art@ksu.ru>
Organization: Kazan State University
To: "mirabilos" <eccesys@topmail.de>
Subject: Re: Linux support for Microsoft dynamic disks?
Date: Sun, 13 May 2001 17:22:52 +0400
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20010513000214.00ab3810@pop.cus.cam.ac.uk> <5.1.0.14.2.20010513105120.00ac37e0@pop.cus.cam.ac.uk> <01f001c0db9e$ef41b370$0100a8c0@homeip.net>
In-Reply-To: <01f001c0db9e$ef41b370$0100a8c0@homeip.net>
MIME-Version: 1.0
Message-Id: <01051317225200.00874@artsystems.ksu.ru>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 May 2001 03:15 pm, mirabilos wrote:

> ................
> I had (on a 2G disk) a NTFS, a FAT and some Linux partitions. It even
> refused
> to convert to dynamic disk. When it finally did, my Linux partitions
> vanished.
> You need this support to even be able to use linux on that disk... btw
> .........................

It is actiually possible to have both Linux and Windows 2000/Windows XP with 
dynamic disk on the same hard drive for now.

The thing is you have first to install Windows XP, leaving  required space 
for the Linux install, and convert the drive to dynamic disk.
When it is sucessfully converted you can reboot from linux floppy and "resize"
the last partition on the disk to the place where the free space actually 
begins.
Now it's possible to create some partitions here to install Linux.
The point is Windows still thinks there is an unpartioned space there,
where you just put your Linux distro :)

But thats not the option anyway,
and recognising dynamic disks would be a much better solution :). 

Art.

