Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131805AbQKAXLf>; Wed, 1 Nov 2000 18:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131852AbQKAXL2>; Wed, 1 Nov 2000 18:11:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5671 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131805AbQKAXLO>; Wed, 1 Nov 2000 18:11:14 -0500
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
To: garloff@suse.de (Kurt Garloff)
Date: Wed, 1 Nov 2000 23:12:30 +0000 (GMT)
Cc: jamagallon@able.es (J . A . Magallon),
        linux-kernel@vger.kernel.org (Linux kernel list)
In-Reply-To: <20001101235734.D10585@garloff.etpnet.phys.tue.nl> from "Kurt Garloff" at Nov 01, 2000 11:57:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13r73Y-0000xK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kgcc is a redhat'ism. They invented this package because their 2.96 fails
> compiling a stable kernel.
> However, it's not a good idea to dist specific code into the official kernel
> tree.

The changes in 2.2.18pre for picking the compiler are actually for multiple
distributions. The 'kgcc' convention isnt a Red Hat invention btw. Its from
Conectiva.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
