Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131964AbQLVQuJ>; Fri, 22 Dec 2000 11:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132151AbQLVQt7>; Fri, 22 Dec 2000 11:49:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15379 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131964AbQLVQtx>; Fri, 22 Dec 2000 11:49:53 -0500
Subject: Re: Linux 2.2.19pre3
To: kaukasoi@elektroni.ee.tut.fi (Petri Kaukasoina)
Date: Fri, 22 Dec 2000 16:21:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001222173228.A1424@elektroni.ee.tut.fi> from "Petri Kaukasoina" at Dec 22, 2000 05:32:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E149Uwk-0004rU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > o	Optimise kernel compiler detect, kgcc before	(Peter Samuelson)
> > 	gcc272 also
> 
> kwhich doesn't seem to work ok with several arguments if sh is bash-1.14.7:

Yep. I shall just back this out
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
