Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbQLTNlh>; Wed, 20 Dec 2000 08:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbQLTNl3>; Wed, 20 Dec 2000 08:41:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18184 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129811AbQLTNlV>; Wed, 20 Dec 2000 08:41:21 -0500
Subject: Re: [2.2.18] VM: do_try_to_free_pages failed
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Wed, 20 Dec 2000 13:13:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel mailing list)
In-Reply-To: <20001220130259.A9659@emma1.emma.line.org> from "Matthias Andree" at Dec 20, 2000 01:03:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E148j3b-0001WK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How can I get rid of those do_try_to_free_pages lockups? That box
> exports root file systems for some SparcStation 2 that are used as X
> terminals, so it's pretty important I keep that box running.
> 
> Should I try the most recent 2.2.19-pre?

2.2.19pre2 should resolve that problem


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
