Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273255AbRIQAXF>; Sun, 16 Sep 2001 20:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273259AbRIQAWz>; Sun, 16 Sep 2001 20:22:55 -0400
Received: from CPE-61-9-148-200.vic.bigpond.net.au ([61.9.148.200]:56560 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S273255AbRIQAWr>; Sun, 16 Sep 2001 20:22:47 -0400
Message-ID: <3BA53DE8.6837DB0B@eyal.emu.id.au>
Date: Mon, 17 Sep 2001 10:03:52 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <laughing@shared-source.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac11 - unresolved
In-Reply-To: <20010916202712.A21876@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For a change we have some new ones.

depmod: *** Unresolved symbols in
/lib/modules/2.4.9-ac11/kernel/drivers/ide/hptraid.o
depmod:         put_gendisk
depmod: *** Unresolved symbols in
/lib/modules/2.4.9-ac11/kernel/drivers/ide/pdcraid.o
depmod:         put_gendisk
depmod: *** Unresolved symbols in
/lib/modules/2.4.9-ac11/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode
depmod: *** Unresolved symbols in
/lib/modules/2.4.9-ac11/kernel/fs/jffs/jffs.o
depmod:         jffs_min
