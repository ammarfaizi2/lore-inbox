Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261688AbREOXLJ>; Tue, 15 May 2001 19:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261691AbREOXK7>; Tue, 15 May 2001 19:10:59 -0400
Received: from mail.sai.co.za ([196.33.40.8]:24584 "EHLO mail.sai.co.za")
	by vger.kernel.org with ESMTP id <S261688AbREOXKm>;
	Tue, 15 May 2001 19:10:42 -0400
From: "David Wilson" <davew@sai.co.za>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: FW: I think I've found a serious bug in AMD Athlon page_alloc.c routines, where do I mail the developer(s) ?
Date: Wed, 16 May 2001 01:12:15 +0200
Message-ID: <NEBBJFIIGKGLPEBIJACLAEHEDMAA.davew@sai.co.za>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <E14znhi-0003HR-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Thanks for getting back to me.
I wonder if DFI has a bios or chipset patch available and whether that would
help ?
Maybe disabling the VIA chipset support in the kernel and running generic
drivers would help ?
Thanks.
Keep up the good work anyways !

Regards
David Wilson
Technical Support Centre
The S.A Internet
0860 100 869
http://www.sai.co.za



-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: 16 May 2001 12:54
To: David Wilson
Subject: Re: FW: I think I've found a serious bug in AMD Athlon
page_alloc.c routines, where do I mail the developer(s) ?


Known funny. Only shows up on via chipset boards. Right now we think but
have
not proven its a hardware flaw somwhere


