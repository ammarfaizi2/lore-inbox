Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSFBVb1>; Sun, 2 Jun 2002 17:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSFBVb0>; Sun, 2 Jun 2002 17:31:26 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:45802 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314243AbSFBVbZ>;
	Sun, 2 Jun 2002 17:31:25 -0400
Date: Sun, 2 Jun 2002 23:30:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Anthony Spinillo <tspinillo@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: INTEL 845G Chipset IDE Quandry
Message-ID: <20020602233043.A11698@ucw.cz>
In-Reply-To: <20020602101628.4230.qmail@linuxmail.org> <3CFA73C3.9010902@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2002 at 09:36:35PM +0200, Martin Dalecki wrote:
> Anthony Spinillo wrote:
> > Back to my original problem, will there be a fix before 2010? ;)
> 
> Well since you have already tyred yourself to poke at it.
> Well please just go ahead and atd an entry to the table
> at the end of piix.c which encompasses the device.
> Do it by copying over the next familiar one and I would
> be really geald if you could just test whatever this
> worked. If yes well please send me just the patch and
> I will include it.

Note it works with 2.5 already. We have the device there.

> 
> > 
> > Tony
> > 
> > 
> > Martin Dalecki wrote:
> > 
> > 
> >>Of year 2010 - remember learning proper C will take him time.
> >>Becouse I never ever saw any code contributed by him
> >>despite the fact that I'm still open for patches, as
> >>I have told him upon request.
> >>Once exception was a broken patch which even didn't
> >>compile and couldn't solve the problem it was
> >>proclaiming to solve.
> >>
> >>
> > 
> > 
> 
> 
> 
> -- 
> - phone: +49 214 8656 283
> - job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
> - langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
