Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSEUQib>; Tue, 21 May 2002 12:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSEUQia>; Tue, 21 May 2002 12:38:30 -0400
Received: from server1.symplicity.com ([209.61.154.230]:41226 "HELO
	mail2.symplicity.com") by vger.kernel.org with SMTP
	id <S315200AbSEUQi2>; Tue, 21 May 2002 12:38:28 -0400
From: "Alok K. Dhir" <adhir@symplicity.com>
To: "'Halil Demirezen'" <halild@bilmuh.ege.edu.tr>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Support for HCF modem.?
Date: Tue, 21 May 2002 12:38:24 -0400
Message-ID: <002a01c200e5$ed7a20f0$6501a8c0@frodo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <Pine.LNX.4.44.0205211920220.1290-100000@bilmuh.ege.edu.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try:

	http://www.mbsi.ca/cnxtlindrv/

Caveat:  These only work on non-SMP kernels.  My SMP box freezes hard
when accessing the modem using this HCF driver.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Halil Demirezen
> Sent: Tuesday, May 21, 2002 12:22 PM
> To: linux-kernel@vger.kernel.org
> Subject: Support for HCF modem.?
> 
> 
> 
> Is there any driver for the HCF Conexant PCI modem in the 
> latest kernel?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

