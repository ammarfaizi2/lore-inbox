Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbTA2JYx>; Wed, 29 Jan 2003 04:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTA2JYw>; Wed, 29 Jan 2003 04:24:52 -0500
Received: from AGrenoble-101-1-6-201.abo.wanadoo.fr ([80.11.197.201]:7689 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S265513AbTA2JYw>;
	Wed, 29 Jan 2003 04:24:52 -0500
Subject: Re: Bootscreen
From: Xavier Bestel <xavier.bestel@free.fr>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Robert Morris <rob@r-morris.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200301290913.h0T9Dnp2008484@eeyore.valparaiso.cl>
References: <200301290913.h0T9Dnp2008484@eeyore.valparaiso.cl>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1043832945.9066.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 29 Jan 2003 10:35:47 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 29/01/2003 à 10:13, Horst von Brand a écrit:
> Roy Sigurd Karlsbakk <roy@karlsbakk.net> said:
> 
> [...]
> 
> > You'll never send an engineer out to replace a set-top-box. You'll just
> > wait for the customer to return the box and send out a new one. Software
> > doesn't fail on those - it's some 99.9% hardware failure. If you get a
> > hang or panic or something, the boxes usually have watchdogs to take care
> > of that (and then reboot automatically). The average computer-frightened
> > user getting an STB from the VoD/IPTV company (or her ISP) don't want to
> > see any kernel gibberish. They just want a nice splash screen telling
> > them "everything's gonna be alright in 45 seconds" or something. Trouble
> > shooting is done in the lab after the box is returned
> 
> Right. And this is a very specialized application, where the vendor will
> install a heavily hacked system anyway, as they won't have standard VGA or
> keyboard or...

What we did with our appliances is make them display the boot messages
(i.e. the console) on a hidden serial port (you had to solder pins on
the "motherboard" to get to it). That way the screen (which is only an
LCD) is free for whatever boot message the bootloader wants to print.

	Xav

