Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314769AbSEHTAn>; Wed, 8 May 2002 15:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314872AbSEHTAm>; Wed, 8 May 2002 15:00:42 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:61452 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314769AbSEHTAk>; Wed, 8 May 2002 15:00:40 -0400
Message-Id: <5.1.0.14.2.20020508195954.040d2a80@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 08 May 2002 20:00:55 +0100
To: Andre Hedrick <andre@linux-ide.org>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] IDE 58
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10205081154370.30697-100000@master.linux-ide
 .org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:55 08/05/02, Andre Hedrick wrote:
>On Wed, 8 May 2002, Anton Altaparmakov wrote:
>
> > </me ignorant>Um, what about the IDE PCI cards which have 4 channels on
> > them? Like these two:
> >
> > Adaptec 2400 4Ch IDE Raid Controller
> > RocketRaid 404 4Ch ATA133 Raid Host Adaptor
>
>It is not an issue since they broadcast as single channel pairs per host.
>Martin is winning the argument hands down.

Thanks, I was just wondering not trying to argument...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

