Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278795AbRKOAud>; Wed, 14 Nov 2001 19:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278800AbRKOAuX>; Wed, 14 Nov 2001 19:50:23 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:14916 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S278795AbRKOAuE>; Wed, 14 Nov 2001 19:50:04 -0500
Posted-Date: Thu, 15 Nov 2001 00:40:15 GMT
Date: Thu, 15 Nov 2001 00:40:14 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: CaT <cat@zip.com.au>
cc: Pascal Schmidt <pleasure.and.pain@web.de>, H Peter Anvin <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: fdutils.
In-Reply-To: <20011114123033.N991@zip.com.au>
Message-ID: <Pine.LNX.4.21.0111150027200.3058-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cat.

>>> Sure, but having to mount the CDROM means the drive is
>>> inaccessible during a rescue operation, so no restore from
>>> CDROM or CDRW backups is possible. ;) Mine runs out of a
>>> 4 MB ramdisk image.

>> Maybe that drive is inaccessible, but what about the other
>> drive? Many systems have both a CD (or DVD) drive and a
>> CD-RW as well nowadays.

> Are you guys trying to target the highest or lowest common
> denominator here? Because the more of this thread I read
> the more of the population you guys are excluding.

We're trying to include both.

Let's be honest: If we set things up so people with two CD drives
can't use the second drive simply because we've specialised in
people with only one drive, we're no better off than if we set
them up to require that one has two drives.

As I see it, there are the following options available:

 1. Insist that those using the rescue CD have two CD drives.

    In my book, that's a non-starter, so 'nuff said).

 2. Prohibit access to the CD drive for anything other than the
    rescue CD.

 3. Copy the contents of the CD into a ramdisk, then run from
    the ramdisk.

    If the user has enough RAM, maybe, but if not...

 4. Provide a "Virtual CD Drive" on single CD drive systems
    (similar to the way drive B: on MS-DOS 2.00 and later is a
    virtual floppy drive on single floppy systems).

    I'm not sure how this would work in practice, but it could
    be done, I'm sure.

Have I missed anything?

Best wishes from Riley.

