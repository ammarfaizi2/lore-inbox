Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318913AbSIITCT>; Mon, 9 Sep 2002 15:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318914AbSIITCS>; Mon, 9 Sep 2002 15:02:18 -0400
Received: from gzp11.gzp.hu ([212.40.96.53]:28684 "EHLO gzp11.gzp.hu")
	by vger.kernel.org with ESMTP id <S318913AbSIITCR>;
	Mon, 9 Sep 2002 15:02:17 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: Re: Linux 2.5.34
References: <Pine.LNX.4.33.0209091049180.11925-100000@penguin.transmeta.com>
User-Agent: tin/1.5.14-20020814 ("Chop Suey!") (UNIX) (Linux/2.4.19 (i686))
Message-ID: <5b98.3d7cf155.86777@gzp1.gzp.hu>
Date: Mon, 09 Sep 2002 19:07:01 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 2.95.4-cvs
GNU ld version 2.12.90.0.4 20020408

make[3]: Entering directory `/usr/src/linux-2.5.34/drivers/net/irda'
  gcc -Wp,-MD,./.irtty.o.d -D__KERNEL__ -I/usr/src/linux-2.5.34/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=irtty   -c -o irtty.o irtty.c
irtty.c: In function `irtty_cleanup':
irtty.c:121: called object is not a function
irtty.c:122: parse error before string constant
irtty.c: In function `irtty_open':
irtty.c:229: called object is not a function
irtty.c:229: parse error before string constant
irtty.c:248: called object is not a function
irtty.c:248: parse error before string constant
irtty.c: In function `irtty_change_speed':
irtty.c:454: called object is not a function
irtty.c:455: parse error before string constant
irtty.c:466: called object is not a function
irtty.c:466: parse error before string constant
make[3]: *** [irtty.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.34/drivers/net/irda'
make[2]: *** [irda] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.34/drivers/net'
make[1]: *** [net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.34/drivers'
make: *** [drivers] Error 2

