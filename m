Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282253AbRKWVvx>; Fri, 23 Nov 2001 16:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282255AbRKWVvo>; Fri, 23 Nov 2001 16:51:44 -0500
Received: from [213.228.128.57] ([213.228.128.57]:11704 "HELO
	front2.netvisao.pt") by vger.kernel.org with SMTP
	id <S282253AbRKWVvZ>; Fri, 23 Nov 2001 16:51:25 -0500
To: linux-kernel@vger.kernel.org
Subject: Kernel Compilation Basics
From: pocm@rnl.ist.utl.pt (Paulo J. Matos aka PDestroy)
Date: 23 Nov 2001 21:57:51 +0000
Message-ID: <m3pu69qheo.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to compile 2.4.15.
I've read Kernel Howto and I've done the quick compilation steps:
make xconfig
make dep
make clean
make bzImage
cp arch/i386/boot/bzImage /boot/vmlinuz-2.4.15
make modules
make modules_install

What about now?
How do I create system map and modules info?
What are they for?
I feel that kernel howto is not explicit with this questions.
Is there any place where can I get insight about these questions?

Best regards,

-- 
Paulo J. Matos aka PDestroy : pocm(_at_)rnl.ist.utl.pt
Instituto Superior Tecnico - Lisbon    
Software & Computer Engineering - A.I.
 - > http://www.rnl.ist.utl.pt/~pocm 
 ---	
	Yes, God had a deadline...
		So, He wrote it all in Lisp!

