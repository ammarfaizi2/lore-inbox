Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284186AbSALDiQ>; Fri, 11 Jan 2002 22:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284218AbSALDiG>; Fri, 11 Jan 2002 22:38:06 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:40133 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S284186AbSALDiC>;
	Fri, 11 Jan 2002 22:38:02 -0500
From: jt@bougret.hpl.hp.com
Date: Fri, 11 Jan 2002 19:37:22 -0800
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: Wireless Extension - new driver API - more drivers
Message-ID: <20020111193722.A16017@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020111184455.A15923@bougret.hpl.hp.com> <20020112033016.GB13389@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020112033016.GB13389@conectiva.com.br>; from acme@conectiva.com.br on Sat, Jan 12, 2002 at 01:30:16AM -0200
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 01:30:16AM -0200, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 11, 2002 at 06:44:55PM -0800, Jean Tourrilhes escreveu:
> > 	I've converted to new drivers to the new driver API for
> > Wireless Extensions, wavelan_cs and netwave_cs. I've added the
> > bloat/unbloat number in my comments.
> > 	I've updated all that on my web page :
> > http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html#newapi
> > 
> > 	If Linus is in a receptive mood, I would like to start feeding
> > those changes to kernel 2.5.X...
> > 
> > 	Have fun...
> 
> Fun indeed 8) I'm porting the Planet WireFree 3501 pcmcia wireless card
> driver from 2.0.36 to 2.4/2.5,

	Is it not another of those PrismII cards ? We already have 4
Linux drivers that support PrismII cards, so at least one could
extended...

> will take a look at your page to see what
> I'll have to ask Niemeyer (new kernelnewbie here) to do 8)

	Ok. My hope is that there is enough documentation and
examples, but shout. The old API won't go away, and the translation is
quite straightforward (but tedious).

> BTW, do you know about any AP GPLed software?

	There was this Italian startup (link on my web page), and of
course you can use either Jouni's driver or linux-wlan-ng with
additional firmware.

> - Arnaldo
> 
> PS.: this message was sent using the wl3501_cs driver on 2.4.17 8)

	Working nice, as I can see...

	Jean
