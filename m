Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132698AbRC2KmL>; Thu, 29 Mar 2001 05:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132700AbRC2KmB>; Thu, 29 Mar 2001 05:42:01 -0500
Received: from smtp04.wxs.nl ([195.121.6.59]:40184 "EHLO smtp04.wxs.nl")
	by vger.kernel.org with ESMTP id <S132698AbRC2Kly>;
	Thu, 29 Mar 2001 05:41:54 -0500
Message-ID: <3AC31147.6035E09C@planet.nl>
Date: Thu, 29 Mar 2001 12:41:11 +0200
From: Erik van Asselt <e.van.asselt@planet.nl>
X-Mailer: Mozilla 4.7 [nl] (Win98; U)
X-Accept-Language: nl
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: "Henning P. Schmiedehausen" <hps@tanstaafl.de>,
   linux-kernel@vger.kernel.org
Subject: Re: Promise RAID controller howto?
In-Reply-To: <Pine.LNX.4.10.10103270806300.16125-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmmmm i have the Promise raid source for 2.2 kernel modules so what do you mean
by opensource signatures

i have it working for 2.2 kernels but i can't get it to work properly in 2.4
So if someone want to look at the source !!!
it can be found on www.promise.com

Assie

Andre Hedrick schreef:

> On Tue, 27 Mar 2001, Henning P. Schmiedehausen wrote:
>
> > Hi,
> >
> > I know, that this is a FAQ and the Promise RAID controller card is not
> > yet usable as a RAID board under Linux 2.x but is there a way to use
> > the controller just like the UltraATA 100 controller?
>
> It is not a raid board ... it is a raid lie
>
> > I know, that "input high == UltraATA core, input low = RAID core"
> > according to Andre Hedrick but I really don't care about the RAID
> > core. I want to use this controller to drive JBOD.
>
> Wrong, if Promise will opensource the signatures then we map the software
> raid against that location and use Linux's soft-raid.
>
> > Can one do this? The disks need not to be interchangeable to other
> > controllers.  Just be accessible.
> >
> > 2.2 solutions preferred, 2.4 ok.
> >
> >       Regards
> >               Henning
> >
> > --
> > Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
> > INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de
> >
> > Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
> > D-91054 Buckenhof     Fax.: 09131 / 50654-20
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> Andre Hedrick
> Linux ATA Development
> ASL Kernel Development
> -----------------------------------------------------------------------------
> ASL, Inc.                                     Toll free: 1-877-ASL-3535
> 1757 Houret Court                             Fax: 1-408-941-2071
> Milpitas, CA 95035                            Web: www.aslab.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

