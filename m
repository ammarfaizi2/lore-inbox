Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267529AbRGRTgo>; Wed, 18 Jul 2001 15:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267914AbRGRTgf>; Wed, 18 Jul 2001 15:36:35 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:45582 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S267529AbRGRTg2>;
	Wed, 18 Jul 2001 15:36:28 -0400
Subject: noapic strikes back
From: Florin Andrei <florin@sgi.com>
To: linux-xfs@oss.sgi.com, seawolf-list@redhat.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 18 Jul 2001 12:35:08 -0700
Message-Id: <995484908.1279.0.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a SGI 1200 (L440GX+ motherboard, dual PIII) and i'm trying to
install at least one version of Red Hat 7.1 on it.
The problem is, while booting up the installer, when it comes to loading
up the SCSI driver (AIC7xxx) the system is frozen.

I tried the following boot disks:
- stock Red Hat 7.1
- Doug Ledford's updates from people.redhat.com
- SGI XFS 1.0.1

I tried to boot the installer with and without "noapic" option.

I tried to enable and disable the APIC option in BIOS ("PCI IRQs to
IO-APIC Mapping").

I tried all the combinations of these. No luck. :-(

Please, is there anything to do about this problem? I *have* to install
something newer than RH7.0 on that system.

Guys, i will try whatever boot disks you will send to me. I'm willing to
be you guinea pig. :-) Just let's kill the APIC problem for good!

-- 
Florin Andrei

