Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263649AbSITU6C>; Fri, 20 Sep 2002 16:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263633AbSITU6A>; Fri, 20 Sep 2002 16:58:00 -0400
Received: from technicolor.pl ([62.21.19.63]:6673 "EHLO technicolor.pl")
	by vger.kernel.org with ESMTP id <S263632AbSITU5n>;
	Fri, 20 Sep 2002 16:57:43 -0400
Date: Fri, 20 Sep 2002 23:02:42 +0200 (CEST)
From: Pawel Bernadowski <pbern@wilnet.info>
To: linux-kernel@vger.kernel.org
Subject: 2.4.36 - trm290
Message-ID: <Pine.LNX.4.44L.0209202301190.13443-100000@niunius.wilnet.info>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i didn`t compile 2.5.36(& 37).. error :

 gcc -Wp,-MD,./.trm290.o.d -D__KERNEL__ 
-I/home/users/builder/rpm/BUILD/linux-2.5.37/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686
-I/home/users/builder/rpm/BUILD/linux-2.5.37/arch/i386/mach-generic 
-nostdinc -iwithprefix include  -I../  -DKBUILD_BASENAME=trm290   -c -o 
trm290.o    
trm290.c
trm290.c: In function `trm290_ide_dma_write':
trm290.c:195: too many arguments to function `ide_build_dmatable'
trm290.c: In function `trm290_ide_dma_read':
trm290.c:239: too many arguments to function `ide_build_dmatable'
make[3]: *** [trm290.o] Error 1




Pawel Bernadowski
GG: 3377 

