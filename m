Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUCIIYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 03:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUCIIYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 03:24:12 -0500
Received: from mail.ywesee.com ([62.12.131.35]:37570 "HELO debian.ywesee.com")
	by vger.kernel.org with SMTP id S261717AbUCIIYI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 03:24:08 -0500
Date: Tue, 9 Mar 2004 09:24:06 +0100
From: "Zeno R.R. Davatz" <zdavatz@ywesee.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Benh Kernel 2.4.25 and 2.6.3
Message-Id: <20040309092406.6513fd7c@zrr.local>
Organization: ywesee - intellectual capital connected
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I build in a new 80 GB HDD in my G3 Pismo. Then I build the system from Gentoo-LiveCD and installed the kernel from source. Problems:

2.4.25-benh
***********
I rsync'd with rsync.penguinppc.org::linux-2.4-benh and build the kernel.

When I boot my G3 Pismo I get:
OOps: kernel access of bad area, sig: 11
NIP: C0012C6 XER: 00000000 LR: C0307120  SP: C02B0CE0 REGS: c02b0c30 TRAP: 0300 Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 40000000
TASK= c02aed30[0] etc

this repeats twice and then reboots the maschine. 

2.6.3-benh (gentoo: ppc-development-sources)
**********
This one boots fine till /proc .....   [ok]

than the maschine just hangs. I got udev installed.

Thanks for your Feedback.
-- 
Mit freundlichen Grüssen / best regards

Zeno Davatz
Verkauf & Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.oddb.org
