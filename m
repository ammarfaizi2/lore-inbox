Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSGWXnH>; Tue, 23 Jul 2002 19:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318259AbSGWXnH>; Tue, 23 Jul 2002 19:43:07 -0400
Received: from vivi.uptime.at ([62.116.87.11]:60360 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id <S316898AbSGWXnG>;
	Tue, 23 Jul 2002 19:43:06 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'George France'" <france@handhelds.org>,
       "'Martin Brulisauer'" <martin@uceb.org>
Cc: <linux-kernel@vger.kernel.org>, "'Jay Estabrook'" <Jay.Estabrook@hp.com>
Subject: RE: kbuild 2.5.26 - arch/alpha
Date: Wed, 24 Jul 2002 01:44:44 +0200
Organization: =?US-ASCII?Q?UPtime_Systemlosungen?=
Message-ID: <003001c232a2$ef4ff280$1211a8c0@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <02072315005002.31958@shadowfax.middleearth>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-MailScanner: Nothing found, baby
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George France wrote:
[ ... ]
> > I am currently running 2.4.18 from SuSE without any (major)
> > problems. I found it here:
> > ftp://ftp.suse.com/pub/people/sf/axp/7.1/RPMS/kernel-source-
> > 2.4.18.SuSE-0.alpha.rpm.
> > Then I took arch/alpha/kernel/core_cia.c from version 2.4.12
> > (the current version does not run on XLT's booting with MILO;
> > the latest one is 2.4.12).
> 
> I have not tried Stefan's 2.4.18 kernel.  I am glad to hear 
> that it works for you. I will give it a try.

For 2.4.18 I have a very good experience. It's running on
our mailserver (as well an alpha-machine [ds10]) with ext3.
Without patches it worked well. Now I have a few patches
(most of them are from l-k list)...

> > > 2) taking a look at the latest 2.5.x in the next few 
> weeks, as we are
> > > aware that 2.5.x does not compile on Alpha.

[ ... ]

Just a comment:
2.5.26/27 doesn't create a modversions.h on my machine... So
make dep/clean and so on doesn't work for me...

-Oliver


