Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSALDap>; Fri, 11 Jan 2002 22:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284186AbSALDaf>; Fri, 11 Jan 2002 22:30:35 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:27912 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S284180AbSALDaZ>;
	Fri, 11 Jan 2002 22:30:25 -0500
Date: Sat, 12 Jan 2002 01:30:16 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Gustavo Niemeyer <niemeyer@conectiva.com>
Subject: Re: Wireless Extension - new driver API - more drivers
Message-ID: <20020112033016.GB13389@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	jt@hpl.hp.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Gustavo Niemeyer <niemeyer@conectiva.com>
In-Reply-To: <20020111184455.A15923@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020111184455.A15923@bougret.hpl.hp.com>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 11, 2002 at 06:44:55PM -0800, Jean Tourrilhes escreveu:
> 	I've converted to new drivers to the new driver API for
> Wireless Extensions, wavelan_cs and netwave_cs. I've added the
> bloat/unbloat number in my comments.
> 	I've updated all that on my web page :
> http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html#newapi
> 
> 	If Linus is in a receptive mood, I would like to start feeding
> those changes to kernel 2.5.X...
> 
> 	Have fun...

Fun indeed 8) I'm porting the Planet WireFree 3501 pcmcia wireless card
driver from 2.0.36 to 2.4/2.5, will take a look at your page to see what
I'll have to ask Niemeyer (new kernelnewbie here) to do 8)

BTW, do you know about any AP GPLed software?

- Arnaldo

PS.: this message was sent using the wl3501_cs driver on 2.4.17 8)
