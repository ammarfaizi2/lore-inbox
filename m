Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUIOHhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUIOHhb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 03:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUIOHhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 03:37:31 -0400
Received: from hippo.ethikrat.org ([194.95.188.1]:34757 "EHLO hippo.bbaw.de")
	by vger.kernel.org with ESMTP id S262418AbUIOHh3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 03:37:29 -0400
Date: Wed, 15 Sep 2004 09:36:35 +0200
From: Lars =?ISO-8859-15?Q?T=E4uber?= <taeuber@bbaw.de>
To: linux-kernel@vger.kernel.org
Subject: cdrom recognition on kernel 2.6.8.1
Message-Id: <20040915093635.1a8f08ff.taeuber@bbaw.de>
Reply-To: Lars =?ISO-8859-15?Q?T=E4uber?= 
	  <taeuber@informatik.hu-berlin.de>
Organization: Berlin-Brandenburgische Akademie der Wissenschaften
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-8; AVE: 6.27.0.10; VDF: 6.27.0.59; host: bbaw.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo everybody,

I'm not subscribed to this list! But I read the archive from time to time.

In my linux box is a teac IDE CD-Rom drive. This is only recognised when no audio cd is in the drive while booting.
Is this a drive failure, or a kernel failure?

I didn't find any other on the net with the same problem. So hopefully someone of you can explain?

............
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
NFORCE3-150: chipset revision 165
NFORCE3-150: not 100% native mode: will probe irqs later
NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
libata version 1.02 loaded.
sata_sil version 0.54
ACPI: PCI interrupt 0000:01:07.0[A] -> GSI 11 (level, low) -> IRQ 11
............



best regards
Lars Täuber
