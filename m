Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271899AbTGYD3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 23:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271900AbTGYD3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 23:29:32 -0400
Received: from rtichy.netro.cz ([213.235.180.210]:1790 "HELO 192.168.1.21")
	by vger.kernel.org with SMTP id S271899AbTGYD3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 23:29:31 -0400
Message-ID: <023901c3525f$0fcd4f30$3501a8c0@izidor>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: <andersen@codepoet.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
References: <20030722184532.GA2321@codepoet.org>
Subject: Re: Promise SATA driver GPL'd
Date: Fri, 25 Jul 2003 05:44:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erik,
great job!! I can report succes, my card
Promise SATA 150 TX2plus is now
working, tested with Seagate ST312002
and Western Digital WD1200JD
Tested with SuSE 8.1 SMP kernel
Thanx for good work
    Milan Roubal

----- Original Message ----- 
From: "Erik Andersen" <andersen@codepoet.org>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Sent: Tuesday, July 22, 2003 8:45 PM
Subject: Promise SATA driver GPL'd


> Some folk I've done some consulting work for bought a zillion
> Promise SATA cards.  They were able to convince Promise to
> release their SATA driver, which was formerly available only as
> a binary only kernel module, under the terms of the GPL.
>
> So <drum-roll, trumpets> here it is: the Promise SATA driver for
> the PDC20318, PDC20375, PDC20378, and PDC20618.  This driver is
> released as-is.  It is useful for the
>
> Promise SATA150 TX4
> Promise SATA150 TX2plus
> Promise SATA 378
> Promise Ultra 618
>
> cards.  As a temporary download location, the GPL'd driver can be
> obtained from http://www.busybox.net/pdc-ultra-1.00.0.10.tgz
>
> Have fun!  And many thanks to Promise for contributing the driver
> for their cards!
>
>  -Erik
>
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

