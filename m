Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129995AbQKFVU1>; Mon, 6 Nov 2000 16:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130190AbQKFVUR>; Mon, 6 Nov 2000 16:20:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18784 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129995AbQKFVUC>; Mon, 6 Nov 2000 16:20:02 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: paulj@itg.ie (Paul Jakma)
Date: Mon, 6 Nov 2000 21:18:23 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse),
        jgarzik@mandrakesoft.com (Jeff Garzik), goemon@anime.net (Dan Hollis),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011061814350.31802-100000@rossi.itg.ie> from "Paul Jakma" at Nov 06, 2000 06:22:10 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13steq-0006d5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i'd also like to see dist's adopt a nice config file specifying which
> modules to statically load at boot-time. (i know i want i them
> loaded). then maybe info from depmod could be applied to remove
> redundant loads.

Its called modules.conf. It has all these nice preload directives in it

> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
