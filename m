Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278583AbRJSSdY>; Fri, 19 Oct 2001 14:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278585AbRJSSdH>; Fri, 19 Oct 2001 14:33:07 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:21519 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S278583AbRJSScn>;
	Fri, 19 Oct 2001 14:32:43 -0400
Date: Fri, 19 Oct 2001 11:35:15 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: J Sloan <jjs@lexus.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.12 breaks fdisk (ignore all reports)
In-Reply-To: <3BD07066.182DA478@lexus.com>
Message-ID: <Pine.LNX.4.10.10110191132321.10415-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AARGH just saw it..

I mistyped the drive in the last paste. :/

sda not hda *sigh*

false alarm.

	Gerhard




On Fri, 19 Oct 2001, J Sloan wrote:

> I have seen this on some systems -
> 
> IFAIK it is a BIOS problem, not a
> kernel problem -
> 
> cu
> 
> jjs
> 
> Gerhard Mack wrote:
> 
> > Somone break something?  I can only seem to access new partitions after a
> > reboot.
> >
> > Calling ioctl() to re-read partition table.
> > rotyla:~# mkreiserfs /dev/hda4
> >
> > <-------------mkreiserfs, 2001------------->
> > reiserfsprogs 3.x.0j
> >
> > count_blocks: open failed (No such device or address)
> >
> > rotyla:~# mke2fs /dev/hda4
> > mke2fs 1.25 (20-Sep-2001)
> > mke2fs: No such device or address while trying to determine filesystem
> > size
> >
> > --
> > Gerhard Mack
> >
> > gmack@innerfire.net
> >
> > <>< As a computer I find your faith in technology amusing.
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

