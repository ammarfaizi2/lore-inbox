Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291257AbSBUJzr>; Thu, 21 Feb 2002 04:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291400AbSBUJzi>; Thu, 21 Feb 2002 04:55:38 -0500
Received: from leeor.math.technion.ac.il ([132.68.115.2]:58341 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S291257AbSBUJza>; Thu, 21 Feb 2002 04:55:30 -0500
Date: Thu, 21 Feb 2002 11:55:13 +0200
From: "Nadav Har'El" <nyh@math.technion.ac.il>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Elieser =?iso-8859-8-i?Q?Le=E3o?= <elieser@quatro.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lucent WinModem
Message-ID: <20020221095513.GA7782@leeor.math.technion.ac.il>
In-Reply-To: <3C73DC99.4030405@quatro.com.br> <E16daoj-0004D4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16daoj-0004D4-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Hebrew-Date: 9 Adar 5762
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002, Alan Cox wrote about "Re: Lucent WinModem":
> > How can I use my LT Winmodem on Slackware???
> > I have a driver but doesn't work!!!! I don't know why...
> 
> Ask the binary only driver provider.
> 
> This list is about free software, and nobody else but the driver vendor
> can really help you

Actually, I think that Lucent's driver has been open source (I didn't check
how "free" their license is) for at least a year now. No more of these ugly
binary drivers that you had to apply binary patches (aggh!) to on every
kernel version.

A quick google search turned out http://www.heby.de/ltmodem as a place you
can get the sources.

I'm using such a driver on my laptop (Redhat 7.2), I compiled it myself (I
don't know why Redhat doesn't include a module for this modem - maybe it
isn't "free enough") and the modem is working nicely.

-- 
Nadav Har'El                        |       Thursday, Feb 21 2002, 9 Adar 5762
nyh@math.technion.ac.il             |-----------------------------------------
Phone: +972-53-245868, ICQ 13349191 |A smart man always covers his ass. A wise
http://nadav.harel.org.il           |man just keeps his pants on.
