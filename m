Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbTIBL4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 07:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTIBL4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 07:56:10 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:51707
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S261314AbTIBL4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 07:56:05 -0400
Message-ID: <3F548543.D5888E3B@eyal.emu.id.au>
Date: Tue, 02 Sep 2003 21:55:47 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22aa1 - unresolved
References: <20030902020218.GB1599@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

practically everything is a module.

depmod: *** Unresolved symbols in
/lib/modules/2.4.22-aa1/kernel/drivers/scsi/scsi_mod.o
depmod:         open_softirq

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
practically everything is a module.

depmod: *** Unresolved symbols in
/lib/modules/2.4.22-aa1/kernel/drivers/scsi/scsi_mod.o
depmod:         open_softirq

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
