Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbRFNJ7v>; Thu, 14 Jun 2001 05:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbRFNJ7l>; Thu, 14 Jun 2001 05:59:41 -0400
Received: from proxy.ATComputing.nl ([195.108.229.1]:51499 "EHLO
	atcmpg.ATComputing.nl") by vger.kernel.org with ESMTP
	id <S261840AbRFNJ7f>; Thu, 14 Jun 2001 05:59:35 -0400
From: Daniel Tuijnman <daniel@ATComputing.nl>
Message-Id: <200106140958.LAA06999@atcmpg.ATComputing.nl>
Subject: SMP kernel 2.4.5 reboots spontaneously
To: linux-kernel@vger.kernel.org
Date: Thu, 14 Jun 2001 11:58:29 +0200 (MEST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My machine has an
- Intel D440LX motherboard (440LX chipset, onboard
  Adaptec AIC7880U SCSI, onboard EEPRO-100 NIC, onboard Cirrus VGA),
- 2 Pentium-II, 266 MHz CPUs
- second EEPRO-100 NIC
- SCSI HD and CDROM

Using the 2.4.2-smp kernel from RedHat 7.1 gives spontaneous reboots,
the 2.4.5 kernel too, when configured for SMP.
No crash dump available - applying the lkcd patch didn't help either.
The machine runs stable with a uni-processor kernel (2.4.2), though.

Does anyone have any idea what's going wrong here?
Reactions please also cc: to my email address.

Greetings,
Daniel Tuijnman

