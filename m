Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129246AbQKGMJP>; Tue, 7 Nov 2000 07:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129662AbQKGMJG>; Tue, 7 Nov 2000 07:09:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29045 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129246AbQKGMJD>; Tue, 7 Nov 2000 07:09:03 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: jas88@cam.ac.uk (James A. Sutherland)
Date: Tue, 7 Nov 2000 12:07:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jas88@cam.ac.uk (James A. Sutherland),
        goemon@anime.net (Dan Hollis), dwmw2@infradead.org (David Woodhouse),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <00110700431704.00940@dax.joh.cam.ac.uk> from "James A. Sutherland" at Nov 07, 2000 12:38:54 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13t7Wv-0007Jm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I plug it in and modprobe is triggered to load the driver, a script then
> runs to feed the device appropriate configuration info. Since the driver only
> resets the hardware when it is given the correct configuration, there's no
> problem.

Thats another 100 lines of race prone network kernel code you dont need

> Hmm... define "identical". I take a laptop home, use a USB NIC to talk to my

Same Mac address or same serial number.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
