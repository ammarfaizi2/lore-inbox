Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSGASxp>; Mon, 1 Jul 2002 14:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSGASxp>; Mon, 1 Jul 2002 14:53:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:46291 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316339AbSGASxn>; Mon, 1 Jul 2002 14:53:43 -0400
Date: Mon, 1 Jul 2002 20:56:04 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
In-Reply-To: <Pine.LNX.3.96.1020701140915.23920A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.NEB.4.44.0207012045110.24810-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, Bill Davidsen wrote:

> I suggested that 2.5 be opened when 2.4 came out, so I like the idea of
> 2.7 starting when 2.6 is released. I think developers will maintain the
> 2.6 work out of pride and desire to have a platform for the "next big
> thing." And their code can always be placed on hold for 2.7 until they
> clarify their thinking on 2.6, if that's really needed.
>
> Most of the developers take pride in what they did in the recent past and
> would certainly not be a problem if a fix were needed. And if there is a
> reasonable -rc process there shouldn't be any major bugs of the "start
> over" variety.

This is IMHO a very bad idea:
- A stable base to start new development upon is a very good thing
  (and I don't believe in the stability of 2.6.0).
- Something I'd call the "Debian syndrome" will appear:
    There are only very few developers who run Debian stable because even
    during the release cycle there's always an unstable tree. One of the
    results is that many of the Debian developers aren't that much
    focussed on working on the next stable release (the current stable
    release of Debian is nearly two years old and doesn't support kernel
    2.4...).
  If 2.7 doesn't start before 2.6 is _really_ stable everyone who wants
  to have a new development tree is more interested in making 2.6 a really
  good kernel instead of focussing immediately on 2.7 .


Just my 0.02 (Euro-)cent
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox




