Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267312AbTAPU6k>; Thu, 16 Jan 2003 15:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267313AbTAPU6j>; Thu, 16 Jan 2003 15:58:39 -0500
Received: from mk-smarthost-4.mail.uk.tiscali.com ([212.74.114.40]:14097 "EHLO
	mk-smarthost-4.mail.uk.tiscali.com") by vger.kernel.org with ESMTP
	id <S267312AbTAPU6i>; Thu, 16 Jan 2003 15:58:38 -0500
Message-ID: <001e01c2bda3$48877130$a9592850@Lappy>
From: "Parag Warudkar" <paragw@tiscali.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.58 doesn't boot on VAIO 705
Date: Thu, 16 Jan 2003 21:07:30 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, 2.5.58 with ACPI on VAIO doesnt let the kernel boot. The =
screen goes blank, just after Uncompressing Linux message. I have RAGE =
mobility M1 video chip if thats relevant.=20
Same problem occurs with acpi=3Doff kernel option. But if I remove =
vga=3D788 from boot command line, i can actually see the boot messages =
for very short time. Sadly same thing happens after that - Blank Screen.

Framebuffer support + Mach64 related things are enabled.

Parag



