Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268748AbTGJAWr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 20:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbTGJAWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 20:22:47 -0400
Received: from rtichy.netro.cz ([213.235.180.210]:62459 "HELO 192.168.1.21")
	by vger.kernel.org with SMTP id S268748AbTGJAWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 20:22:38 -0400
Message-ID: <03e601c3467b$659d1160$401a71c3@izidor>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Matthias Schniedermeyer" <ms@citd.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <mru@users.sourceforge.net>
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com> <027901c3461e$e023c670$401a71c3@izidor> <yw1xadbnx017.fsf@users.sourceforge.net> <02ff01c34642$5512d7f0$401a71c3@izidor> <20030709175827.GA412@citd.de> <03ab01c34677$225d53a0$401a71c3@izidor> <1057796402.7386.8.camel@dhcp22.swansea.linux.org.uk>
Subject: Re: Promise SATA 150 TX2 plus
Date: Thu, 10 Jul 2003 02:37:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My board is PCI-X for all 6 slots or I can use
PCI 64/66 for all slots. I am looking for cards that
are not slow on this. I have got a working system
with Promise PATA controllers that can read
in software RAID 250 MB/s in sustained read
and more than 150 MB/s random read. I am looking
for same speeds with SATA drives and controllers.
Thanx for the answer
    Milan Roubal

----- Original Message ----- 
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
Cc: "Matthias Schniedermeyer" <ms@citd.de>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>; <mru@users.sourceforge.net>
Sent: Thursday, July 10, 2003 2:20 AM
Subject: Re: Promise SATA 150 TX2 plus


> On Iau, 2003-07-10 at 01:06, Milan Roubal wrote:
> > Wow, how is the performance of this cards? HPT PATA controllers
> > was always bad in performance and if it has got SATA to PATA converter,
> > I can't imagine how fast/slow it could be.
>
> If you are doing software raid its pretty irrelevant. With current
> drives the cost of the multiple PCI transfers for each copy of the block
> is the limiting factor on anything but PCI64/66Mhz really.
>

