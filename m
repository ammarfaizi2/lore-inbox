Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTEVPTy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTEVPTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:19:54 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:25604 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261959AbTEVPTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:19:34 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: "Oliver Pitzeier" <o.pitzeier@uptime.at>,
       "'Sven Krohlas'" <darkshadow@web.de>, <marcelo@conectiva.com.br>,
       <alan@lxorguk.ukuu.org.uk>
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Date: Thu, 22 May 2003 17:31:00 +0200
User-Agent: KMail/1.5.1
Cc: <linux-kernel@vger.kernel.org>
References: <004a01c32075$7e2a7500$020b10ac@pitzeier.priv.at>
In-Reply-To: <004a01c32075$7e2a7500$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305221731.00900.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 May 2003 17:19, Oliver Pitzeier wrote:

http://people.freebsd.org/~gibbs/linux/SRC/

nothing more to say.

> Sven Krohlas <darkshadow@web.de> wrote:
> > > Here goes release canditate 2. The aic7xxx problems should be fixed.
> >
> > I've still got the same stability problems as with rc1.
> > I booted rc2 and it was working fine for two or three hours.
> > Then I thought "Hey, while I go to work I could rip and
> > encode a CD". Well, so did I, and just as it started to rip
> > the 2nd track (and to encode the first one with oggenc) the
> > system froze. Sound stopped playing, the mouse froze, nothing
> > worked.
>
> You didn't see a kernel panic as well? I'm asking, because I have the same
> problems with one of my machines...
>
> When was this problem introduced? Does 2.4.19, or 2.4.20 work well?
>
> > As before I found nothing in the logs.
>
> Me too. The system freezes completly. I believed it's a problem with the
> temperature at our server housing location, but it seems it is not (mounted
> additional fans during the night and now the system is dead again).
>
> [ ... ]
>
> > My system is a AMD K6-2+, Asus P5A, SB AWE 64 ISA PnP (I used
> > Alsa 0.9.2, but in rc1 I also had problems without it),
> > nVidia TNT, two cheap network cards and a few disks.
>
> My one is a Dual-P III 1GHz... I have no USB, Sound or that stuff
> enabled... It's also a SCSI-only system if this does matter...
>
> Best regards,
>  Oliver
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


