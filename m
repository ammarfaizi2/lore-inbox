Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269176AbRHHUfI>; Wed, 8 Aug 2001 16:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269246AbRHHUfA>; Wed, 8 Aug 2001 16:35:00 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:25891 "EHLO
	mailsorter1.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S269176AbRHHUe4>; Wed, 8 Aug 2001 16:34:56 -0400
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C9B6FBF@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'sparclinux@vger.kernel.org'" <sparclinux@vger.kernel.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 2.4.7ac9,10 compile error
Date: Wed, 8 Aug 2001 16:35:01 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

I am trying to install 2.4.7 on my Ultra 5, and I am running into some
problems.  Got some errors compiling a sound module to start so I updated to
2.4.7ac9 and tried again, but got the following error.  I also updated to
2.4.7ac10 that just came out, and got the same error on compile.  Any ideas
where I am going wrong?

Error:
In file included from sched.c:26:

/usr/src/linux-2.4.7/include/linux/irq.h:61: asm/hw_irq.h: No such file or
directory

make[2]: *** [sched.o] Error 1

make[1]: *** [first_rule] Error 2

make: *** [_dir_kernel] Error 2    
                                           
Bruce Holzrichter 
Systems Administrator 
Monster.com 
Phone:  978-461-8869 
Cell:      978-375-9558 
bruce.holzrichter@monster.com 
