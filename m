Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422751AbWJNSOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWJNSOu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 14:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422748AbWJNSOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 14:14:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5775 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422733AbWJNSOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 14:14:49 -0400
Subject: Re: [KJ] [PATCH] drivers/char/riscom8.c:
	save_flags()/cli()/sti()	removal
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Amol Lad <amol@verismonetworks.com>,
       kernel Janitors <kernel-janitors@lists.osdl.org>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061014174936.GN11633@parisc-linux.org>
References: <1160739628.19143.376.camel@amol.verismonetworks.com>
	 <1160835602.5732.30.camel@localhost.localdomain>
	 <20061014174936.GN11633@parisc-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Oct 2006 19:41:20 +0100
Message-Id: <1160851280.5732.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-10-14 am 11:49 -0600, ysgrifennodd Matthew Wilcox:
> Only broken on SMP ...
> 
> I wouldn't mind writing a new driver (using the serial core) if someone
> wants to send me one.  I need a multiport serial card anyway ...

You still have ISA bus ?

