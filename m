Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131151AbRCMWdl>; Tue, 13 Mar 2001 17:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131207AbRCMWdD>; Tue, 13 Mar 2001 17:33:03 -0500
Received: from zeus.kernel.org ([209.10.41.242]:39395 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131230AbRCMWb7>;
	Tue, 13 Mar 2001 17:31:59 -0500
From: "Juha Saarinen" <juha@saarinen.org>
To: "Greg KH" <greg@wirex.com>, <linux-kernel@vger.kernel.org>
Subject: RE: APIC  usb MPS 1.4 and the 2.4.2 kernel
Date: Wed, 14 Mar 2001 08:25:37 +1300
Message-ID: <LNBBIBDBFFCDPLBLLLHFEEDEJGAA.juha@saarinen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010313092837.A805@wirex.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

:: It seems that the APIC on this motherboard does not have most of the
:: pins connected, so that even if we could get the USB interrupt to work
:: properly (which we couldn't) there would be no benefit to run in APIC
:: mode.  I was going to run some crude benchmarks on the box with and
:: without APIC mode just to get an sense if we are missing anything
:: running in noapic mode, but I haven't gotten around to it yet.

So for Tyan Tigers, is it better to compile the kernel without APIC? About
to install Linux on a dual 500 P3 here.

:: But, Linux does seem to run just fine with USB and SMP in the noapic
:: mode, which is a lot better than Win2000 can say, as it doesn't even
:: support the VIA USB chipset on this board at all :)

There's a Win2K patch for VIA chip sets now... I've got USB working under
Win2K here.

-- Juha

