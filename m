Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129146AbRBELqM>; Mon, 5 Feb 2001 06:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131282AbRBELqC>; Mon, 5 Feb 2001 06:46:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39698 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129146AbRBELpx>; Mon, 5 Feb 2001 06:45:53 -0500
Subject: Re: Motherboard Misdetect
To: denali@sunflower.com (Steve 'Denali' McKnelly)
Date: Mon, 5 Feb 2001 11:46:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <PGEDKPCOHCLFJBPJPLNMAEHPCBAA.denali@sunflower.com> from "Steve 'Denali' McKnelly" at Feb 04, 2001 04:24:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Pk6B-00039b-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I own a M-Technology M-668DS motherboard.  Linux 2.4.1
> 	identifies my board as a Soyo SY-6KD.  They're not really
> 	the same board, and they each have features the other doesn't

We read the data from the BIOS. Its actually only scanned to match against
known system bugs so won't be a problem. It sounds like they are using the
same bios image on a set of boards and didnt bother to fix the name.

It may well also be they are the same board minus a few components.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
