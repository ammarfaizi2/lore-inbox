Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312339AbSCUBuz>; Wed, 20 Mar 2002 20:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312340AbSCUBug>; Wed, 20 Mar 2002 20:50:36 -0500
Received: from jalon.able.es ([212.97.163.2]:2443 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S312339AbSCUBuX>;
	Wed, 20 Mar 2002 20:50:23 -0500
Date: Thu, 21 Mar 2002 02:50:16 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux 2.4.19-pre4-jam1
Message-ID: <20020321015016.GA1665@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Fresh new version...

Some bits are getting into mainline (aic-6.2.5, linear layout for mmap...)
so it is time to get new things.

Changes:
- Switch to Andrew split version of vm-32
- Add IDE help missing in mainline
- Some bits for kernel size reduction: shared zlib, BUG changes
- The usual bproc update: 3.1.9

The rest (O1-sched-K3, mini-lowlatency, read-latency) remain the same.

URL:
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre4-jam1.tar.gz
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre4-jam1/

Have fun...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release cooker (Cooker) for i586
Linux werewolf 2.4.19-pre4-jam1 #1 SMP Thu Mar 21 02:05:01 CET 2002 i686
