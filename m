Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268102AbRG2SsV>; Sun, 29 Jul 2001 14:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268110AbRG2SsL>; Sun, 29 Jul 2001 14:48:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23818 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268102AbRG2Srv>; Sun, 29 Jul 2001 14:47:51 -0400
Subject: Re: PROBLEM: Random (hard) lockups
To: treacy@home.net (James A. Treacy)
Date: Sun, 29 Jul 2001 19:49:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010729143401.A527@debian.org> from "James A. Treacy" at Jul 29, 2001 02:34:01 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Qvct-0002Od-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> At random times this brand new machine locks up hard (so nothing to
> report from Sys Rq). This happens with all recent 2.4.x kernels, 2.2.17
> and 2.2.19. Some kernels seem to be worse than others as I can often work
> 
> As I'd like to make this my main machine, I am willing to put some
> time into tracking down the problem, but need pointers on where to
> begin.

Given you see the same behaviour in very stable 2.2 kernels, I'd say begin
at the hardware. 
