Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbSI3AMw>; Sun, 29 Sep 2002 20:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSI3AMw>; Sun, 29 Sep 2002 20:12:52 -0400
Received: from CPE-203-51-31-60.nsw.bigpond.net.au ([203.51.31.60]:57329 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S261856AbSI3AMv>; Sun, 29 Sep 2002 20:12:51 -0400
Message-ID: <3D979841.BBEF64C7@eyal.emu.id.au>
Date: Mon, 30 Sep 2002 10:18:09 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre8-ac1 unresolved
References: <200209291848.g8TImtf19741@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignoring comx, the other two are new.

depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre8-ac1/kernel/drivers/hotplug/pci_hotplug.o
depmod:         proc_bus_pci_dir
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre8-ac1/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre8-ac1/kernel/fs/jfs/jfs.o
depmod:         cond_resched

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
