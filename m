Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284140AbRLAQLO>; Sat, 1 Dec 2001 11:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284136AbRLAQLH>; Sat, 1 Dec 2001 11:11:07 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:35765 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S284138AbRLAQKG>; Sat, 1 Dec 2001 11:10:06 -0500
Message-Id: <5.1.0.14.2.20011201160935.00ace4e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 01 Dec 2001 16:10:17 +0000
To: Marcus Meissner <mm@ns.caldera.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] Enhancement of /proc/partitions output (2.5.1-pre5)
Cc: dervishd@jazzfree.com (Ra?lN??ez de Arenas	 Coronado),
        linux-kernel@vger.kernel.org
In-Reply-To: <200112010847.fB18lcc21966@ns.caldera.de>
In-Reply-To: <E16A5XI-0005Lr-00@DervishD.viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:47 01/12/01, Marcus Meissner wrote:
>In article <E16A5XI-0005Lr-00@DervishD.viadomus.com> you wrote:
> >     Hello Anton :)
>
> >>Please consider below patch which adds the starting sector and number of
> >>sectors to /proc/partitions.
>
> >     This is a *great* idea. I was wondering why this information is
> > not included by default :)))
>
> >     I have a somewhat 'special' partition scheme and that information
> > is vital for me. Thanks a lot for the patch. I hope that Marcello
> > accepts it for 2.4.17...
>
>Marcelo, don't apply to this to 2.4, a lot of userland applications rely
>on it.

Absolutely, the subject does say 2.5.1-pre5. I never intended it for 2.4.x...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

