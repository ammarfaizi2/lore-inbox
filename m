Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129891AbQK1OKp>; Tue, 28 Nov 2000 09:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131031AbQK1OKe>; Tue, 28 Nov 2000 09:10:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23586 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129891AbQK1OKX>; Tue, 28 Nov 2000 09:10:23 -0500
Subject: Re: 2.2.18pre19 oops in try_to_free_pages
To: vherva@mail.niksula.cs.hut.fi (Ville Herva)
Date: Tue, 28 Nov 2000 13:40:31 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20001128150911.P53529@niksula.cs.hut.fi> from "Ville Herva" at Nov 28, 2000 03:09:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140kzp-0004Xt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes. The other problem I saw with 2.2.18pre vm wasn't an oops, it was a
> rampaging vm rambo that slaughtered my X while it was idle. Admittedly

That sounds like the vm stuff being sorted on yes.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
