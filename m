Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290305AbSAXVOb>; Thu, 24 Jan 2002 16:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290304AbSAXVOV>; Thu, 24 Jan 2002 16:14:21 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:50445 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S290302AbSAXVOK>; Thu, 24 Jan 2002 16:14:10 -0500
Date: Thu, 24 Jan 2002 22:14:08 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <Pine.LNX.4.40.0201242155090.9957-100000@infcip10.uni-trier.de>
Message-ID: <Pine.LNX.4.44.0201242206010.1347-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Daniel Nofftz wrote:

> On Thu, 24 Jan 2002, Rasmus Bøg Hansen wrote:
> 
> > I tried your patch. I get the message above (I have a KT133A). With only
> > APM enabled, it makes no difference; witch ACPI, temp goes from 47C ->
> > 38C without stability problems nor preformance drops.
> >
> 
> ahhh ... good to hear a "working"-feedback from someone with an kt133a
> chipset :)
> 
> > However, after disabling APM and enabling ACPI, my system won't power
> > off anymore :-(
> 
> hmmm ... i noticed this to on my computer ... i have not searched until
> now, why this happens ... (to much to do) ... maybe i look later whether i
> can find something, or anyone else has a hint ...

Somewhere a long way down the "ACPI troubles (Was:[...]" thread someone 
told me, that the Asus A7V family is broken and implement the power-off 
funtion in a wrong manner. You have to update ACPI to make it work (but 
now it works like a charm). You should be able to find the links in the 
other thread.

Regards
Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
I would never kill somebody
- unless they pissed me off!
             -- Eric Cartman
----------------------------------[ moffe at amagerkollegiet dot dk ] --


