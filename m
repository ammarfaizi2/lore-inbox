Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131675AbRAKVeN>; Thu, 11 Jan 2001 16:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132957AbRAKVdx>; Thu, 11 Jan 2001 16:33:53 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23309 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131675AbRAKVdu>; Thu, 11 Jan 2001 16:33:50 -0500
Subject: Re: Strange umount problem in latest 2.4.0 kernels
To: sorisor@Hell.WH8.TU-Dresden.De (Udo A. Steinberg)
Date: Thu, 11 Jan 2001 21:34:56 +0000 (GMT)
Cc: viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <3A5E1E0D.B420A045@Hell.WH8.TU-Dresden.De> from "Udo A. Steinberg" at Jan 11, 2001 09:56:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GpN5-000369-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've checked a couple of other machines, different setups etc.
> all with -ac6 and all show this behavior - also the umount stuff.

Wait for -ac7 and see if that fixes it. I think I know whats up there

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
