Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUIFBxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUIFBxT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 21:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUIFBxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 21:53:19 -0400
Received: from relay-4m.club-internet.fr ([194.158.104.43]:25846 "EHLO
	relay-4m.club-internet.fr") by vger.kernel.org with ESMTP
	id S267388AbUIFBxP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 21:53:15 -0400
From: pinotj@club-internet.fr
To: linux-kernel@vger.kernel.org
Subject: Supported architectures for Linux 2.6
Date: Mon,  6 Sep 2004 03:53:12 CEST
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1094435592.18565.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I updated the documentation I wrote about architectures supported by the 2.6.X kernel. Here is the beginning for the curious:

----8<------
August 2004		Supported architectures for Linux	v2.6.8
			~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The following is a quite complete list of all the architectures supported
by Linux. Of course, you will find here Alpha, ARM, ARM26, CRIS, H8300,
i386, IA-64, M68000, MIPS, PA-RISC, PPC, S/390, SuperH, SPARC, v850 and
x86-64. But you will find too a complete list of CPUs and board supported
by the kernel. For each part, first list means "board" and second one
means "CPU".


 Content:
 ~~~~~~~~
	1. i386		7. IA-64		13. S/390 (32/64)
	2. Alpha	8. M68K			14. SuperH (32/64)
	3. ARM		9. MIPS (32/64, LE/BE)	15. SPARC
	4. ARM26	10. PA-RISC (32/64)	16. UltraSPARC
	5. CRIS		11. PPC			17. v850
	6. H8300	12. PPC64		18. x86-64
	
  

 1. i386
 ~~~~~~~
	AMD Elan
	NUMAQ (IBM/Sequent)
	PC-compatible	(generic)
	SGI 320/540 (Visual Workstation)
	Summit/EXA (IBM x440)
	Unisys ES7000 IA32
	Voyager (NCR)
	generic SMP (Summit, bigsmp, ES7000)
	generic SMP with more than 8 CPUs
		
		AMD 386DX/DXL/SL/SLC/SX
		AMD 486DX/DX2/DX4/SL/SLC/SLC2/SLC3/SX/SX2
		AMD Elan
		AMD K5
		AMD K6/K6-II/K6-III
		AMD K7/Athlon/Duron/Thunderbird
		AMD K8/Athlon64/Hammer/Opteron
		Cyrix 386DX/DXL/SL/SLC/SX
		Cyrix 486DLC/DLC2/DX/DX2/DX4/SL/SLC/SLC2/SLC3/SX/SX2
		Cyrix III
		IBM 486DX/DX2/DX4/SL/SLC/SLC2/SLC3/SX/SX2
		IDT Winchip
		IDT Winchip 2
		IDT Winchip 2A/3
		Intel 386DX/DXL/SL/SLC/SX
		Intel 486DX/DX2/DX4/SL/SLC/SLC2/SLC3/SX/SX2
----8<------

The complete file is available here :
http://cercle-daejeon.homelinux.org/linux/kernel/arch.txt 

If you have any comments/suggestions/modifications please put me in CC when you answer this mail.

Regards,

--
Jerome Pinot
http://cercle-daejeon.homelinux.org/linux

