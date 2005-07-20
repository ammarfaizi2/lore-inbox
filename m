Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVGTXKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVGTXKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 19:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVGTXKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 19:10:46 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:3464 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261524AbVGTXKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 19:10:44 -0400
Message-ID: <42DED9F3.4040300@gmail.com>
Date: Thu, 21 Jul 2005 01:10:43 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Obsolete files in 2.6 tree
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are these files obsolete and could be deleted from tree.
Does anybody use them? Could anybody compile them?

drivers/char/drm/gamma_dma.c
drivers/char/drm/gamma_drv.c
drivers/char/scan_keyb.c
drivers/char/scan_keyb.h
drivers/input/power.c
drivers/isdn/hisax/elsa_ser.c
drivers/media/video/zr36120.c
drivers/media/video/zr36120_i2c.c
drivers/media/video/zr36120_mem.c
drivers/net/wan/sdladrv.c
drivers/scsi/aic7xxx_old*
drivers/scsi/NCR5380.c
drivers/scsi/NCR5380.h
drivers/scsi/scsi_module.c
drivers/video/pm3fb.c
fs/befs/attribute.c
fs/binfmt_som.c
fs/binfmt_flat.c
sound/oss/skeleton.c

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

