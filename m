Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132861AbRDIWUi>; Mon, 9 Apr 2001 18:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132862AbRDIWU2>; Mon, 9 Apr 2001 18:20:28 -0400
Received: from [202.123.212.187] ([202.123.212.187]:12305 "EHLO ns1.b2s.com")
	by vger.kernel.org with ESMTP id <S132861AbRDIWUP>;
	Mon, 9 Apr 2001 18:20:15 -0400
Message-ID: <3AD235D7.E590147@vtc.edu.hk>
Date: Tue, 10 Apr 2001 06:21:11 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-pre1 Unresolved symbols "strstr"
In-Reply-To: <Pine.LNX.4.33.0104090940520.5815-100000@boston.corp.fedex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:

> depmod version 2.4.5
>
> Compiled 2.4.4-pre1 but running "depmod" generates a lot of these ...
>
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.4-pre1/kernel/drivers/char/ltmodem.o
> depmod:         strstr
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.4-pre1/kernel/drivers/char/serial.o
> depmod:         strstr
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-cd.o
> depmod:         strstr
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-mod.o
> depmod:         strstr
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-probe-mod.o
> depmod:         strstr
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.4-pre1/pcmcia/xirc2ps_cs.o
> depmod:         strstr

depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-cd.o
depmod:         strstr
depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-tape.o
depmod:         strstr
depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/isdn/avmb1/capidrv.o
depmod:         strstr
depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/isdn/icn/icn.o
depmod:         strstr
depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/net/de4x5.o
depmod:         strstr
depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/net/depca.o
depmod:         strstr
depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/net/ewrk3.o
depmod:         strstr
depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/net/hamradio/baycom_epp.o
depmod:         strstr
depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/parport/parport.o
depmod:         strstr

This is on a Cyrix P-166.  Same with depmod 2.4.2 or 2.3.21

--
Nick Urbanik, Dept. of Computing and Mathematics
Hong Kong Institute of Vocational Education (Tsing Yi)
email: nicku@vtc.edu.hk
Tel:   (852) 2436 8576, (852) 2436 8579   Fax: (852) 2435 1406
pgp ID: 7529555D fingerprint: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B



