Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130315AbRBLKFl>; Mon, 12 Feb 2001 05:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130047AbRBLKFb>; Mon, 12 Feb 2001 05:05:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6417 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130315AbRBLKFX>; Mon, 12 Feb 2001 05:05:23 -0500
Subject: Re: Hang on MO 1k HW-Blocksize
To: Reichelt@gbf.de (Joachim Reichelt)
Date: Mon, 12 Feb 2001 10:06:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A87A951.8040205@gbf.de> from "Joachim Reichelt" at Feb 12, 2001 10:13:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SFs4-0006Zj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All is fine on any 2.2 kernal
> All is locked writing to the MO using 2.4.0 or 2.4.1
> 
> What can i do to get a working system with 2.4.x and/or
> to catch the bug.

Known problem, known cause, waiting for the scsi folks or the fat fs folks to
fix one or other of the two pieces of code. Until then the simple answer is
dont run 2.4 if you have M/O drives

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
