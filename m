Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131919AbQKQL0z>; Fri, 17 Nov 2000 06:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131882AbQKQL0g>; Fri, 17 Nov 2000 06:26:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132003AbQKQLZy>; Fri, 17 Nov 2000 06:25:54 -0500
Subject: Re: sorted - was: How to add a drive to DMA black list?
To: andre@linux-ide.org (Andre Hedrick)
Date: Fri, 17 Nov 2000 10:55:23 +0000 (GMT)
Cc: aia21@cam.ac.uk (Anton Altaparmakov), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011161725300.6910-100000@master.linux-ide.org> from "Andre Hedrick" at Nov 16, 2000 05:26:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wjAz-0000Uy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then I need to fix that to prevent the bypass that should not happen.

No you need to fix the PIIX tuning hangs people keep reporting 8)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
