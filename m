Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbSKKWLA>; Mon, 11 Nov 2002 17:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSKKWLA>; Mon, 11 Nov 2002 17:11:00 -0500
Received: from gzp11.gzp.hu ([212.40.96.53]:25105 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id <S261401AbSKKWK7>;
	Mon, 11 Nov 2002 17:10:59 -0500
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: Re: Promise Ultra100 TX2 driver problems
References: <20021111192648.GA31966@galacticasoftware.com> <20021111192648.GA31966@galacticasoftware.com> <1037054288.2887.49.camel@irongate.swansea.linux.org.uk>
Organization: Who, me?
User-Agent: tin/1.5.15-20021023 ("Soil") (UNIX) (Linux/2.4.20-rc1 (i686))
Message-ID: <65fd.3dd02c87.bc6cb@gzp1.gzp.hu>
Date: Mon, 11 Nov 2002 22:17:43 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk>:

|> There seems to be a major problem with the promise drivers.
|> It is detected and seems to work, but there is a very 
|> large number of interrupts being generated:
| 
| Im dubious those interrupts are coming from the TX2 - what happens if
| you boot with the "noapic" option ?

Same here and even no APIC support in the kernel.

