Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130446AbRCWJsa>; Fri, 23 Mar 2001 04:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130448AbRCWJsU>; Fri, 23 Mar 2001 04:48:20 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43788 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130446AbRCWJsL>; Fri, 23 Mar 2001 04:48:11 -0500
Subject: Re: Linux 2.4.2ac22
To: mojomofo@mojomofo.com (Aaron Tiensivu)
Date: Fri, 23 Mar 2001 09:50:25 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <00a701c0b344$a3a87c50$0600a8c0@wmis.net> from "Aaron Tiensivu" at Mar 22, 2001 09:54:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gODD-0004MR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > o Fix ppp memory corruption (Kevin Buhr)
> > | Bizzarely enough a direct re-invention of a 1.2 ppp bug
> 
> Could this explain my MPPP skb corruption I've reported since 2.3.x?

At most it explains some weird corruption cases with small kernel blocks.
I really doubt they are related

