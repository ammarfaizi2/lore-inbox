Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281077AbRLIBYZ>; Sat, 8 Dec 2001 20:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281153AbRLIBYR>; Sat, 8 Dec 2001 20:24:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51723 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281077AbRLIBX5>; Sat, 8 Dec 2001 20:23:57 -0500
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
To: davidm@hpl.hp.com
Date: Sun, 9 Dec 2001 01:32:29 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        akpm@zip.com.au (Andrew Morton), j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <15378.47872.93458.589286@napali.hpl.hp.com> from "David Mosberger" at Dec 08, 2001 05:14:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CspR-0003So-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Alan> And break the ability for non broken setups to debug SMP boot
>   Alan> up. Lets do the job properly.
> 
> Then use Andrew's patch (attached below).

No objection.
