Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290458AbSAXX2D>; Thu, 24 Jan 2002 18:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290460AbSAXX1y>; Thu, 24 Jan 2002 18:27:54 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:12466 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S290458AbSAXX1m>; Thu, 24 Jan 2002 18:27:42 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Fri, 25 Jan 2002 00:27:36 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, Vojtech Pavlik <vojtech@suse.cz>,
        Timothy Covell <timothy.covell@ashavan.org>,
        Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Martin Eriksson <nitrax@giron.wox.org>
In-Reply-To: <Pine.LNX.4.40.0201242201480.9957-100000@infcip10.uni-trier.de> 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020124232749Z290458-13996+11481@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 25. January 2002 00:18, Dieter Nützel wrote:
> On Thursday, 24. January 2002 21:55, Daniel Nofftz wrote:
> > On 24 Jan 2002, Disconnect wrote:
> > > 1.3G here.. how much faster does it need to be? (didn't test
> > > audio/video streams due to the unusability of my keyboard.. I can
> > > reboot and try it if it would be useful.)
> > >
> > > calibrating APIC timer ...
> > > ..... CPU clock speed is 1302.9962 MHz.
> > > ..... host bus clock speed is 200.4608 MHz.
> >
> > ok ... does not look like a speed problen :)
> > i have 1,4g and it works like a charm ....
> >
> > hmmm ... maybe acpi problems with the different motherboards ? buggy
> > implemention of the acpi functions in the bios ? or maybee a fsb problem
> > (have 133mhz fsb ... does someone with 133mhz fsb have problems to?)
> >
> > i have no real idea at the moment ...
>
> I found some additional info for you.
>
> Our famous German c't magazin have:
> http://www.heise.de/ct/01/18/036/default.shtml
>
> And you should have a look into this AMD doku (sadly _NO_ AMD 750/760
> infos): "AMD Athlon Processor Model 4 Revision Guide"
> www.amd.com/products/cpg/athlon/techdocs/pdf/23614.pdf
>
> AMD could be easily enlighten us, of course!

Addition:

Sound skip related (Creative SoundBlaster etc.)

Sorry in German, too:

http://www.heise.de/ct/foren/go.shtml?read=1&msg=11&g=200118036

So I think most trouble should be solvable when we get _MUCH_ better support 
by the hardware vendors!

Cheers,
	Dieter
