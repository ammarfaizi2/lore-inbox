Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287699AbSAXMl0>; Thu, 24 Jan 2002 07:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287705AbSAXMlQ>; Thu, 24 Jan 2002 07:41:16 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:48137 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S287699AbSAXMlB>; Thu, 24 Jan 2002 07:41:01 -0500
Date: Thu, 24 Jan 2002 13:40:59 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <Pine.LNX.4.40.0201241047350.6560-100000@infcip10.uni-trier.de>
Message-ID: <Pine.LNX.4.44.0201241337450.1663-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Daniel Nofftz wrote:

> On Wed, 23 Jan 2002, Hans-Peter Jansen wrote:
> 
> > You see, I'm fiddleing with power saving quite some time.
> 
> oh ,.. by the way : does dmesg show somthing like "dissconect in via
> northbridge enabled: kt133 chipset found " or something similar ?
> (only if you have my patch ativated)

I tried your patch. I get the message above (I have a KT133A). With only 
APM enabled, it makes no difference; witch ACPI, temp goes from 47C -> 
38C without stability problems nor preformance drops.

However, after disabling APM and enabling ACPI, my system won't power 
off anymore :-(

Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
God put me on earth to accomplish a certain number of things.
Right now I am so far behind I will never die.
                            -Bill Waterson, Calvin and Hobbes
----------------------------------[ moffe at amagerkollegiet dot dk ] --


