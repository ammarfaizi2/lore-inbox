Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAYBSK>; Wed, 24 Jan 2001 20:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAYBSB>; Wed, 24 Jan 2001 20:18:01 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48658 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129401AbRAYBRu>; Wed, 24 Jan 2001 20:17:50 -0500
Subject: Re: kernel BUG at slab.c:1542!(2.4.1-pre9)
To: andrewm@uow.edu.au (Andrew Morton)
Date: Thu, 25 Jan 2001 01:18:36 +0000 (GMT)
Cc: phillips@innominate.de (Daniel Phillips),
        greg@linuxpower.cx (Gregory Maxwell), linux-kernel@vger.kernel.org
In-Reply-To: <3A6EF8AC.DFC50D37@uow.edu.au> from "Andrew Morton" at Jan 25, 2001 02:45:48 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Lb3f-0008A5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I sent the below patch to Linus earlier today.  I didn't copy
> any mailing list because it's a bit security-related.  Oh well.

Its been in -ac for  while but using a define since its a constant
so it not a secret 8)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
