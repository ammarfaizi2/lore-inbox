Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130792AbQKXOgu>; Fri, 24 Nov 2000 09:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131765AbQKXOga>; Fri, 24 Nov 2000 09:36:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17967 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S130792AbQKXOgU>; Fri, 24 Nov 2000 09:36:20 -0500
Subject: Re: [PATCH] linux/drivers/media/radio check_region() removal
To: pazke@orbita.don.sitek.net (Andrey Panin)
Date: Fri, 24 Nov 2000 14:05:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001124155818.B3900@debian> from "Andrey Panin" at Nov 24, 2000 03:58:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13zJUG-00002Q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> attached patch removes all check_region() calls from /linux/drivers/media/r=
> adio
> drivers. Most changes  are obvious, except radio-cadet.c which needs some=
> =20
> maintainer's attention.=20

Please check the -ac tree. I've already done them
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
