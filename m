Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286821AbSBOEMM>; Thu, 14 Feb 2002 23:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbSBOEMB>; Thu, 14 Feb 2002 23:12:01 -0500
Received: from zephyr.host4u.net ([216.71.64.66]:41745 "EHLO zephyr.host4u.net")
	by vger.kernel.org with ESMTP id <S286821AbSBOELq>;
	Thu, 14 Feb 2002 23:11:46 -0500
Subject: 2.5.4 make errorf
From: lee johnson <lee@imyourhandiman.com>
To: kernel-list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 (1.0.1-2) 
Date: 14 Feb 2002 19:49:24 -0800
Message-Id: <1013744965.21906.8.camel@imyourhandiman>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi..

   anyone actually getting 2.5.4 to make without errors...mine starts
and ends fairly abruptly..I thought it was a good idea due to hearing
alsa  is in 2.5.5 patch.

thx
lee
-===   


-------------------------------
In file included from /usr/src/linux-2.5.4/include/asm/thread_info.h:13,
                 from
/usr/src/linux-2.5.4/include/linux/thread_info.h:10,
                 from /usr/src/linux-2.5.4/include/linux/spinlock.h:7,
                 from /usr/src/linux-2.5.4/include/linux/mmzone.h:8,
                 from /usr/src/linux-2.5.4/include/linux/gfp.h:4,
                 from /usr/src/linux-2.5.4/include/linux/slab.h:14,
                 from /usr/src/linux-2.5.4/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux-2.5.4/include/asm/processor.h: In function
`thread_saved_pc':
/usr/src/linux-2.5.4/include/asm/processor.h:444: dereferencing pointer
to incomplete type
/usr/src/linux-2.5.4/include/asm/processor.h:445: warning: control
reaches end of non-void function
make: *** [init/main.o] Error 1




