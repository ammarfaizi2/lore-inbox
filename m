Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277400AbRJJUL4>; Wed, 10 Oct 2001 16:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277394AbRJJULv>; Wed, 10 Oct 2001 16:11:51 -0400
Received: from h181s242a129n47.user.nortelnetworks.com ([47.129.242.181]:61830
	"HELO zcars0mt.") by vger.kernel.org with SMTP id <S277403AbRJJULE>;
	Wed, 10 Oct 2001 16:11:04 -0400
Date: Wed, 10 Oct 2001 16:07:02 -0400
Message-Id: <200110102007.QAA26329@zcars0mt.>
To: linux-kernel@vger.kernel.org
From: war <war@starband.net>
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

