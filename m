Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSFCLIQ>; Mon, 3 Jun 2002 07:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317370AbSFCLIP>; Mon, 3 Jun 2002 07:08:15 -0400
Received: from daimi.au.dk ([130.225.16.1]:60553 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317366AbSFCLIN>;
	Mon, 3 Jun 2002 07:08:13 -0400
Message-ID: <3CFB4E19.C916D938@daimi.au.dk>
Date: Mon, 03 Jun 2002 13:08:09 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: Christian Vik <cvik@vanadis.no>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, dstephenson@snapserver.com
Subject: Re: SV: RAID-6 support in kernel?
In-Reply-To: <A2C65A3296DA4A4FB30DB57A9A464A16436851@exchange.lan.vanadis.no> <200206030959.g539xXb31139@mail.pronto.tv>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> Below is a (patented?)

No problem for me I live in Europe.

> version that works. This is from the linux-raid list
> 
> >  A1   A2  (P1) (PA)
> > (P2) (PB)  B2   B1

Nice, looks like it works.

> >  C4   C3  (PC) (P3)
> > (PD) (P4)  D3   D4

In this encoding the roles of disk one and two are
switched, and three and four are also switched. Are
there any reason for this?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
