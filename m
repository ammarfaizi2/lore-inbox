Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQKDRms>; Sat, 4 Nov 2000 12:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129357AbQKDRmi>; Sat, 4 Nov 2000 12:42:38 -0500
Received: from msheas02.msh.de ([212.4.227.2]:44936 "EHLO msheas02.msh.de")
	by vger.kernel.org with ESMTP id <S129340AbQKDRmc>;
	Sat, 4 Nov 2000 12:42:32 -0500
From: Klaus Dittrich <kladi@z.zgs.de>
Message-Id: <200011041741.SAA10204@df1tlb.local.here>
Subject: 2.4.0-test10 does not boot
To: linux-kernel@vger.kernel.org
Date: Sat, 4 Nov 2000 18:41:59 +0100 (MET)
Phone: 049-7151-987709
Fax: 049-7151-987709
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Kernel 2.4.0-test10 does not boot
[2.] I installed  2.4.0-test10 in the same manner and on the same disk
I did with 2.4.0-test8 which boots an runs.
I use an ASUS-P2B-DS with 2xPII-350 and BIOS 1013BETA005.
After rebooting the last message is "Uncompressing the kernel .." and
then the system hangs. 
I have read that using dma by default made trouble so I made a new 
kernel without this feature but with the same bad result.

[3.] Kernel  2.4.0-test10

[4.] from the running system ..
Linux df1tlpc 2.4.0-test8 #3 SMP Wed Nov 1 17:51:26 MET 2000 i686 unknown
Kernel modules         2.3.9
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.0.33
Linux C Library        x   1 root     root      4065224 Oct 18 20:36 /lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10f
Net-tools              1.54
Kbd                    0.99
Sh-utils               2.0
Modules Loaded                                                     

[5.] -

[6.] -

[7.] -

-- 
Best regards 
Klaus Dittrich

e-mail: kladi@z.zgs.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
