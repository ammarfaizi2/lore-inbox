Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313572AbSDURAZ>; Sun, 21 Apr 2002 13:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313596AbSDURAZ>; Sun, 21 Apr 2002 13:00:25 -0400
Received: from bitmover.com ([192.132.92.2]:63130 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313572AbSDURAX>;
	Sun, 21 Apr 2002 13:00:23 -0400
Date: Sun, 21 Apr 2002 10:00:22 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jochen Friedrich <jochen@scram.de>
Cc: Anton Altaparmakov <aia21@cantab.net>, Larry McVoy <lm@bitmover.com>,
        Roman Zippel <zippel@linux-m68k.org>,
        Jeff Garzik <garzik@havoc.gtf.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421100022.B10525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jochen Friedrich <jochen@scram.de>,
	Anton Altaparmakov <aia21@cantab.net>,
	Larry McVoy <lm@bitmover.com>, Roman Zippel <zippel@linux-m68k.org>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020421120820.040107b0@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0204211844260.18496-100000@alpha.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 06:46:07PM +0200, Jochen Friedrich wrote:
> > >Wrong. Many corporate firewalls allow email and http (both via proxy) and
> > >reject any other traffic. CVS and BK are both unusable in this
> > >environment.
> > 
> > Not wrong. BK works fine over http protocol. CVS is another matter which I 
> > cannot comment on...
> 
> Ok, but there are other scenarios where only email is available (often via 
> mail gateways like softswitch on os/390)...

BK works with email as its only transport and has for a long time.

	bk help send
	bk help receive
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
