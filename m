Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129845AbQLDMzo>; Mon, 4 Dec 2000 07:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129958AbQLDMze>; Mon, 4 Dec 2000 07:55:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13136 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129845AbQLDMzX>; Mon, 4 Dec 2000 07:55:23 -0500
Subject: Re: test12-pre4
To: jgarzik@mandrakesoft.mandrakesoft.com (Jeff Garzik)
Date: Mon, 4 Dec 2000 12:25:04 +0000 (GMT)
Cc: mhaque@haque.net (Mohammad A. Haque),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.3.96.1001204020202.19309A-100000@mandrakesoft.mandrakesoft.com> from "Jeff Garzik" at Dec 04, 2000 02:03:05 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E142ug6-0003my-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > dummy.c: In function `dummy_init_module':
> > dummy.c:103: invalid type argument of `->'
> > make[2]: *** [dummy.o] Error 1
> 
> No, module.h needs fixing.  I guess I didn't send that one to Alan...

You did send it, you just didnt tell me the dummy patch depended on it
and that I needed to send both together 8)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
