Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132039AbRDJVFt>; Tue, 10 Apr 2001 17:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132127AbRDJVFk>; Tue, 10 Apr 2001 17:05:40 -0400
Received: from [204.163.170.2] ([204.163.170.2]:41707 "EHLO umail.unify.com")
	by vger.kernel.org with ESMTP id <S132039AbRDJVFf>;
	Tue, 10 Apr 2001 17:05:35 -0400
Message-ID: <419E5D46960FD211A2D5006008CAC79902E5C1A6@pcmailsrv1.sac.unify.com>
From: "Manuel A. McLure" <mmt@unify.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
        Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Still IRQ routing problems with VIA
Date: Tue, 10 Apr 2001 14:05:18 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C0C201.F2A465F0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C0C201.F2A465F0
Content-Type: text/plain;
	charset="iso-8859-1"

Jeff Garzik said...
> Changing '#undef DEBUG' to '#define DEBUG 1' in
> arch/i386/kernel/pci-i386.h is also very helpful.  Can you guys do so,
> and post the 'dmesg -s 16384' results to lkml?  This includes the same
> information as dump_pirq, as well as some additional information.

Here's my dmesg output - I tried with both PNP: Yes and PNP: No and the
dmesg outputs were exactly the same modulo a Hz or two in the processor
speed detection.

I do have an IRQ for my VGA since the instructions for my card (a Voodoo 5
5500) specifically say an IRQ is needed.

--
Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
Space Ghost: "Hey, what happened to the-?" Moltar: "It's out." SG: "What
about-?" M: "It's fixed." SG: "Eh, good. Good."


------_=_NextPart_000_01C0C201.F2A465F0
Content-Type: application/octet-stream;
	name="dmesg_pnp_yes.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dmesg_pnp_yes.txt.gz"

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

------_=_NextPart_000_01C0C201.F2A465F0--
