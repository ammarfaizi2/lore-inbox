Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282018AbRKVCqA>; Wed, 21 Nov 2001 21:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282019AbRKVCpo>; Wed, 21 Nov 2001 21:45:44 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:9600 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S282018AbRKVCpV>; Wed, 21 Nov 2001 21:45:21 -0500
Message-ID: <004001c172ff$8de8b670$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Arnaldo Carvalho de Melo" <acme@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <000d01c172fc$cde53440$f5976dcf@nwfs> <20011122003428.B2216@conectiva.com.br>
Subject: Re: [PATCH] NetWare File System NWFS 2.4.15-pre8 Kernel Patch
Date: Wed, 21 Nov 2001 19:44:06 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Arnaldo Carvalho de Melo" <acme@conectiva.com.br>
To: "Jeff Merkey" <jmerkey@timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, November 21, 2001 7:34 PM
Subject: Re: [PATCH] NetWare File System NWFS 2.4.15-pre8 Kernel Patch


> Em Wed, Nov 21, 2001 at 07:24:25PM -0700, Jeff Merkey escreveu:
> >
> > A Kernel patch that integrate the NetWare File System (NWFS) into the
> > 2.4.15-pre8 kernel has been posted at
> > ftp.timpanogas.org:/nwfs/nwfs-2.4.15-pre8-1.bz2 and
> > ftp.utah-nac.org:/nwfs/nwfs-2.4.15-pre8-1.bz2
> >
> > This patch includes support for the 3Ware RAID Adapter and Linux
Software
> > RAID.
>
> Why don't you release three separate patches? One for NWFS, another for
the
> 3Ware controle and another for the Soft RAID? And please send it to the
> respective maintainers. I'm assuming that the two later patches are not
> related to NWFS, if not, please apologize.
>

This patch allows NWFS volumes to work with the 3Ware RAID Adapter and the
Linux
Software Raid.  It does not affect either the 3Ware or Linux RAID code, it
just allows my file system to use these features.

Jeff

> - Arnaldo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

