Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131520AbQKBAYI>; Wed, 1 Nov 2000 19:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131925AbQKBAXs>; Wed, 1 Nov 2000 19:23:48 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:34827 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131520AbQKBAXq>;
	Wed, 1 Nov 2000 19:23:46 -0500
Message-ID: <3A00B3D6.AC53E32@mandrakesoft.com>
Date: Wed, 01 Nov 2000 19:22:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Tom Rini <trini@kernel.crashing.org>, "David S. Miller" <davem@redhat.com>,
        garloff@suse.de, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <E13r7LH-0000z2-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Mandrake kgcc I believe is egcs 1.1.2

Correct...

Though Richard Henderson's message recent about 'gcc -V ...' not doing
the right thing has me worried...  egcs 1.1.2 not gcc 2.95.2 is
definitely being called when '/usr/bin/kgcc' is executed, but I'm still
worried that some details might be getting lost... 
http://boudicca.tux.org/hypermail/linux-kernel/2000week44/1069.html

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
