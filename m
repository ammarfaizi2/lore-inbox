Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131666AbRDFPJX>; Fri, 6 Apr 2001 11:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDFPJO>; Fri, 6 Apr 2001 11:09:14 -0400
Received: from krynn.axis.se ([193.13.178.10]:56251 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S131666AbRDFPJB>;
	Fri, 6 Apr 2001 11:09:01 -0400
Message-ID: <1d7601c0beab$0cb2bfa0$0a070d0a@axis.se>
From: "Johan Adolfsson" <johan.adolfsson@axis.com>
To: "Bernhard Bender" <Bernhard.Bender@ELSA.de>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <41256A26.005733A6.00@elsa.de>
Subject: Re: ethernet phy link state info
Date: Fri, 6 Apr 2001 17:05:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have an answer but a related question:
Is there any "standard ioctl" to force an interface
to a certain link state, eg. auto, 10Mbs, 100Mbps,
half/full duplex etc.?

If not, can we create a standard ioctl mechanism for it?

/Johan

----- Original Message -----
From: Bernhard Bender <Bernhard.Bender@ELSA.de>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, April 06, 2001 16:54
Subject: ethernet phy link state info


>
>
> Hi all,
>
> where do I find information about the current link state of the ethernet
PHY
> (e.g. 100mbit/s full duplex) ?
> Something like /proc/sys/net/* ?
>
> Thanks
> Bernhard
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

