Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131735AbQK3H3A>; Thu, 30 Nov 2000 02:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131610AbQK3H2v>; Thu, 30 Nov 2000 02:28:51 -0500
Received: from mail2.rdc3.on.home.com ([24.2.9.41]:51403 "EHLO
        mail2.rdc3.on.home.com") by vger.kernel.org with ESMTP
        id <S129851AbQK3H2g>; Thu, 30 Nov 2000 02:28:36 -0500
Date: Thu, 30 Nov 2000 01:57:54 -0500
X-Mailer: 21.1 (patch 12) "Channel Islands" XEmacs Lucid (via feedmail 9-beta-7 I);
        VM 6.82 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14885.64113.780609.704554@phoenix.somewhere.out.there>
From: "S.Salman Ahmed" <ssahmed@pathcom.com>
To: linux-kernel@vger.kernel.org
Subject: ATA100/UDMA100 Support on the ASUS-CUSL2 mobo
Reply-To: ssahmed@pathcom.com
X-No-Archive: Yes
X-Operating-System: Linux phoenix 2.2.17 i686
X-Organization: Salman Ahmed Software & Consulting
X-Disclaimer: I didn't do it, little green aliens wrote this email
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[I am not subscribed to the list, so please CC: me]

Hi,

How well is the ATA100/UDMA100 supported in the development kernels ? I
have a system with an ASUS CUSL2 mobo, which has built-in ATA100 IDE
channels, alongwith a Maxtor 20Gb ATA100 HD.

I looked at the kernel config for 2.4.0-test11, but in the "IDE, ATA and
ATAPI Block devices" section couldn't find chipset-specific support for
either the:

(1) Intel i815 chipset, which is what the ASUS-CUSL2 has

or the

(2) Intel I/O Controller Hub 2 (ICH2)

I'd like to get my system working using the built-in ATA100 controller
on the ASUS CUSL2, but what options do I need in 2.4.0-test11's kernel
config ?

Is there support for the Intel i815 chipset ?

I'd appreciate any info.

Thanks,

-- 
Salman Ahmed
ssahmed AT pathcom DOT com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
