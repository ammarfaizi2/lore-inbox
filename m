Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267423AbRGLEja>; Thu, 12 Jul 2001 00:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267424AbRGLEjK>; Thu, 12 Jul 2001 00:39:10 -0400
Received: from rillanon.amristar.com.au ([202.181.77.23]:25619 "HELO
	amristar.com.au") by vger.kernel.org with SMTP id <S267423AbRGLEjJ>;
	Thu, 12 Jul 2001 00:39:09 -0400
From: "Daniel Harvey" <daniel@amristar.com.au>
To: "Chris Wedgwood" <cw@f00f.org>, <hahn@coffee.psychology.mcmaster.ca>,
        <linux-kernel@vger.kernel.org>
Subject: RE: FW: UPDATE: Linux SLOW on Compaq Armada 110 PIII Speedstep
Date: Thu, 12 Jul 2001 12:43:08 +0800
Message-ID: <NEBBJDBLILDEDGICHAGAKEAFCGAA.daniel@amristar.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20010712154739.A2877@weta.f00f.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At last getting something different!

linux 2.4.5 with:

no options - slow
mem=64M - fast
mem=128M - fast
mem=200M - fast
mem=224M - fast
mem=240M - fast
mem=248M - fast
mem=249M - fast/medium, fast 'make dep' but slow boot/reboot
mem=250M - slow
mem=252M - slow
mem=256M - hangs on boot, last line="Freeing unused kernel memory: 196k
freed"


> -----Original Message-----
> From: Chris Wedgwood [mailto:cw@f00f.org]
> Sent: Thursday, 12 July 2001 11:48 AM
> To: Daniel Harvey
> Subject: Re: FW: UPDATE: Linux SLOW on Compaq Armada 110 PIII Speedstep
>
>
> On Thu, Jul 12, 2001 at 11:48:31AM +0800, Daniel Harvey wrote:
>
>     That's the weird thing - 2.4.5 is just as slow! Even though,
> as you say, it
>     has the patch etc incorporated ...
>
> boot 2.4.5 with the command line optino "mem=64M" and see how slow it is
>
>
>
>   --cw
>

