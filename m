Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261380AbREQJTN>; Thu, 17 May 2001 05:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261381AbREQJTE>; Thu, 17 May 2001 05:19:04 -0400
Received: from mail.sai.co.za ([196.33.40.8]:18693 "EHLO mail.sai.co.za")
	by vger.kernel.org with ESMTP id <S261380AbREQJSt>;
	Thu, 17 May 2001 05:18:49 -0400
From: "David Wilson" <davew@sai.co.za>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: FW: I think I've found a serious bug in AMD Athlon page_alloc.c routines, where do I mail the developer(s) ?
Date: Thu, 17 May 2001 11:20:08 +0200
Message-ID: <NEBBJFIIGKGLPEBIJACLIEJNDMAA.davew@sai.co.za>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <E15080y-0004AI-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Mmm no luck so far ;(
I've checked that the bios is the latest available and there doesn't seem to
be any type of chipset software patch or upgrade.
What I have done is tried compiling the kernel for AMD K6/2, K6/3, .....this
seems to work nicely and it's stable.
It seems that I'll have to give the "Athlon" support a miss for now. ;(

How does one go about obtaining a Transmeta chip ? I'm really keen to try it
;-) ...anyways probably just a fantasy for now.

Thanks for the help anyways and keep up the fantastic work !

Regards
David Wilson
Technical Support Centre
The S.A Internet
0860 100 869
http://www.sai.co.za



-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: 16 May 2001 10:35
To: David Wilson
Cc: Alan Cox; linux-kernel@vger.kernel.org
Subject: Re: FW: I think I've found a serious bug in AMD Athlon
page_alloc.c routines, where do I mail the developer(s) ?


> I wonder if DFI has a bios or chipset patch available and whether that
would
> help ?
> Maybe disabling the VIA chipset support in the kernel and running generic
> drivers would help ?

Play with ideas see what you find out. You might strike lucky. So far nobody
else has

