Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262561AbRE3B5S>; Tue, 29 May 2001 21:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262563AbRE3B5I>; Tue, 29 May 2001 21:57:08 -0400
Received: from rmx614-mta.mail.com ([165.251.48.52]:5044 "EHLO
	rmx614-mta.mail.com") by vger.kernel.org with ESMTP
	id <S262561AbRE3B46>; Tue, 29 May 2001 21:56:58 -0400
Message-ID: <381058575.991187817702.JavaMail.root@web649-wra>
Date: Tue, 29 May 2001 21:56:51 -0400 (EDT)
From: Frank Davis <fdavis112@juno.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac4 es1371.o unresolved symbols
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.245.193
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
     While 'make modules_install' on 2.4.5-ac4, I received the following error:
depmod: *** Unresolved symbols in /lib/modules/2.4.5-ac4/kernel/drivers/sound/es1371.o
depmod:  gameport_register_port_Rsmp_aa96bd99
depmod:  gameport_unregister_port_Rsmp_ec101047

The previous steps make mrproper, make config, make clean, make bzImage, make modules all appeared to work.
The .config is the same as 2.4.5-ac3 

Regards,
Frank


