Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284791AbRLPU3C>; Sun, 16 Dec 2001 15:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284800AbRLPU2w>; Sun, 16 Dec 2001 15:28:52 -0500
Received: from flrtn-2-m1-236.vnnyca.adelphia.net ([24.55.67.236]:42405 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S284791AbRLPU2h>;
	Sun, 16 Dec 2001 15:28:37 -0500
Message-ID: <3C1D03EB.9118B47B@pobox.com>
Date: Sun, 16 Dec 2001 12:28:27 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Relson <relson@osagesoftware.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-rc1
In-Reply-To: <Pine.LNX.4.21.0112131841080.28446-100000@freak.distro.conectiva>
	 <Pine.LNX.4.21.0112131841080.28446-100000@freak.distro.conectiva> <4.3.2.7.2.20011216091040.00d7c180@mail.osagesoftware.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Relson wrote:

> IMHO, 2.4.17-rc1 seems to be ready to be promoted to 2.4.17. It's passed a
> suitable "release candidate" test - available for a couple of days and
> nobody has found any major problems.

er - the loopback hangs?

cu

jjs

>
>
> David
>
> At 11:59 PM 12/15/01, Daniel Phillips wrote:
> >On December 13, 2001 09:44 pm, Marcelo Tosatti wrote:
> > > rc1:
> > >
> > > - Finish MODULE_LICENSE fixups for fs/nls     (Mark Hymers)
> > > - Console race fix                            (Andrew Morton/Robert Love)
> > > - Configure.help update                               (Eric S. Raymond)
> > > - Correctly fix Direct IO bug                 (Linus Benedict Torvalds)
> > > - Turn off aacraid debugging                  (Alan Cox)
> > > - Added missing spinlocking in do_loopback()  (Alexander Viro)
> > > - Added missing __devexit_p() in i82092
> > >   pcmcia driver                                       (Keith Owens)
> > > - ns83820 zerocopy bugfix                     (Benjamin LaHaise)
> > > - Fix VM problems where cache/buffers didn't get
> > >   freed                                               (me)
> >
> >Will there be a rc2?
> >
> >--
> >Daniel
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

