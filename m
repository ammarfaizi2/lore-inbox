Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291473AbSBUJ7h>; Thu, 21 Feb 2002 04:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291565AbSBUJ7c>; Thu, 21 Feb 2002 04:59:32 -0500
Received: from [210.19.28.11] ([210.19.28.11]:4480 "EHLO dZuRa.Vault-ID.com")
	by vger.kernel.org with ESMTP id <S291449AbSBUJ6R>;
	Thu, 21 Feb 2002 04:58:17 -0500
Date: Thu, 21 Feb 2002 17:55:37 +0800
From: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
To: linux-kernel@vger.kernel.org
Subject: 2.5.5final compile error
Message-Id: <20020221175537.4b499781.Corporal_Pisang@Counter-Strike.com.my>
Organization: CS Malaysia
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
User-Agent: Half Life (Build 1760)
X-Operating-System: FreeBSD 5.0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this compile error while compiling 2.5.5final.

make[4]: Entering directory `/usr/src/linux/drivers/video/riva'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon    -DKBUILD_BASENAME=fbdev  -c -o fbdev.o fbdev.c
fbdev.c: In function `riva_set_fbinfo':
fbdev.c:1814: incompatible types in assignment
make[4]: *** [fbdev.o] Error 1
make[4]: Leaving directory `/usr/src/linux/drivers/video/riva'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/linux/drivers/video/riva'
make[2]: *** [_subdir_riva] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/video'
make[1]: *** [_subdir_video] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2


-Ubaida-
