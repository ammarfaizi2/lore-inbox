Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315961AbSENSMC>; Tue, 14 May 2002 14:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315958AbSENSMB>; Tue, 14 May 2002 14:12:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:3168 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315961AbSENSMA>;
	Tue, 14 May 2002 14:12:00 -0400
From: "Kosta Porotchkin" <kporotchkin@gmx.net>
To: "Linux Kernel mailing List \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: Patch for E7500 PCI interrupt problem?
Date: Tue, 14 May 2002 13:05:48 -0600
Message-ID: <001701c1fb7b$5a7bb350$a396a8c0@compaq12xl510a>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am using kernel 2.4.17 on SuperMicro P4DP6 motherboard (Dual Xeon, 1GB
RAM).
There is a problem in this kernel, that IRQs coming from several PCI slots
are not handled by kernel.
I found that kernel 2.4.18 solved this problem, but has a lot of another
additions which I do not need (the patch file is about 4 Mb).
I cannot change the kernel version on my system, however can apply some
patches which solve a particular problems.
Can someone help me to find the developer solved the PCI IRQ problem in
2.4.18 or point to the kernel patch (not the full 2.4.17 -> 2.4.18 one)?

Thanks

Kosta Porotchkin

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.361 / Virus Database: 199 - Release Date: 5/7/2002


