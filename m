Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130304AbQKPOKy>; Thu, 16 Nov 2000 09:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130499AbQKPOKo>; Thu, 16 Nov 2000 09:10:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12337 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130304AbQKPOKf>; Thu, 16 Nov 2000 09:10:35 -0500
Subject: Re: [PATCH] pcmcia event thread. (fwd)
To: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 16 Nov 2000 13:40:04 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), torvalds@transmeta.com,
        dhinds@valinux.com, linux-kernel@vger.kernel.org
In-Reply-To: <29549.974130154@redhat.com> from "David Woodhouse" at Nov 13, 2000 03:42:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wPGq-0007om-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's the socket drivers which _aren't_ in the kernel source which are most
> likely to exhibit this problem. Anything in the kernel tree was probably
> converted by Linus, and hence done right. As there are so few socket drivers

Umm..  Linus drivers dont appear to be SMP safe on unload

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
