Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSEMPCF>; Mon, 13 May 2002 11:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSEMPCE>; Mon, 13 May 2002 11:02:04 -0400
Received: from h24-71-223-10.cg.shawcable.net ([24.71.223.10]:10556 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S313070AbSEMPCE>; Mon, 13 May 2002 11:02:04 -0400
Date: Mon, 13 May 2002 11:00:16 -0700
From: Andre LeBlanc <ap.leblanc@shaw.ca>
Subject: Re: More UDMA Troubles
To: linux-kernel@vger.kernel.org
Message-id: <000b01c1faa8$0a1320c0$2000a8c0@metalbox>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <Pine.LNX.4.33.0205131100590.11224-100000@coffee.psychology.mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You people Rule!

lol, Thanks

----- Original Message -----
From: "Mark Hahn" <hahn@physics.mcmaster.ca>
To: "Lionel Bouton" <lionel.bouton@inet6.fr>
Cc: "Andre LeBlanc" <ap.leblanc@shaw.ca>
Sent: Monday, May 13, 2002 8:03 AM
Subject: Re: More UDMA Troubles


> > 1/ get linux-2.4.18.tar.gz as you probably did for 2.5.15.
>
> and tar zxf it, of course.
>
> > 2/ before configuring the kernel sources:
>
> order doesn't matter; of course, you should keep around your
> various .config files for ease-of-reconfiguration.
>
> > - get patch-2.4.19-pre8.gz,
>
> or better: .bz2
>
> > - apply the patch by:
> >     . going into the 2.4.18 source directory,
> >     . running zcat <path_to_download_dir>/patch-2.4.19-pre8.gz |
patch -p1
>
> bzcat patch-2.4.19-pre8.bz2 | patch -sp0
> would work too.  there's no serious reason to watch all of patch's output,
> and no reason you have to do the cd/p1 thing.
>

