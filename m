Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLPPFW>; Sat, 16 Dec 2000 10:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLPPFM>; Sat, 16 Dec 2000 10:05:12 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:41259 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129340AbQLPPE4>; Sat, 16 Dec 2000 10:04:56 -0500
Message-ID: <3A3B7D67.E56C75DD@holly-springs.nc.us>
Date: Sat, 16 Dec 2000 09:34:15 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.18pre25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <wtarreau@free.fr>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Linux 2.2.19pre1 : procfs api
In-Reply-To: <E1470sk-0001kp-00@the-village.bc.nu> <3A3A7915.5060006@holly-springs.nc.us> <976950324.3a3b1434d9519@imp.free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heh. Mangleage. :)

Willy Tarreau wrote:
> 
> Hello Michael, I wonder about this patch which only fixes an Id/author but no
> code.  It may be perfectly normal, but could also come from a mangled file in
> one of your trees. Just for info anyway...
> 
> Cheers,
> Willy
> 
> > diff -r -u -x CVS -x *.o linux-2.2.18pre25-VIRGIN/fs/proc/openpromfs.c
> zinux/fs/proc/openpromfs.c
> > --- linux-2.2.18pre25-VIRGIN/fs/proc/openpromfs.c     Fri Dec  8 14:57:07 2000
> > +++ zinux/fs/proc/openpromfs.c        Fri Dec  8 15:08:59 2000
> > @@ -1,4 +1,4 @@
> > -/* $Id: openpromfs.c,v 1.33 1999/04/28 11:57:33 davem Exp $
> > +/* $Id: openpromfs.c,v 1.1.1.1 2000/12/08 20:08:59 zapman Exp $
> >   * openpromfs.c: /proc/openprom handling routines
> >   *
> >   * Copyright (C) 1996-1998 Jakub Jelinek  (jj@sunsite.mff.cuni.cz)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
