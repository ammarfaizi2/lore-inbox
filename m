Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSGCRfy>; Wed, 3 Jul 2002 13:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSGCRfy>; Wed, 3 Jul 2002 13:35:54 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:39469 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S317102AbSGCRfx>; Wed, 3 Jul 2002 13:35:53 -0400
Date: Wed, 3 Jul 2002 13:38:29 -0400
From: Kareem Dana <kareemy@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: SiS645DX Chipset and agpgart support
Message-Id: <20020703133829.738c63cd.kareemy@earthlink.net>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an ASUS P4S533 motherboard with the sis645dx chipset. I need agpgart support for dri to work correctly, so in my kernel I enabled agpgart support (made the /dev entry) and enabled Generic SiS Chipset support under it.

When my kernel boots up it complains "Unsupported SiS chipset (device id: 0646), you might want to try agp_try_unsupported=1. no supported devices found."

Is the 645dx chipset completely unsupported? It is fairly popular. I believe it uses the same agp controller as the regular sis 645. Is that unsupported as well?

btw, I am using kernel 2.4.18

Thanks,
Kareem
