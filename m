Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266785AbRGFSbb>; Fri, 6 Jul 2001 14:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266787AbRGFSbV>; Fri, 6 Jul 2001 14:31:21 -0400
Received: from latin2002.umich.mx ([148.216.6.188]:58051 "EHLO
	garota.fismat.umich.mx") by vger.kernel.org with ESMTP
	id <S266785AbRGFSbI>; Fri, 6 Jul 2001 14:31:08 -0400
Date: Fri, 6 Jul 2001 13:36:17 -0500 (CDT)
From: Ariel Molina Rueda <amolina@fismat.umich.mx>
To: Masoud <masu@phobos.sharif.edu>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Via82cxxx Codec rate locked at 48Khz: ALSA
In-Reply-To: <Pine.LNX.4.33.0107061413211.2034-100000@phobos.sharif.edu>
Message-ID: <Pine.LNX.4.33.0107061335120.2331-100000@garota.fismat.umich.mx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ALSA drivers have the same problem, i've already installed them...
thanx


On Fri, 6 Jul 2001, Masoud wrote:

> On Fri, 6 Jul 2001, Ariel Molina Rueda wrote:
>
> >
> > Greetings:
> >
> > When i used Redhat 7 and kernel 2.2.x y was happy with my souncard, now I
> > use RedHat 7.1 and Kernel 2.4.x, but sndconfig doesn't configure my
> > Via82c686 soundcard at all. At the ending it says
> >
> > via82cxxx codec rate locked at 48khz
> >
> > I use a Biostar MKE401B Matherboard with on-board sound (AC97)
> >
> > I've heard about patches for the intel chipsets, does anybody knows if one
> > for my card has been released, or how to fix this problem...
> > (my sound is  choppy and XMMS crashes!)
> >
> > something weird is that sound is good when Linus says:
> > "Hi, Im Linus Torvalds, and...."
> > then after sndconfig ends and sound is crying...
> >
> >
>
> You might consider using ALSA sound drivers.
> (http://www.alsa-project.org).
> Does any body know when they'd merge with mainstream kernel?
> (or are they going to be merged with kernel at all or not?)
> cheers,
> Masoud Sharbiani
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
_____________________________
Ariel Molina Rueda

amolina@fismat.umich.mx
-----------------------------

