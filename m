Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283697AbRLMIIG>; Thu, 13 Dec 2001 03:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283708AbRLMIH7>; Thu, 13 Dec 2001 03:07:59 -0500
Received: from law2-oe57.hotmail.com ([216.32.180.150]:26884 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S283697AbRLMIHt>;
	Thu, 13 Dec 2001 03:07:49 -0500
X-Originating-IP: [213.82.66.51]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200112130644.fBD6ibI83062@saturn.cs.uml.edu>
Subject: Re: Kernel Panic: too few segs for DMA mapping increase AHC_NSEG
Date: Thu, 13 Dec 2001 09:07:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <LAW2-OE57pqZBdypJ5600000807@hotmail.com>
X-OriginalArrivalTime: 13 Dec 2001 08:07:43.0328 (UTC) FILETIME=[3DD8BE00:01C183AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reporting only a kernel bug.
With Hi mem support enabled, I get a kernel panic trying to copy one
file from a vfat filesystem to ext2.

----- Original Message -----
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: "Marco Berizzi" <pupilla@hotmail.com>
Sent: Thursday, December 13, 2001 7:44 AM
Subject: Re: Kernel Panic: too few segs for DMA mapping increase
AHC_NSEG


> > I have upgraded my PC from 768MB RAM to 1GB.
>
> Not worth it.
>
> You suffer the overhead of the 4 GB option for only 33% more
> memory. If you'll go past 768 MB, go to 2 GB or 3 GB.
>
