Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbTAEWrt>; Sun, 5 Jan 2003 17:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTAEWrr>; Sun, 5 Jan 2003 17:47:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63107
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265373AbTAEWrk>; Sun, 5 Jan 2003 17:47:40 -0500
Subject: Re: Why is Nvidia given GPL'd code to use in non-free drivers?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hps@intermeta.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <avachu$gnf$1@forge.intermeta.de>
References: <20030102013736.GA2708@gnuppy.monkey.org>
	 <1041806677.15071.8.camel@irongate.swansea.linux.org.uk>
	 <avachu$gnf$1@forge.intermeta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041810027.15071.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 05 Jan 2003 23:40:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-05 at 22:45, Henning P. Schmiedehausen wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> >WLAN yes - openap is superb stuff
> 
> I didn't mention an open source access point. I already have a tried

I use openap for most of my card driving. Its much more resilient.

> >ACPI - very recently become a truely open project so will I hope now
> >improve
> 
> "very recently". :-)

Serious comment - Until very very recently Intel wouldn't take community
changes. Intels focus has also been on correctness, so changes to handle
things like broken MS AML 1.0 output haven't gone in - which burns some
toshiba users for example.

> >APM - reliable for years, bios code (the nonfree bit) often very buggy
> 
> The APM code on my Laptop still can't figure out how to display the
> battery level correctly all the time (it flips to "0%" for a few
> seconds every five to ten minutes), so I can't use the "shut down if

BIOS bug

> below 5%" feature of apmd or my lap top would start shutting down
> every five to ten minutes. Needless to tell that the Windows 2000 APM
> has no such problem. BIOS? Really? (BTW: This is an Acer 710TE, one of

yes - BIOS. Most likely btw your Windows setup is using the ACPI
interface.


