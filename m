Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbTJTIae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTJTIae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:30:34 -0400
Received: from pop.gmx.de ([213.165.64.20]:39388 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262372AbTJTIac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:30:32 -0400
Date: Mon, 20 Oct 2003 10:30:31 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <3F939B1E.5020807@cyberone.com.au>
Subject: Re: HighPoint 374
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <24285.1066638631@www51.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> Svetoslav Slavtchev wrote:
> 
> >>On Sun, Oct 19 2003, Bartlomiej Zolnierkiewicz wrote:
> >>
> >>>Andre, thanks for helpful hint.
> >>>Svetoslav, the right person to whine about TCQ stuff is Jens Axboe 8-).
> >>>
> >>Well that's correct, but this looks more like an AS iosched bug :)
> >>
> >>>>You do not enable TCQ on highpoint without using the hosted polling
> >>>>
> >>timer.
> >>
> >>>>Oh and I have not added it, and so hit Bartlomiej up for the
> >>>>
> >>additions.
> >>
> >>For what? TCQ tests fine on a HPT370 here.
> >>
> >
> >cmdline : acpi=off pci=noacpi elevator=deadline
> >
> 
> Thanks, that would be good if you would test IDE TCQ problems with
> elevator=deadline. If it is working fine there, but you still get
> problems when using the default (AS) elevator then report them to me
> please.
> 

note taken :-)

svetljo

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

