Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281286AbRKLGzq>; Mon, 12 Nov 2001 01:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281290AbRKLGzg>; Mon, 12 Nov 2001 01:55:36 -0500
Received: from david.siemens.de ([192.35.17.14]:48092 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S281286AbRKLGz2>;
	Mon, 12 Nov 2001 01:55:28 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: linux-kernel@vger.kernel.org
Subject: STR with APM possible?
Date: Mon, 12 Nov 2001 09:55:21 +0300
Message-ID: <001101c16b46$ff352400$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3311
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have ASUS CUSL2 motherboard that supports STR (and it works perfectly
under windows). With the same BIOS settings doing apm --suspend almost
suspends - except that power supply fan continues to run, which
indicates, system is not in STR state.

Kernel is Mandrake cooker 2.4.13-4mdk (based on -ac6), but it was true
for all kernels I've tried starting from 2.2.19

ACPI is not included in mandrake kernels.

Is it supported? Anything I can do to debug/fix it?

TIA

-andrej
