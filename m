Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278290AbRJMNqL>; Sat, 13 Oct 2001 09:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278291AbRJMNqC>; Sat, 13 Oct 2001 09:46:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62212 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278290AbRJMNpp>; Sat, 13 Oct 2001 09:45:45 -0400
Subject: Re: 2.4.13-pre[12]: i2o does not compile
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Sat, 13 Oct 2001 14:51:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (list linux-kernel)
In-Reply-To: <3BC7F263.680E023F@eyal.emu.id.au> from "Eyal Lebedinsky" at Oct 13, 2001 05:50:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15sPCg-0002j5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A number of failure led me to deselect the subsystem. Something is
> very wrong in the i2o 2.4.13-pre patches so far.

I have some further diffs to send Linus for the i2o code. Its complicated by
the fact the Linus tree has i2o in drivers/i2o not drivers/message/i2o
