Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLPHgS>; Sat, 16 Dec 2000 02:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130026AbQLPHgI>; Sat, 16 Dec 2000 02:36:08 -0500
Received: from smtp2.free.fr ([212.27.32.6]:55824 "EHLO smtp2.free.fr")
	by vger.kernel.org with ESMTP id <S129183AbQLPHgE>;
	Sat, 16 Dec 2000 02:36:04 -0500
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Subject: Re: [PATCH] Re: Linux 2.2.19pre1 : procfs api
Message-ID: <976950324.3a3b1434d9519@imp.free.fr>
Date: Sat, 16 Dec 2000 08:05:24 +0100 (MET)
From: Willy Tarreau <wtarreau@free.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E1470sk-0001kp-00@the-village.bc.nu> <3A3A7915.5060006@holly-springs.nc.us>
In-Reply-To: <3A3A7915.5060006@holly-springs.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 212.27.43.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael, I wonder about this patch which only fixes an Id/author but no
code.  It may be perfectly normal, but could also come from a mangled file in
one of your trees. Just for info anyway...

Cheers,
Willy

> diff -r -u -x CVS -x *.o linux-2.2.18pre25-VIRGIN/fs/proc/openpromfs.c
zinux/fs/proc/openpromfs.c
> --- linux-2.2.18pre25-VIRGIN/fs/proc/openpromfs.c	Fri Dec  8 14:57:07 2000
> +++ zinux/fs/proc/openpromfs.c	Fri Dec  8 15:08:59 2000
> @@ -1,4 +1,4 @@
> -/* $Id: openpromfs.c,v 1.33 1999/04/28 11:57:33 davem Exp $
> +/* $Id: openpromfs.c,v 1.1.1.1 2000/12/08 20:08:59 zapman Exp $
>   * openpromfs.c: /proc/openprom handling routines
>   *
>   * Copyright (C) 1996-1998 Jakub Jelinek  (jj@sunsite.mff.cuni.cz)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
