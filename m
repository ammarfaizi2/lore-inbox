Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSGLOOf>; Fri, 12 Jul 2002 10:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSGLOOf>; Fri, 12 Jul 2002 10:14:35 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21206 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316530AbSGLOOd>; Fri, 12 Jul 2002 10:14:33 -0400
Date: Fri, 12 Jul 2002 16:17:07 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Thunder from the hill <thunder@ngforever.de>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
       "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <Pine.LNX.4.44.0207120649180.3421-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.SOL.4.30.0207121611170.14389-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jul 2002, Thunder from the hill wrote:

> Hi,
>
> On Fri, 12 Jul 2002, Martin Dalecki wrote:
> > Against:
> >
> > 1. Bartlomiej Zolnierkiewcz.
>
> What's your reason to vote against him? Something personal?
>

I don't vote against him but against stupid changes.

I try not to mess technical issues with personal ones
and I have nothing personal to Martin, only technical ;-)

We can't immediately get rid of ide-cd/floppy/tape.c, look through
them, then look through ide-scsi.c and sr.c and you will understand why.

(or not :-( )

Regards
--
Bartlomiej


> 							Regards,
> 							Thunder
> --
> (Use http://www.ebb.org/ungeek if you can't decode)
> ------BEGIN GEEK CODE BLOCK------
> Version: 3.12
> GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
> N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
> e++++ h* r--- y-
> ------END GEEK CODE BLOCK------
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

