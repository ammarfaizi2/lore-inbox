Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132384AbRCZIGv>; Mon, 26 Mar 2001 03:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132385AbRCZIGl>; Mon, 26 Mar 2001 03:06:41 -0500
Received: from [210.220.245.88] ([210.220.245.88]:55179 "HELO kernel.pe.kr")
	by vger.kernel.org with SMTP id <S132384AbRCZIG3> convert rfc822-to-8bit;
	Mon, 26 Mar 2001 03:06:29 -0500
Date: Mon, 26 Mar 2001 17:04:23 +0900 (KST)
From: Chung Won-young <suni00@kernel.pe.kr>
To: <linux-kernel@vger.kernel.org>
cc: <alan@lxorguk.ukuu.org.uk>
Subject: Can't compile 2.4.2-ac25
Message-ID: <Pine.LNX.4.31.0103261658150.8005-100000@pain.kernel.pe.kr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=euc-kr
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
I receive the following error with make zImage:

es1370.c: In function `es1370_probe':
es1370.c:2667: structure has no member named `trigger'
es1370.c:2667: structure has no member named `read'
make[3]: *** [es1370.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.2/drivers/sound'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.2/drivers/sound'
make[1]: *** [_subdir_sound] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.2/drivers'
make: *** [_dir_drivers] Error 2



maybe 'Update es1370, es1371,esssolo' has some problem.


- ∆Û¿Œ -

ICQ : 36602496
E - Mail : suni00@kernel.pe.kr, suni00@kldp.org
Homepage : http://kernel.pe.kr, http://pain.kernel.pe.kr

