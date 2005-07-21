Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVGUJrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVGUJrm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 05:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVGUJrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 05:47:42 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:45448 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261729AbVGUJrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 05:47:42 -0400
Message-ID: <42DF6F34.4080804@gmail.com>
Date: Thu, 21 Jul 2005 11:47:32 +0200
From: Jiri Slaby <lnx4us@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Obsolete files in 2.6 tree
References: <42DED9F3.4040300@gmail.com>
In-Reply-To: <42DED9F3.4040300@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby napsal(a):

> Are these files obsolete and could be deleted from tree.
> Does anybody use them? Could anybody compile them?

New list should be:
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
drivers/scsi/NCR5380.c
drivers/scsi/NCR5380.h
drivers/scsi/scsi_module.c
drivers/video/pm3fb.c
fs/befs/attribute.c
fs/binfmt_som.c
sound/oss/skeleton.c

