Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284627AbRLPONh>; Sun, 16 Dec 2001 09:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284619AbRLPON2>; Sun, 16 Dec 2001 09:13:28 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:42253 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S284627AbRLPONQ>; Sun, 16 Dec 2001 09:13:16 -0500
Message-Id: <4.3.2.7.2.20011216091040.00d7c180@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 16 Dec 2001 09:13:13 -0500
To: lkml <linux-kernel@vger.kernel.org>
From: David Relson <relson@osagesoftware.com>
Subject: Re: Linux 2.4.17-rc1
In-Reply-To: <E16FTOd-00007M-00@starship.berlin>
In-Reply-To: <Pine.LNX.4.21.0112131841080.28446-100000@freak.distro.conectiva>
 <Pine.LNX.4.21.0112131841080.28446-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IMHO, 2.4.17-rc1 seems to be ready to be promoted to 2.4.17. It's passed a 
suitable "release candidate" test - available for a couple of days and 
nobody has found any major problems.

David

At 11:59 PM 12/15/01, Daniel Phillips wrote:
>On December 13, 2001 09:44 pm, Marcelo Tosatti wrote:
> > rc1:
> >
> > - Finish MODULE_LICENSE fixups for fs/nls     (Mark Hymers)
> > - Console race fix                            (Andrew Morton/Robert Love)
> > - Configure.help update                               (Eric S. Raymond)
> > - Correctly fix Direct IO bug                 (Linus Benedict Torvalds)
> > - Turn off aacraid debugging                  (Alan Cox)
> > - Added missing spinlocking in do_loopback()  (Alexander Viro)
> > - Added missing __devexit_p() in i82092
> >   pcmcia driver                                       (Keith Owens)
> > - ns83820 zerocopy bugfix                     (Benjamin LaHaise)
> > - Fix VM problems where cache/buffers didn't get
> >   freed                                               (me)
>
>Will there be a rc2?
>
>--
>Daniel
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

