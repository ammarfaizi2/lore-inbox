Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTJaLgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 06:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbTJaLgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 06:36:24 -0500
Received: from pop.gmx.net ([213.165.64.20]:49305 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263244AbTJaLgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 06:36:23 -0500
Date: Fri, 31 Oct 2003 12:36:22 +0100 (MET)
From: "Mario Ohnewald" <mario.Ohnewald@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20031031112118.32444.qmail@linuxmail.org>
Subject: Re: Swap usage
X-Priority: 3 (Normal)
X-Authenticated: #929500
Message-ID: <16805.1067600182@www53.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hello!
> Hello Mario! 
> or ciao Mario! because your name really sounds Italian ;)
> 
> > I am running Kernel 2.4.21 on a unstable Debian box. I have included my
> IDE
> > Chipset driver
> > I have just ONE game server on it and do not use that box very much,
> > although, it uses its swap space for some reasons.
> 
> > load average: 0.00, 0.01, 0.00
> > Mem:    249136k total,   153572k used,    95564k free,    23636k buffers
> > Swap:   512024k total,   143652k used,   368372k free,    24500k cached
> 
> > # hdparm -t /dev/hda
> > /dev/hda:
> >  Timing buffered disk reads:  150 MB in  3.01 seconds =  49.83 MB/sec
> 
> > How can i find out why it is using so much swap, and how can i prevent
> it
> > form doing so? 
> > This swap usage makes my box very slow.
> 
> I can only suggest you to try on this machine the 2.4.23-pre9,
> it should really improve the VM.

Will the new 2.6.0 test9 solve this problem, too?

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

