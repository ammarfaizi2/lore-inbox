Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135841AbRAMAYj>; Fri, 12 Jan 2001 19:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135846AbRAMAYS>; Fri, 12 Jan 2001 19:24:18 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64773 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135841AbRAMAYO>; Fri, 12 Jan 2001 19:24:14 -0500
Subject: Re: ide.2.4.1-p3.01112001.patch
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 13 Jan 2001 00:25:28 +0000 (GMT)
Cc: vojtech@suse.cz (Vojtech Pavlik), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101121604080.8097-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 12, 2001 04:09:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14HEVf-0005K2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> what the bug is, and whether there is some other work-around, and whether
> it is 100% certain that it is just those two controllers (maybe the other
> ones are buggy too, but the 2.2.x tests basically cured their symptoms too
> and peopl ehaven't reported them because they are "fixed").

I've not seen reports on the later chips. If they had been buggy and then 
fixed I'd have expected much unhappy ranting before the change

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
