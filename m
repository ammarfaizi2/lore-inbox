Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131142AbQKLWXc>; Sun, 12 Nov 2000 17:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131221AbQKLWXW>; Sun, 12 Nov 2000 17:23:22 -0500
Received: from DKBH-T-003-p-249-16.tmns.net.au ([203.54.249.16]:22278 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S131142AbQKLWXP>;
	Sun, 12 Nov 2000 17:23:15 -0500
Message-ID: <3A0F14C4.F6766C8F@eyal.emu.id.au>
Date: Mon, 13 Nov 2000 09:08:04 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11-pre3 doesn't compile (ax25 and md)
In-Reply-To: <Pine.LNX.4.21.0011121308440.5594-100000@sjoerd.sjoerdnet> <3A0E8B99.2EA40AF0@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Either md.c or sysctl.h needs to include <linux/types.h>.

It actually needs <linux/fs.h>

--
Eyal Lebedinsky		(eyal@eyal.emu.id.au)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
