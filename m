Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272065AbRIPNk5>; Sun, 16 Sep 2001 09:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271129AbRIPNkq>; Sun, 16 Sep 2001 09:40:46 -0400
Received: from web10404.mail.yahoo.com ([216.136.130.96]:59658 "HELO
	web10404.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271370AbRIPNkd>; Sun, 16 Sep 2001 09:40:33 -0400
Message-ID: <20010916134057.10660.qmail@web10404.mail.yahoo.com>
Date: Sun, 16 Sep 2001 23:40:57 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: 2.4.10-pre7 compile error 
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this when compiling the kernel

i810_audio.c:500: `AC97_EA_VRA' undeclared (first use
in this function)
i810_audio.c: In function `i810_set_dac_channels':
i810_audio.c:543: `AC97_EA_PRI' undeclared (first use
in this function)
i810_audio.c:543: `AC97_EA_PRJ' undeclared (first use
in this function)
i810_audio.c:543: `AC97_EA_PRK' undeclared (first use
in this function)
i810_audio.c: In function `i810_ioctl':
i810_audio.c:1589: `AC97_EA_SPSA_3_4' undeclared
(first use in this function)
i810_audio.c:1989: `AC97_SPDIF_CONTROL' undeclared
(first use in this function)
i810_audio.c: In function `i810_open':
i810_audio.c:2187: `AC97_EA_SPSA_3_4' undeclared
(first use in this function)
make[2]: *** [i810_audio.o] Error 1
make[2]: Leaving directory `/home/linux/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2
make[1]: Leaving directory `/home/linux/drivers'
make: *** [_mod_drivers] Error 2


=====
S.KIEU

http://travel.yahoo.com.au - Yahoo! Travel
- Got Itchy feet? Get inspired!
