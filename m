Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132917AbRAJFKW>; Wed, 10 Jan 2001 00:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132970AbRAJFKM>; Wed, 10 Jan 2001 00:10:12 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:65285
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132917AbRAJFKA>; Wed, 10 Jan 2001 00:10:00 -0500
Date: Tue, 9 Jan 2001 21:09:39 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Paul Bristow <paul@paulbristow.net>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.4.0 MAINTAINERS for ide-floppy updates
In-Reply-To: <3A5B961B.857B8802@paulbristow.net>
Message-ID: <Pine.LNX.4.10.10101092108380.22537-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is valid that Paul is maintaining that subdriver as GADI is doing a
StartUp in Video stuff.

Cheers,

On Tue, 9 Jan 2001, Paul Bristow wrote:

> Linus, Alan,
> 
> Could you please apply this patch to the MAINTAINERS file so that the
> 2.4.x
> IDE-FLOPPY maintainer is correctly identified as me and not Gadi any
> more.
> This change happened at 2.2.18 for the 2.2.x tree.
> 
> I am discussing with Sam the previous patch that Alan applied in
> 2.4.0-ac4 for 1.44M floppy formatting in LS-120 drives.
> 
> Regards,
> 
> -- 
> 
> Paul
> 
> Email:	paul@paulbristow.net
> Web:	http://paulbristow.net
> ICQ:	11965223
> 
> 
> Patch follows
> 
> diff -ur linux-2.4.0/MAINTAINERS linux/MAINTAINERS
> --- linux-2.4.0/MAINTAINERS     Sun Dec 31 18:31:15 2000
> +++ linux/MAINTAINERS   Tue Jan  9 23:20:48 2001
> @@ -594,9 +594,16 @@
>  W:     http://www.kernel.dk
>  S:     Maintained
>  
> -IDE/ATAPI TAPE/FLOPPY DRIVERS
> +IDE/ATAPI TAPE DRIVERS
>  P:     Gadi Oxman
>  M:     Gadi Oxman <gadio@netvision.net.il>
> +L:     linux-kernel@vger.kernel.org
> +S:     Maintained
> +
> +IDE/ATAPI FLOPPY DRIVERS
> +P:     Paul Bristow
> +M:     Paul Bristow <paul@paulbristow.net>
> +W:     http://paulbristow.net/linux/idefloppy.html
>  L:     linux-kernel@vger.kernel.org
>  S:     Maintained
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
