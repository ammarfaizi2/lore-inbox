Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131228AbRCHANu>; Wed, 7 Mar 2001 19:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131235AbRCHANl>; Wed, 7 Mar 2001 19:13:41 -0500
Received: from mail-f0.jaist.ac.jp ([150.65.7.20]:2688 "EHLO
	mailspool.jaist.ac.jp") by vger.kernel.org with ESMTP
	id <S131228AbRCHANh>; Wed, 7 Mar 2001 19:13:37 -0500
To: linux-kernel@vger.kernel.org
Subject: Can't compile 2.4.2-ac14
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Channel Islands)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010308091307Z.amatsus@jaist.ac.jp>
Date: Thu, 08 Mar 2001 09:13:07 +0900
From: MATSUSHIMA Akihiro <amatsus@jaist.ac.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I receive the following error with make bzImage:

i386_ksyms.c:170: `do_BUG' undeclared here (not in a function)
i386_ksyms.c:170: initializer element is not constant
i386_ksyms.c:170: (near initialization for `__ksymtab_do_BUG.value')
make[1]: *** [i386_ksyms.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.2-ac14/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2


Regards,
	Akihiro
