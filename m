Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132144AbRDCBnL>; Mon, 2 Apr 2001 21:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132337AbRDCBnC>; Mon, 2 Apr 2001 21:43:02 -0400
Received: from [202.104.32.248] ([202.104.32.248]:49763 "HELO 21cn.com")
	by vger.kernel.org with SMTP id <S132144AbRDCBmu> convert rfc822-to-8bit;
	Mon, 2 Apr 2001 21:42:50 -0400
Message-ID: <006b01c0bbdf$38dbbd80$3300a8c0@dvn>
From: "Jean-Michel Lee" <thaz@21cn.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <F1629832DE36D411858F00C04F24847A11DF3B@SALVADOR>
Subject: Re: Question: is linux support Intel's i840 chipset?
Date: Tue, 3 Apr 2001 09:41:34 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="WINDOWS-1255"
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.3825.400
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.3825.400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot.

A fool question: since IDE controller is a PCI device, and the PCI is 32bit/33MHz - 132MB/s or so. How does two ATA-100 device work, it will use 2 x 100MB/s bandwidth.

I know most IDE controller is in the Sound Bridge, but I can buy an IDE expand card, which support ATA-100 too.


----- Original Message ----- 
From: "Ofer Fryman" <ofer@shunra.co.il>
To: "'Jean-Michel Lee'" <thaz@21cn.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, March 29, 2001 6:20 PM
Subject: RE: Question: is linux support Intel's i840 chipset?


> I believe that Linux 2.2.x and 2.4.x do support it well, however I tried
> using it with Linux 2.0.x and it caused me many problems with PCI drivers. I
> also tried server-works chipset, which also works with 64-bit PCI bus, it
> worked well under Linux 2.0.x no problems what so ever.
> Any way since the 840 chipset is known to be buggy, I suggest you use
> server-works.
> 
> Ofer
> 
> -----Original Message-----
> From: Jean-Michel Lee [mailto:thaz@21cn.com]
> Sent: Thursday, March 29, 2001 11:47 AM
> To: linux-kernel@vger.kernel.org
> Subject: Question: is linux support Intel's i840 chipset?
> 
> 
> Hi,
> 
> I just want to search a mainboard with 64-bit PCI bus and ATA-100 support. I
> just find that Intel i840 do. So, I wonder whether linux support Intel's
> i840.
> 
> Thanks.
> 
> Michel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

