Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317421AbSGIV1A>; Tue, 9 Jul 2002 17:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317422AbSGIV1A>; Tue, 9 Jul 2002 17:27:00 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40921 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317421AbSGIV06>; Tue, 9 Jul 2002 17:26:58 -0400
Date: Tue, 9 Jul 2002 23:29:26 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Anders Peter Fugmann <afu@fugmann.dhs.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] using 2.5.25 with IDE
In-Reply-To: <3D2B2856.4040605@fugmann.dhs.org>
Message-ID: <Pine.SOL.4.30.0207092327060.28777-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks, known and should be already fixed by Alexander Atanasov.

On Tue, 9 Jul 2002, Anders Peter Fugmann wrote:

> Applying the patches (incl the 98-pre patch)
> gives two compile errors in tcq.c.
>
> Fixing those (trivial), made the system crash just after finding the first HD,
> giving the output: 'tcq_start'
>
> The system was rebootable with <sys-rq><b>.
>
> Regards
> Anders Fugmann.
>
> Bartlomiej Zolnierkiewicz wrote:
> > Contrary to the popular belief 2.5.25 has only Martin's IDE-93
> > and has broken locking...
> >
> > If you want to run IDE on 2.5.25 get and apply:
> >
> > IDE-94 by Martin
> > IDE-95/96/97/98-pre by me
> >
> > from:
> > http://home.elka.pw.edu.pl/~bzolnier/ata/
> >
> > --
> > Bartlomiej


