Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbRL3NSM>; Sun, 30 Dec 2001 08:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287403AbRL3NSB>; Sun, 30 Dec 2001 08:18:01 -0500
Received: from p15.dynadsl.ifb.co.uk ([194.105.168.15]:38540 "HELO smeg")
	by vger.kernel.org with SMTP id <S287405AbRL3NRl>;
	Sun, 30 Dec 2001 08:17:41 -0500
From: "Lee Packham" <linux@mswinxp.net>
To: <axboe@suse.de>
Cc: <davej@suse.de>, <linux-kernel@vger.kernel.org>
Subject: FW: [BUG] 2.5.1-dj8 - IDE CD-ROM ... Also in main tree
Date: Sun, 30 Dec 2001 13:17:04 -0000
Message-ID: <000501c19134$463fd580$010ba8c0@lee>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.2-pre3 has the same problem.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Dave Jones
> Sent: 30 December 2001 12:37
> To: Lee Packham
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [BUG] 2.5.1-dj8 - IDE CD-ROM
> 
> On Sun, 30 Dec 2001, Lee Packham wrote:
> 
> > On a VIA KT266a chipset motherboard with a standard IDE CD-ROM
device I
> > get input/output errors on all iso9660 + joilet CD's. I don't have
any
> > basic CDs to try.
> 
> Looks like I dropped part of the isofs changes. I'll take a look
> at this for the next patch.
> 
> Thanks
> 
> Dave.
> 
> --
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

