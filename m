Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266035AbRGGGEF>; Sat, 7 Jul 2001 02:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266040AbRGGGDq>; Sat, 7 Jul 2001 02:03:46 -0400
Received: from smarty.smart.net ([207.176.80.102]:38410 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S266035AbRGGGD2>;
	Sat, 7 Jul 2001 02:03:28 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200107070616.CAA03340@smarty.smart.net>
Subject: Re: Why Plan 9 C compilers don't have asm("")
To: linux-kernel@vger.kernel.org
Date: Sat, 7 Jul 2001 02:16:41 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I replied to davem at length but I think I forgot to "reply to all
recipients". The gist of it is Forth code density is so high on Forth
hardware that things like icaches aren't as important, and the factors
involved are entirely different. Like high-performance Forth engines
are tiny and draw negligible current. Two URL's...

	http://forth.gsfc.nasa.gov/
	http://www.mindspring.com/chipchuck/forth.html

Rick Hohensee
		www.clienux.com
