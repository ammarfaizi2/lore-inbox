Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276750AbRJBWfY>; Tue, 2 Oct 2001 18:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276751AbRJBWfO>; Tue, 2 Oct 2001 18:35:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56588 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276750AbRJBWe6>; Tue, 2 Oct 2001 18:34:58 -0400
Subject: Re: Huge console switching lags
To: jsimmons@transvirtual.com (James Simmons)
Date: Tue, 2 Oct 2001 23:39:36 +0100 (BST)
Cc: jfbeam@bluetopia.net (Ricky Beam), alan@lxorguk.ukuu.org.uk (Alan Cox),
        akpm@zip.com.au (Andrew Morton),
        lenstra@tiscalinet.it (Lorenzo Allegrucci),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10110021142230.14469-100000@transvirtual.com> from "James Simmons" at Oct 02, 2001 11:50:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oYCP-0006Cm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well the reason the framebuffer suck is because the current api sucks for
> them. It draws pixel by pixel. Slow slow slow!!! I have developed a new
> api that takes advantage of the accel engine of graphics hardware. It is

Great. VESAfb doesnt have one. Lots of older machines dont have one.

Alan
