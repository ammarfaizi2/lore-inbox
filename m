Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279441AbRJZV6d>; Fri, 26 Oct 2001 17:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279455AbRJZV6X>; Fri, 26 Oct 2001 17:58:23 -0400
Received: from ns1.system-techniques.com ([199.33.245.254]:34177 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S279443AbRJZV6J>; Fri, 26 Oct 2001 17:58:09 -0400
Date: Fri, 26 Oct 2001 17:58:40 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Looking for bsd file system tools under linux .
In-Reply-To: <20011026144642.V23590@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0110261712320.5754-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Andreas ,

On Fri, 26 Oct 2001, Andreas Dilger wrote:
> On Oct 26, 2001  14:58 -0400, Mr. James W. Laferriere wrote:
> > 	Hello All ,  I am looking for pointers to bsd file system tools
> > 	for use under Linux .  A couple of searchs left me empty .
> > 	I am hoping someone here has a pointer or two .
> > 	What this is for is ,  I have a disk drive off of a bsd4.2 system
> > 	that may have been used in a penetration of another system .
> > 	The fstab file points at there having been a /var file system but
> > 	when I do a 'fdisk -l' a partition for /var does not exist .  Only
> > 	two partitions are there for / & /usr .  I am looking for some
> > 	tools to see if the partiton was removed or if 'parted' may have
> > 	been been used to squeese it out .  Thank you for any pointers .
>
> You may need to have BSD partition support enabled in the kernel in order
> to access the partition.  I would think fdisk would be able to show the
> right data in all cases, but I've never used BSD partitions before either.
	Yes , Been there done that ;-) .  All fdisk showed was the two
	partitions mentioned above .  What I am trying to accertain is if
	the partition has been removed & squashed or just mislayed in a
	bad entry in the old 2.4.5 kernel I was running .  I am at present
	getting the digging machine upto 2.4.13 .  Tia ,  JimL

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+


