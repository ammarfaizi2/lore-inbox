Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313256AbSC1U7A>; Thu, 28 Mar 2002 15:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313259AbSC1U6t>; Thu, 28 Mar 2002 15:58:49 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:57802 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313256AbSC1U6q>; Thu, 28 Mar 2002 15:58:46 -0500
Message-Id: <5.1.0.14.2.20020328205406.00aec720@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 28 Mar 2002 20:58:56 +0000
To: Vojtech Pavlik <vojtech@suse.cz>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] 2.5.7 IDE 26
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020328213413.A28299@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:34 28/03/02, Vojtech Pavlik wrote:
>On Thu, Mar 28, 2002 at 10:29:38AM +0100, Martin Dalecki wrote:
> > Wed Mar 20 23:17:06 CET 2002 ide-clean-26
> >
> > - Mark all members of structures, which get jiffies assigned or involved in
> >    ugly timeout calculations with the prefix PADAM_  for easy spotting. 
> This is
> >    Polish for "I'm falling down" or "This brings me to the knees" or slag
> >    comment for "What a sh..". Please be assured that it doesn't sound 
> vulgar.
>
>In Czech, too. :)

<AOL> In Bulgarian, too. (-: </AOL>

And same in <place your favourite slavic eastern european language here>...

Anton


> >    Please grep for it to see immediately why this nomenclature is 
> justified.
> >
> > - Rename hwifs_s to ata_channel and eliminate ide_hwifs_t as well as 
> the HWIF
> >    macro. OK this step makes this patch rather big.
>
>--
>Vojtech Pavlik
>SuSE Labs

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

