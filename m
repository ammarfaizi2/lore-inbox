Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbRFAXFN>; Fri, 1 Jun 2001 19:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261960AbRFAXFD>; Fri, 1 Jun 2001 19:05:03 -0400
Received: from saarinen.org ([203.79.82.14]:31420 "EHLO vimfuego.saarinen.org")
	by vger.kernel.org with ESMTP id <S261956AbRFAXEv>;
	Fri, 1 Jun 2001 19:04:51 -0400
From: "Juha Saarinen" <juha@saarinen.org>
To: "'Andre Hedrick'" <andre@aslab.com>, <Magnus.Sandberg@bluelabs.se>
Cc: <linux-kernel@vger.kernel.org>, <linux-smp@vger.kernel.org>,
        <magnus.sandberg@test.bluelabs.se>
Subject: RE: Problem with kernel 2.2.19 Ultra-DMA and SMP, once more
Date: Sat, 2 Jun 2001 11:04:16 +1200
Message-ID: <04dd01c0eaef$2ed072b0$0a01a8c0@den2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
In-Reply-To: <Pine.LNX.4.10.10106011525220.10960-100000@master.linux-ide.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:: If this is a VIA SMP system there are APIC problems that you 
:: do not want
:: to even think about addressing.
:: 
:: MPS1.1 and passing "noapic" will fix most of there mess, but 
:: you have a
:: semi-crippled system, but it runs.

Andre,

I don't suppose these APIC problems are documented anywhere...?

-- Juha, who's wrestling with a VIA 694X dualie mobo here.

