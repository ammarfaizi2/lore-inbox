Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbRFBFCu>; Sat, 2 Jun 2001 01:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbRFBFCk>; Sat, 2 Jun 2001 01:02:40 -0400
Received: from bellini.kjist.ac.kr ([203.237.41.6]:48515 "EHLO
	bellini.kjist.ac.kr") by vger.kernel.org with ESMTP
	id <S261594AbRFBFCd>; Sat, 2 Jun 2001 01:02:33 -0400
Date: Sat, 2 Jun 2001 14:02:28 +0900
Message-Id: <200106020502.f5252SO15014@bellini.kjist.ac.kr>
From: "G. Hugh Song" <ghsong@kjist.ac.kr>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac6 and 2.4.4-ac11 boot fails with APIC timer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The message on the screen 


calibrating APIC timer .....
.... CPU clock speed is 1395.7390MHz
... host bus clock speed is 0.0000 MHz
cpu: 0, clocks: 0, slic: 0


Then nothing.  I had to push the reset button at this point.
ACPI and APM were disabled from the kernel config.

This boot failure messages was obtained from 
Pentium4 board GB-450(?) from Intel, NVIDIA M64 video.
Sound Blaster 128 PCI.  Netgear PNIC fast ethernet....
  
The same kernel was able to boot up the other Pentium 4 board from 
Gigabyte flawlessly. So, it depends on the motherboard manufacturers.

Regards to all.

G. Hugh Song
