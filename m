Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261743AbSIXTNT>; Tue, 24 Sep 2002 15:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261749AbSIXTNS>; Tue, 24 Sep 2002 15:13:18 -0400
Received: from math.ut.ee ([193.40.5.125]:55729 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S261743AbSIXTNS>;
	Tue, 24 Sep 2002 15:13:18 -0400
Date: Tue, 24 Sep 2002 22:18:21 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: PPC: unresolved module symbols in 2.4.20-pre7+bk
Message-ID: <Pine.GSO.4.44.0209242216450.17647-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/macintosh/nvram.o
depmod: 	pmac_get_partition
depmod: 	nvram_write_byte_R9ce3f83f
depmod: 	nvram_read_byte_R0f28cb91
depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/media/video/tda7432.o
depmod: 	__fixdfsi
depmod: 	__floatsidf
depmod: 	__divdf3
depmod: 	__muldf3
depmod: 	__subdf3
depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/sound/dmasound/dmasound_pmac.o
depmod: 	pmac_xpram_read
depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/usb/storage/usb-storage.o
depmod: 	ppc_generic_ide_fix_driveid

-- 
Meelis Roos (mroos@linux.ee)

