Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263092AbRE1QW6>; Mon, 28 May 2001 12:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263091AbRE1QWs>; Mon, 28 May 2001 12:22:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6931 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263089AbRE1QWi>; Mon, 28 May 2001 12:22:38 -0400
Subject: Re: Linux 2.4.5-ac2
To: tim.leeuwvander@nl.unisys.com (Leeuw van der, Tim)
Date: Mon, 28 May 2001 17:20:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <DD0DC14935B1D211981A00105A1B28DB033ED2F0@NL-ASD-EXCH-1> from "Leeuw van der, Tim" at May 28, 2001 10:19:01 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154Pkp-0003HS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the claim was that 2.4.5-ac2 is faster than 2.4.5 plain, so which
> changes are in 2.4.5-ac2 that would make it faster than 2.4.5 plain? Also, I
> don't know if 2.4.5-ac1 is as fast as 2.4.5-ac2 for Fabio. If not, then it's
> a change in the 2.4.5-ac2 changelog. If it is as fast, it is one of the
> changes in the 2.4.5-ac1 changelog.

ac1 to ac2 backs out some of the bits of old VM cruft. ac2 doesnt really add
much that is VM relevant but it might be the user has a VIA chipset box in
which case -ac will be faster for other reasons
