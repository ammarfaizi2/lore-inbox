Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129605AbQLDTAm>; Mon, 4 Dec 2000 14:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbQLDTAc>; Mon, 4 Dec 2000 14:00:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44632 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129450AbQLDTAT>; Mon, 4 Dec 2000 14:00:19 -0500
Subject: Re: Re[4]: DMA !NOT ONLY! for triton again...
To: gvlyakh@mail.ru
Date: Mon, 4 Dec 2000 18:29:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E142zsW-0005Al-00@f10.mail.ru> from "Guennadi Liakhovetski" at Dec 04, 2000 08:58:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1430NA-000470-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Certain older WDC drives are explicitly blacklisted due to firmware bugs.
WDC put out firmware upgrades but given no answer from them on how to be sure
a drive was upgraded we play safe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
