Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSJOHTE>; Tue, 15 Oct 2002 03:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263242AbSJOHTE>; Tue, 15 Oct 2002 03:19:04 -0400
Received: from ns.cinet.co.jp ([210.166.75.130]:51464 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S263228AbSJOHTE>;
	Tue, 15 Oct 2002 03:19:04 -0400
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A305@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'GOTO Masanori '" <gotom@debian.or.jp>
Cc: "'LKML '" <linux-kernel@vger.kernel.org>,
       "'Linus Torvalds '" <torvalds@transmeta.com>
Subject: RE: [PATCH][RFC] Add support for PC-9800 architecture
Date: Tue, 15 Oct 2002 16:24:47 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your advice.

GOTO Masanori wrote:
> Splitting one patch into small patchsets is good idea for me, like
> each driver parts and mach-pc9800 depending part, arch/i386 generic
> part...
I'll try to split patch and resend within a week.

> In addition some place seems to need cleanup, for example ide.c,
> 3c569b/at1000 (is it difficult to merge with 3c509.c/at1700?), etc.
Indeed, 3c569b into 3c509.c and at1000 into at1700 are probably okey.
But, I think ide.c patch is very simple.
So, no-need to cleanup, isn't it?

Regards
--
Osamu Tomita <tomita@cinet.co.jp>

