Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267797AbUHPRPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267797AbUHPRPk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267804AbUHPRPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:15:40 -0400
Received: from pop.gmx.de ([213.165.64.20]:64213 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267803AbUHPRPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:15:39 -0400
Date: Mon, 16 Aug 2004 19:15:37 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <200408160540.i7G5edJv005866@magilla.sf.frob.com>
Subject: Re: [PATCH] waitid system call
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <10992.1092676537@www28.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is an updated version of the waitid patch that fixes some things 

Roland,

Precisely what kernel version was the patch against?  I've (twice) 
tried applying the patch against 2.6.8.1 and building the kernel.  
The build succeeds, but I am running into a strange kernel panic 
("Unable to mount root fs") when I try to boot the resulting 
kernel.  (Compiling and booting 2.6.8.1 on the same x86 machine 
works fine.)

Cheers,

Michael


-- 
NEU: WLAN-Router für 0,- EUR* - auch für DSL-Wechsler!
GMX DSL = supergünstig & kabellos http://www.gmx.net/de/go/dsl

