Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRDWUJi>; Mon, 23 Apr 2001 16:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRDWUJ2>; Mon, 23 Apr 2001 16:09:28 -0400
Received: from sammy.netpathway.com ([208.137.139.2]:60939 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S129166AbRDWUJY>; Mon, 23 Apr 2001 16:09:24 -0400
Message-ID: <3AE48BD5.E0E40364@netpathway.com>
Date: Mon, 23 Apr 2001 15:08:53 -0500
From: "Gary White (Network Administrator)" <admin@netpathway.com>
Organization: Internet Pathway
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: KDE Lockups with emu10k1 driver in kernel > 2.4.3-ac9
In-Reply-To: <3AE47F9E.D8CF4B1B@netpathway.com> <Pine.LNX.4.33.0104232140340.1417-100000@localhost.localdomain> <3AE48996.AF51F5A9@netpathway.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking gain at the patches there wa only a few trivial changes made to the
audio.c, cardmi.h, mixer.c amd timer.h code.


> Yep I do. But looking at patch-2.4.3-ac10, there are lots of changes
> to the emu10k1 driver.
>
> > On Mon, 23 Apr 2001, Gary White (Network Administrator) wrote:
> >
> > There are no emu10k1 changes from ac9 up to ac12...
> > Do you have a VIA motherboard by any chance?
> >
> > Rui Sousa
> >
> > > Since ac9 I started having a lockup when initializing KDE 2.1.1.
> > > Did not think that much about it since my installation has had libs
> > > upgraded and patched for months. Today I decided to do a clean
> > > distribution install and after I had the same problem. Removing
> > > each module one at a time I finally narrowed in down to the
> > > Sound Blaster Live module. Every version including ac9 and
> > > before works fine. Has anybody else had this problem?
> > >
> > > --
> > > Gary White               Network Administrator
> > > admin@netpathway.com          Internet Pathway
> > > Voice 601-776-3355            Fax 601-776-2314
> > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> --
> Gary White               Network Administrator
> admin@netpathway.com          Internet Pathway
> Voice 601-776-3355            Fax 601-776-2314
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
Gary White               Network Administrator
admin@netpathway.com          Internet Pathway
Voice 601-776-3355            Fax 601-776-2314


