Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129038AbQKFLhN>; Mon, 6 Nov 2000 06:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbQKFLhD>; Mon, 6 Nov 2000 06:37:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44365 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129038AbQKFLgq>; Mon, 6 Nov 2000 06:36:46 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 6 Nov 2000 11:35:35 +0000 (GMT)
Cc: goemon@anime.net (Dan Hollis), alan@lxorguk.ukuu.org.uk (Alan Cox),
        dwmw2@infradead.org (David Woodhouse),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A069036.2D64BD96@mandrakesoft.com> from "Jeff Garzik" at Nov 06, 2000 06:04:22 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13skYq-000697-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is why alsa starts up all devices totally muted. Maybe its time for
> > David to move to alsa ;)
> 
> I wouldn't mind leaving devices totally muted until open()...

You need to leave the mixer for cd, tv and radio pass through
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
