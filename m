Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276987AbRJHQoR>; Mon, 8 Oct 2001 12:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277003AbRJHQoH>; Mon, 8 Oct 2001 12:44:07 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:58187 "EHLO
	c0mailgw05.prontomail.com") by vger.kernel.org with ESMTP
	id <S276987AbRJHQoC>; Mon, 8 Oct 2001 12:44:02 -0400
Message-ID: <3BC1D7E4.C5DDC22A@starband.net>
Date: Mon, 08 Oct 2001 12:44:20 -0400
From: war <war@starband.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Question concering SBLIVE! driver.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried that, and yet it still has static and crackles.

Here is a picture of my aumix:
http://war.htmlplanet.com/linux/aumix.jpg

Also, secondary speakers did not work, however I've read that you need a

utility to set this up with the new driver.

The sound is OK except for the crackles, is there anyway to take the
driver
from 2.4.7 use it with 2.4.10?

On a side note, the usb-uhci-2.4.10.patch worked great with my usb
webcam, without the patch it
would freeze the machine.


Rui Sousa wrote:

> On Sun, 7 Oct 2001, war wrote:
>
> Try to mute all analog sound sources (that you are not using) and
reduce
> IGAIN mixer settings.
>
> Rui Sousa
>
> > I've noticed in Kernel 2.4.10 that the emu10k1 driver produces
cracks in
> > the sound output.
> >
> > Is there a stable emu10k1?
> >
> > The emu10k1 driver in all kernels < 2.4.7 is from 04-12-2000, which
> > produce excellent sound.
> >
> > I've spoken with a few other guys on IRC, and they also have this
> > problem [of crackling, etc].
> >
> > What would be the best course of action if one wants good sound in
> > kernels > 2.4.7?
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >

