Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbSKMBen>; Tue, 12 Nov 2002 20:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbSKMBen>; Tue, 12 Nov 2002 20:34:43 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:51691 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S267090AbSKMBel>;
	Tue, 12 Nov 2002 20:34:41 -0500
Date: Wed, 13 Nov 2002 02:41:20 +0100
From: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux 2.4.20-rc1-jam2
Message-ID: <20021113014120.GC1806@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Just to public a new relase ;).

Changes/updates/new things:

- update to official rc1-aa1
- reverted the pte_fast changes in -aa. It cured my hangs on X logoff with
  nvidia driver. Perhaps some bug when gart releases pages ??
- add the force_inline patch from Denis Vlasenko, with some additions for
  __copy_[to,from]_user
- kmsgdump-0.4.4 by  Willy Tarreau: dump oopsen to floppy/console...
- proconfig-0.9.5 by Peter T. Breuer: store .config in /proc/config
- bttv updates and missing files
- bproc 3.2.2

More info on
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.20-rc1-jam2/README.txt

Get it at 

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.20-rc1-jam2/
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.20-rc1-jam2.tar.gz

Enjoy !!

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-rc1-jam2 (gcc 3.2 (Mandrake Linux 9.1 3.2-3mdk))
