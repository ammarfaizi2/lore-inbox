Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135306AbREHUnL>; Tue, 8 May 2001 16:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135318AbREHUnB>; Tue, 8 May 2001 16:43:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28677 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135306AbREHUmv>; Tue, 8 May 2001 16:42:51 -0400
Subject: Re: your mail
To: root@chaos.analogic.com
Date: Tue, 8 May 2001 21:46:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <Pine.LNX.3.95.1010508154726.29540A-100000@chaos.analogic.com> from "Richard B. Johnson" at May 08, 2001 03:48:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xENe-0000aK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a driver which needs to wait for some hardware.
> Basically, it needs to have some code added to the run-queue
> so it can get some CPU time even though it's not being called.

Wht does it have to wait ? Why cant it just poll and come back next time ?
