Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288764AbSADU6E>; Fri, 4 Jan 2002 15:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288763AbSADU5p>; Fri, 4 Jan 2002 15:57:45 -0500
Received: from ns.suse.de ([213.95.15.193]:260 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288762AbSADU5d>;
	Fri, 4 Jan 2002 15:57:33 -0500
Date: Fri, 4 Jan 2002 21:57:32 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020104153305.C20097@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201042149240.20620-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Eric S. Raymond wrote:

> Are there even 1500 distinct PC motherboard designs in *existence*? :-)
> Think, Dave.  The DMI standard dates from 1998.  For there to be 1500
> entries on the blacklist, someone would have to have been cranking out
> *500* PCI-capable, DMI-supporting motherboard designs a year each and
> every one of which lies about having ISA slots.

-  Laptops. Lots of vendors, multiple product lines.
-  prebuilt systems with custom boards from Dell/Compaq.
-  The obvious motherboard vendors (ABit, Asus, Tyan, Soyo etc etc)
-  Vendor reference boards from AMD, VIA, SiS, ALi etc etc.
-  The seemingly endless cheap no-name boards from Taiwan.
-  Mulitple versions of BIOSen for all the above.
   Some with good DMI/some bad/some bad for different reasons etc.

Still think that '150' systems sounds right ?
Dell alone have probably achieved that in their product line over
the last three years.

And whilst DMI is a dying standard, its still present in a lot of
new boxes, and will probably still continue to for some for a while.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

