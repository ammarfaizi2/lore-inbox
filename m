Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274049AbRISNVd>; Wed, 19 Sep 2001 09:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274051AbRISNVY>; Wed, 19 Sep 2001 09:21:24 -0400
Received: from AMontpellier-201-1-1-55.abo.wanadoo.fr ([193.252.31.55]:44296
	"EHLO awak") by vger.kernel.org with ESMTP id <S274049AbRISNVN> convert rfc822-to-8bit;
	Wed, 19 Sep 2001 09:21:13 -0400
Subject: Re: 2.4.9-ac10 hangs on CDROM read error
From: Xavier Bestel <xavier.bestel@free.fr>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Jens Axboe <axboe@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <XFMail.20010919151538.pochini@shiny.it>
In-Reply-To: <XFMail.20010919151538.pochini@shiny.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.13.99+cvs.2001.09.18.04.53 (Preview Release)
Date: 19 Sep 2001 15:16:17 +0200
Message-Id: <1000905378.31487.25.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le mer 19-09-2001 at 15:15 Giuliano Pochini a écrit :
> 
> >> > I have an ABit VP6, CDRW as hdc and DVD as hdd (VIA vt82c686b IDE
> >> > driver), with SCSI emulation on top, and when I read either:
> >> >
> >> > - a DVD with a read error in the DVD drive (UDF mounted, ripping)
> >> >
> >> > - a CDR with a read error in the CDRW drive (ISO mounted)
> >> >
> >> > the system hangs - no ping, no sysrq, nothing. no log.
> >>
> >> I have the same problem with PowerMac G3 and G4 with IDE drives. No
> >> problems with SCSI, where read just stops with an I/O error.
> >
> > Could one of you hook up a serial console and attempt to capture any
> > oops info?
> 
> No oops or panic or anything, as far as I can remember. I have access
> to a IDE equipped G4 right now. I'll try to reproduce the lockup this
> night (hmm, what CD can I scrape? :)) ). Stay tuned...

Yes, no Oops - I tried with a VGA console.

           Xav

