Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbRBFR5Q>; Tue, 6 Feb 2001 12:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129772AbRBFR5G>; Tue, 6 Feb 2001 12:57:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25357 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129706AbRBFR4z>; Tue, 6 Feb 2001 12:56:55 -0500
Subject: Re: sync & asyck i/o
To: jbm@joshisanerd.com (Josh Myer)
Date: Tue, 6 Feb 2001 17:56:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0102061147590.27615-100000@grace> from "Josh Myer" at Feb 06, 2001 11:51:15 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QCME-00066k-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this imply that in order to ensure my data hits the drives, i should
> do a warm reboot and then shut down from the lilo: prompt or similiar?

As far as I can tell the IDE drives are write caching at most a second or two
of data. Andre may know more

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
