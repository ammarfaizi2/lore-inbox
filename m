Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292765AbSBUUh1>; Thu, 21 Feb 2002 15:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292768AbSBUUhS>; Thu, 21 Feb 2002 15:37:18 -0500
Received: from barn.holstein.com ([198.134.143.193]:45328 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S292767AbSBUUg6>;
	Thu, 21 Feb 2002 15:36:58 -0500
Date: Thu, 21 Feb 2002 15:02:53 -0500
Message-Id: <200202212002.g1LK2rJ13868@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: nyh@math.technion.ac.il
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020221095513.GA7782@leeor.math.technion.ac.il>
	(nyh@math.technion.ac.il)
Subject: Re: Lucent WinModem
Reply-To: troy@holstein.com
In-Reply-To: <3C73DC99.4030405@quatro.com.br> <E16daoj-0004D4-00@the-village.bc.nu> <20020221095513.GA7782@leeor.math.technion.ac.il>
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 02/21/2002 03:02:55 PM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 02/21/2002 03:02:56 PM,
	Serialize complete at 02/21/2002 03:02:56 PM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you unpack ltmodem, then source.tar.gz you will find an object
module that you don't have to source to.  Therefor the lucent winmodem
code can't be open source.

>  X-RocketRCL: 1409;1;3767438174
>  X-Apparently-To: todd_m_roy@yahoo.com via web13604.mail.yahoo.com; 21 Feb 2002 06:04:33 -0800 (PST)
>  X-Track: 67: 40
>  Date:	Thu, 21 Feb 2002 11:55:13 +0200
>  From:	"Nadav Har'El" <nyh@math.technion.ac.il>
>  Cc:	Elieser =?iso-8859-8-i?Q?Le=E3o?= <elieser@quatro.com.br>,
>  	linux-kernel <linux-kernel@vger.kernel.org>
>  Content-Disposition: inline
>  Hebrew-Date: 9 Adar 5762
>  Sender:	linux-kernel-owner@vger.kernel.org
>  X-Mailing-List:	linux-kernel@vger.kernel.org
>  
>  On Wed, Feb 20, 2002, Alan Cox wrote about "Re: Lucent WinModem":
>  > > How can I use my LT Winmodem on Slackware???
>  > > I have a driver but doesn't work!!!! I don't know why...
>  > 
>  > Ask the binary only driver provider.
>  > 
>  > This list is about free software, and nobody else but the driver vendor
>  > can really help you
>  
>  Actually, I think that Lucent's driver has been open source (I didn't check
>  how "free" their license is) for at least a year now. No more of these ugly
>  binary drivers that you had to apply binary patches (aggh!) to on every
>  kernel version.
>  
>  A quick google search turned out http://www.heby.de/ltmodem as a place you
>  can get the sources.
>  
>  I'm using such a driver on my laptop (Redhat 7.2), I compiled it myself (I
>  don't know why Redhat doesn't include a module for this modem - maybe it
>  isn't "free enough") and the modem is working nicely.
>  
>  -- 
>  Nadav Har'El                        |       Thursday, Feb 21 2002, 9 Adar 5762
>  nyh@math.technion.ac.il             |-----------------------------------------
>  Phone: +972-53-245868, ICQ 13349191 |A smart man always covers his ass. A wise
>  http://nadav.harel.org.il           |man just keeps his pants on.
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/
>  
