Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130067AbRAATnK>; Mon, 1 Jan 2001 14:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130231AbRAATnA>; Mon, 1 Jan 2001 14:43:00 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31247 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130067AbRAATmu>; Mon, 1 Jan 2001 14:42:50 -0500
Subject: Re: Chipsets, DVD-RAM, and timeouts....
To: andre@linux-ide.org (Andre Hedrick)
Date: Mon, 1 Jan 2001 19:13:28 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101011055260.22396-100000@master.linux-ide.org> from "Andre Hedrick" at Jan 01, 2001 11:06:08 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14DAOg-0001Ce-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > as it apparently makes CONFIG_IDEDMA_IVB a complete no-op?
> 
> Exactly what it is designed to do, Ignore Validity Bits, because the whole
> damn messedup the rules between ATA-4 and ATA-6

I think the question is more - so why not lose the ifdef
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
