Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbSALNWj>; Sat, 12 Jan 2002 08:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286262AbSALNW3>; Sat, 12 Jan 2002 08:22:29 -0500
Received: from firewall.sfn.asso.fr ([193.49.43.1]:59786 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S286338AbSALNWU>;
	Sat, 12 Jan 2002 08:22:20 -0500
Date: Sat, 12 Jan 2002 14:21:54 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wireless Extension - new driver API - more drivers
Message-ID: <20020112142154.B28511@pcmaftoul.esrf.fr>
In-Reply-To: <20020111184455.A15923@bougret.hpl.hp.com> <20020112033016.GB13389@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020112033016.GB13389@conectiva.com.br>; from acme@conectiva.com.br on Sat, Jan 12, 2002 at 01:30:16AM -0200
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
> driver from 2.0.36 to 2.4/2.5, will take a look at your page to see what
> I'll have to ask Niemeyer (new kernelnewbie here) to do 8)
> 
> BTW, do you know about any AP GPLed software?
The only chip I read that can be used as an AP is the Interstil Prism2.
I don't know whether it is Prism2 based or not but if it is, you can
use:
www.epitest.fi/Prism2 ( carefull , case sensitive webserver )
> 
> - Arnaldo
> 
> PS.: this message was sent using the wl3501_cs driver on 2.4.17 8)
So cool :)
        Sam
