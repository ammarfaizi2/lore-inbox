Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132365AbRAJI4h>; Wed, 10 Jan 2001 03:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133099AbRAJI41>; Wed, 10 Jan 2001 03:56:27 -0500
Received: from AStrasbourg-201-2-1-11.abo.wanadoo.fr ([193.251.1.11]:43527
	"EHLO lune.perinfo.com") by vger.kernel.org with ESMTP
	id <S132365AbRAJI4Q>; Wed, 10 Jan 2001 03:56:16 -0500
Message-ID: <040801c07ada$aa038330$8900030a@nicolasp>
From: "Nicolas Parpandet" <nparpand@perinfo.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <E14FytQ-0006cr-00@the-village.bc.nu>
Subject: Re: kernel network problem ?
Date: Wed, 10 Jan 2001 08:55:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 09, 2001 at 01:32:49PM +0000, Alan Cox wrote:
> > > If I were packaging a Linux distribution, I'd be sure to have ECN
disabled
> > > by default, FWIW.
> >
> > Probably the case. However the more people who pester the faulty sites
the
> > better. Did you ask the person how many reports he needed ....
> >
> > I certainly intend to run ECN on my mailhost once I trust 2.4 a bit
more.
> >
> > Alan
>
> Is anyone maintaing an automated sweep of sites that I can complain to all
> at once (for each 2.4 ecn system I install of course) rather then finding
> them one at a time as my connections fail?
>
> :)


With 2.4, disabling ECN correct the problem, at this time,

the few known sites are :

http://www.creative.com
http://www.fnac.com
http://ftpsearch.ntnu.no
http://www.hotmail.com


I'll create a site this week-end to maintain a list,
meanwhile everybody can send me bad hostnames.

Nicolas.





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
