Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130102AbRBZBaI>; Sun, 25 Feb 2001 20:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbRBZB37>; Sun, 25 Feb 2001 20:29:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12036 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130102AbRBZB3m>; Sun, 25 Feb 2001 20:29:42 -0500
Subject: Re: 64GB option broken in 2.4.2
To: rico@patrec.com (Rico Tudor)
Date: Mon, 26 Feb 2001 01:32:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010226012112.9698.qmail@pc7.prs.nunet.net> from "Rico Tudor" at Feb 26, 2001 01:21:12 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XCWa-0000Hc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hypothesis:
> 	Code to handle PAE has buggy spinlock management.

Hypthesis#2 The bounce buffer code in the Linus tree is known to be
imperfect. Does 2.4.2ac3 do the same ?

Alan

