Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313567AbSDUQql>; Sun, 21 Apr 2002 12:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313568AbSDUQqk>; Sun, 21 Apr 2002 12:46:40 -0400
Received: from mail.scram.de ([195.226.127.117]:52684 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S313567AbSDUQqi>;
	Sun, 21 Apr 2002 12:46:38 -0400
Date: Sun, 21 Apr 2002 18:46:07 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@alpha.bocc.de
To: Anton Altaparmakov <aia21@cantab.net>
cc: Larry McVoy <lm@bitmover.com>, Roman Zippel <zippel@linux-m68k.org>,
        Jeff Garzik <garzik@havoc.gtf.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <5.1.0.14.2.20020421120820.040107b0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0204211844260.18496-100000@alpha.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

> >Wrong. Many corporate firewalls allow email and http (both via proxy) and
> >reject any other traffic. CVS and BK are both unusable in this
> >environment.
> 
> Not wrong. BK works fine over http protocol. CVS is another matter which I 
> cannot comment on...

Ok, but there are other scenarios where only email is available (often via 
mail gateways like softswitch on os/390)...

--jochen

