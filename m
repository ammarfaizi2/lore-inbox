Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbULUPUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbULUPUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 10:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbULUPUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 10:20:54 -0500
Received: from host245-95.pool217223.interbusiness.it ([217.223.95.245]:57021
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261771AbULUPUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 10:20:47 -0500
Subject: ATARAID and KERNEL-2.6.9
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 21 Dec 2004 16:18:53 +0100
Message-Id: <1103642333.5591.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sirs,

        I have a little problem or maybe big one. I try to 
put to work the kernel-2.6.9 on my machine. I have a slackware
current install and the following hardware.

AMD Athlon 
512MB RAM
HPT 370 RAID controller 
and 2 HDD in RAID1

So when I start the kernel-ataraid-2.4.27 everything works OK.
When I start the installed kernel-2.6.9 I get the following error
message:

VFS: Cannot openroot device "7203" or unknown-block(114,3)
Please append a correct "root=" option 
Kernel panic: VFS: Unable to mount root fs on unknown-block(114,3)

On my lilo.conf is root=/dev/ataraid/d0p3 
as this is the / partition. 

I tried to put the root=/dev/hde at the lilo prompt but no 
success. 
I tried many many forums but nobody was able to answer me. So 
my last sollution is you and I will very very apreciate it if 
you can give me some hints how to do it. I append you also a
dmesg from the 2.4.27 kernel. 

Many thanks in advance for your help !!!

Best Regards
Sasa Ostrouska





