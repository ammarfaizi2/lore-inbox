Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313907AbSEAS47>; Wed, 1 May 2002 14:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313914AbSEAS46>; Wed, 1 May 2002 14:56:58 -0400
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:49413 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S313907AbSEAS46>; Wed, 1 May 2002 14:56:58 -0400
Message-Id: <5.1.0.14.2.20020501205616.00d31b40@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 01 May 2002 20:57:13 +0200
To: linux-kernel@vger.kernel.org
From: system_lists@nullzone.org
Subject: Re: SEVERE Problems in 2.5.12 at uid0 access
In-Reply-To: <Pine.GSO.4.21.0205011417230.12640-100000@weyl.math.psu.edu
 >
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks to all (Viro, Skip, Bob and Pierre).

At 14:18 01/05/2002 -0400, Alexander Viro wrote:


>On Wed, 1 May 2002, Bob_Tracy wrote:
>
> > Confirmed on a 2.5.11 system as well.  Talk about your basic heart
> > attack!  I'd just installed Postfix and found that I couldn't access
> > any of the directories under /var/spool/postfix.  Fortunately (?),
> > I've got older kernels to fall back on, and that's one of the hazards
> > of running on the bleeding edge I reckon.
> >
> > Oh yeah...  ext2 filesystem.  I think this bug is at least mostly
> > independent of the filesystem type.
>
>Yes, it is.  Look for the patch I've posted yesterday (subject was
>something like "[PATCH] missing checks", IIRC).




