Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSCEB6c>; Mon, 4 Mar 2002 20:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293330AbSCEB6M>; Mon, 4 Mar 2002 20:58:12 -0500
Received: from jalon.able.es ([212.97.163.2]:50608 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S293299AbSCEB5x>;
	Mon, 4 Mar 2002 20:57:53 -0500
Date: Tue, 5 Mar 2002 02:57:45 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux 2.4.19-pre2-jam2
Message-ID: <20020305015745.GA1668@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Yup, new release.

Changes:
- vm-28
- ServerWorks DMA fix (I have some SW boxen...)
- bproc 3.1.8

BTTV patches have bee integrated in mainline.
I have also dropped the interrupt-sequential-file-impl, because the big
mips update made applying the patch a mess (I can keep the x86 part, but
think that's not serious...)

Enjoy it at

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre2-jam2/
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre2-jam2.tar.gz

By.

(BTW, it builds and runs fine with Mandrake's gcc-3.0.4).

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.19-pre2-jam2 #1 SMP Tue Mar 5 01:21:55 CET 2002 i686
