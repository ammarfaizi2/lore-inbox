Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270824AbRHNUpY>; Tue, 14 Aug 2001 16:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270826AbRHNUpN>; Tue, 14 Aug 2001 16:45:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12805 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270824AbRHNUpG>; Tue, 14 Aug 2001 16:45:06 -0400
Subject: Re: Are we going too fast?
To: anders@alarsen.net (Anders Larsen)
Date: Tue, 14 Aug 2001 21:47:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pf-kernel1@mirkwood.net (PinkFreud),
        linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Anders Larsen" at Aug 14, 2001 10:29:18 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Wl5b-0001vV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mike didn't mention any details of the hardware where he's experiencing this
> bug, but is it possibly a multiprocessor machine?
> Since I only have UP's to test on, the qnxfs might have SMP issues.
> 
> Could someone please glance through the code in fs/qnx4 to check if there
> are any obvious problems?

If I get time tomorrow I'll test the qnxfs code on a dual PPro
