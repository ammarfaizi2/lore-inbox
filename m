Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267644AbTAQTX1>; Fri, 17 Jan 2003 14:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbTAQTX1>; Fri, 17 Jan 2003 14:23:27 -0500
Received: from cs144171.pp.htv.fi ([213.243.144.171]:26127 "EHLO chip.ath.cx")
	by vger.kernel.org with ESMTP id <S267644AbTAQTX0>;
	Fri, 17 Jan 2003 14:23:26 -0500
Date: Fri, 17 Jan 2003 21:32:01 +0200 (EET)
From: Panu Matilainen <pmatilai@welho.com>
X-X-Sender: pmatilai@chip.ath.cx
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org, Andrew Walrond <andrew@walrond.org>,
       jw schultz <jw@pegasys.ws>
Subject: Re: any brand recomendation for a linux laptop ?
In-Reply-To: <20030116154004.GD31419@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0301172125160.20821-100000@chip.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003, Larry McVoy wrote:

> On Thu, Jan 16, 2003 at 04:37:27PM +0100, Jan-Benedict Glaw wrote:
> > On Thu, 2003-01-16 06:40:45 -0800, Larry McVoy <lm@bitmover.com>
> > wrote in message <20030116144045.GC30736@work.bitmover.com>:
> > > On Thu, Jan 16, 2003 at 02:14:27PM +0000, Andrew Walrond wrote:
> > 
> > > I like the T23 myself.  Wireless, ethernet, modem, DVD, fast.
> > 
> > Serial modem, or some winmodem type? I'd prefer to have a "real" modem,
> > though...
> 
> Winmodem.  I'm pretty sure I got it to work under Linux at some point but
> I'll admit that I boot into windows on those rare occasions I need a modem.
> Getting that stuff to work under Linux is fragile at best.

There's a driver at http://www.physcip.uni-stuttgart.de/heby/ltmodem/
It's worked quite well for me.. (with T21) The only real trouble with it 
is that it's largely binary only :(

Another caveat with T2x'es is that there are two kinds of them: for the 
seemingly more common variant the ltmodem driver works, for the other 
MiniPCI modem no driver exists.

-- 
	- Panu -

