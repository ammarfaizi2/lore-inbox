Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286581AbRLUVKi>; Fri, 21 Dec 2001 16:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286577AbRLUVK0>; Fri, 21 Dec 2001 16:10:26 -0500
Received: from 213-97-199-90.uc.nombres.ttd.es ([213.97.199.90]:8320 "HELO
	fargo") by vger.kernel.org with SMTP id <S286579AbRLUVKD> convert rfc822-to-8bit;
	Fri, 21 Dec 2001 16:10:03 -0500
From: "David Gomez" <davidge@viadomus.com>
Date: Fri, 21 Dec 2001 22:09:09 +0100 (CET)
X-X-Sender: <huma@fargo>
To: Dan Kegel <dkegel@ixiacom.com>
cc: <linux-kernel@vger.kernel.org>
Subject: re: Linux 2.4.17
In-Reply-To: <3C23988D.47A96760@ixiacom.com>
Message-ID: <Pine.LNX.4.33.0112212203460.1184-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > final:
> >
> > - Fix more loopback deadlocks                   (Andrea Arcangeli)
> > - Make Alpha with Nautilus chipset and
> >   Irongate chipset configuration compile
> >   correctly                                     (Michal Jaegermann)
> >
> > rc2:
> >
> > - Fix potential oops with via-rhine             (Andrew Morton)
> > - sysvfs: mark inodes as bad in case of read
> > ...
>
> Um, what happened to the idea of 'no changes between the last
> release candidate and final'?

I think the policy is 'not to add unnecessary changes' , not 'no changes'.

> I'm disappointed; I thought we were entering a new era of
> release discipline in the stable kernel.

I'd be dissapointed if Marcelo had released and stable kernel still
with the loopback deadlocks. And i don't think the alpha compile fix is
going to break anything.



David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra



