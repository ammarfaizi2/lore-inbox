Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265488AbRGOBnb>; Sat, 14 Jul 2001 21:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265507AbRGOBnV>; Sat, 14 Jul 2001 21:43:21 -0400
Received: from CPE-61-9-148-127.vic.bigpond.net.au ([61.9.148.127]:65015 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S265488AbRGOBnM>;
	Sat, 14 Jul 2001 21:43:12 -0400
Message-ID: <3B50F26C.19334B5F@eyal.emu.id.au>
Date: Sun, 15 Jul 2001 11:31:24 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <laughing@shared-source.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-ac3 - some unresolved
In-Reply-To: <20010714183603.A5773@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building a kernel with as many modules as possible (i386).

depmod: *** Unresolved symbols in
/lib/modules/2.4.6-ac3/kernel/drivers/net/dl2k.o
depmod:         __ucmpdi2
depmod: *** Unresolved symbols in
/lib/modules/2.4.6-ac3/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode
