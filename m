Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289718AbSAWHm2>; Wed, 23 Jan 2002 02:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289723AbSAWHmS>; Wed, 23 Jan 2002 02:42:18 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:65453 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S289718AbSAWHmC> convert rfc822-to-8bit; Wed, 23 Jan 2002 02:42:02 -0500
Date: Wed, 23 Jan 2002 08:42:00 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Dave Jones <davej@suse.de>, Andreas Jaeger <aj@suse.de>,
        Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <200201222243.XAA14711@rzmail.uni-trier.de>
Message-ID: <Pine.LNX.4.40.0201230830390.29728-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Dieter [iso-8859-15] Nützel wrote:

> I know that and my intention was that we _NEED_ documentation to support it
> on _ALL_ chipsets out there.

yes ... i agree ... i send a mail to sis to get the information i need to
implemend this discconnect function for the sis735 but they did not
respond at all to my mail. this is not verry nice ... we want to make
drivers and bug fixes so that their products will work correctly under
linux, and they don't care at all sometimes ...

>
> AMD should notice how many people using there CPUs and I think they do know
> it.
>
> So let's make a call.

yes ... it would be verry nice when amd and the cipset corp. would be a
little bit more supportive.

> I did that, too.
> Andreas Jaeger (SuSE) told me that maybe he could help.
> He got the USB patch information for the AMD Irongate after a few days out of
> them...

ah ... god ... maybe he could send me the imformation to activate the
power saving on the amd cipsets :)

>
> > i decided to wrote a kernelpatch, which supports the kt266/kt266a chipset
> > too.
>
> Good work.

thanks :)
(ok ... the code vfor the kt/k133 chipset allready exists .. .i only
changed it to support the kt266/266a to, which uses other registers for
this)

>
> > (one of my reasosns for this was, that the developer of vcool will not
> > develop the linux version further) .
>
> Sadly to hear.

he told me, that he is not so familiar with linux and at the moment he
have no linux at all at home :( ... but he gave me some hints where to get
the informations i needed ...

> I hope we get some info, now.

i hope it to ...

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

