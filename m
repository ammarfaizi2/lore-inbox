Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSEYKCm>; Sat, 25 May 2002 06:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314442AbSEYKCl>; Sat, 25 May 2002 06:02:41 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:19172 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S314422AbSEYKCk>;
	Sat, 25 May 2002 06:02:40 -0400
Date: Sat, 25 May 2002 13:02:40 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: matroxfb & 2.5.18 BK: unresolved symbols in modules
Message-ID: <Pine.GSO.4.43.0205251301100.25029-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matroxfb as module:

depmod: *** Unresolved symbols in /lib/modules/2.5.18/kernel/drivers/video/matrox/matroxfb_DAC1064.o
depmod: 	matrox_init_putc
depmod: *** Unresolved symbols in /lib/modules/2.5.18/kernel/drivers/video/matrox/matroxfb_Ti3026.o
depmod: 	matrox_init_putc
depmod: *** Unresolved symbols in /lib/modules/2.5.18/kernel/drivers/video/matrox/matroxfb_base.o
depmod: 	matrox_text_round
depmod: 	matrox_cfbX_init
depmod: 	initMatrox

-- 
Meelis Roos (mroos@linux.ee)

