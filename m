Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271726AbRHUPtC>; Tue, 21 Aug 2001 11:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271723AbRHUPsv>; Tue, 21 Aug 2001 11:48:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14867 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271727AbRHUPsi>; Tue, 21 Aug 2001 11:48:38 -0400
Subject: Re: BUG: pc_keyb.c
To: Andries.Brouwer@cwi.nl
Date: Tue, 21 Aug 2001 16:51:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Andries.Brouwer@cwi.nl" at Aug 21, 2001 03:45:39 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZDoa-00089S-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On the other hand, 1 ms is a very long time these days; it is a bit
> surprising that modern hardware should need delays in that order of

I have two boxes that need the 1mS delay, and I actually had to fix a 
missing one to deal with hangs. So its still there, lurking in some boxes
I've had ex Digital engineers confirm the hinote needs the 1mS delay a while
back

Alan
