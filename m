Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275278AbRJ2NnC>; Mon, 29 Oct 2001 08:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275178AbRJ2Nmw>; Mon, 29 Oct 2001 08:42:52 -0500
Received: from AGrenoble-101-1-3-57.abo.wanadoo.fr ([193.253.251.57]:55711
	"EHLO lyon.ram.loc") by vger.kernel.org with ESMTP
	id <S275110AbRJ2Nmo>; Mon, 29 Oct 2001 08:42:44 -0500
To: linux-kernel@vger.kernel.org
From: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Subject: Re: 8139too on ABIT BP6 causes "eth0: transmit timed out"
Date: 29 Oct 2001 13:43:12 GMT
Organization: Home, Grenoble, France
Message-ID: <9rjmdg$i2$1@lyon.ram.loc>
In-Reply-To: <16095.1004308212@nice.ram.loc> <039901c1600b$b33fe3a0$0201a8c0@HOMER>
X-Newsreader: trn 4.0-test74 (May 26, 2000)
In-Reply-To: <039901c1600b$b33fe3a0$0201a8c0@HOMER>
X-Mailer: newsgate 1.0 at lyon.ram.loc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Eriksson <nitrax@giron.wox.org> from ml.linux.kernel:
:What Bios are you running? You should be running the modified RU1.25 Bios,
:and have enabled MPS 1.4. Also disable "Spread Spectrum" and do *not*
:overclock.

I have the RU BIOS, I enabled MPS 1.4.
What is "Spread Spectrum?".
I don't overclock.  I never do.

I remember seeing messages about network lockups on the ABIT BP6, and
there was a patch submitted to the list.  It had to do with a Sysreq patch
that would "do something to the APIC" and re-enable network interrupts.

However, I don't remember who this was, and where the patch is.

Is the older Becker driver for the RTL8139 more robust?  I know it's no longer
maintained, but if I want to try it, how do I proceed?  I don't remember
seeing it offered in the configuration menu.

Raphael
