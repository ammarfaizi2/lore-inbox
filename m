Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288604AbSANBxd>; Sun, 13 Jan 2002 20:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288623AbSANBxW>; Sun, 13 Jan 2002 20:53:22 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:36812 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288604AbSANBxL>; Sun, 13 Jan 2002 20:53:11 -0500
Message-Id: <5.1.0.14.2.20020114014458.04c1d0b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 14 Jan 2002 01:53:09 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Linux 2.4.18pre3-ac1-aia21 (IDE patches)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16PwJO-0000F8-00@the-village.bc.nu>
In-Reply-To: <5.1.0.14.2.20020113232757.04f34ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:53 14/01/02, Alan Cox wrote:
> > Alan's -ac series is back! To celebrate this I added in the IDE patches 
> and
> > an NTFS update which dramatically reduces the number of vmalloc()s and 
> have
> > posted the resulting (tested) patch (to be applied on top of
> > 2.4.18pre3-ac1) at below URL.
>
>Andre's IDE patch is in the ac2 cut. I took it out just to make testing easier
>in case other people found -ac1 wasnt as reliable as I did 8)

That's ok. -ac2 isn't out yet AFAICS... (-;

Do you have the configure help entries in there, too?

btw. -ac1-aia1 is working very well on my desktop here. At least I wasn't 
able to break it with anything I threw at it. In fact it is working much 
better than before both interactivity wise and io wise. (-8

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

