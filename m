Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284652AbRLUPlC>; Fri, 21 Dec 2001 10:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284644AbRLUPkw>; Fri, 21 Dec 2001 10:40:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27154 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284638AbRLUPko>; Fri, 21 Dec 2001 10:40:44 -0500
Subject: Re: @Linus, Marcello, (Alan?) (regards sisfb)
To: tw@webit.com (Thomas Winischhofer)
Date: Fri, 21 Dec 2001 15:50:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C2349C8.1DF70E5F@falke.mail> from "Thomas Winischhofer" at Dec 21, 2001 03:40:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HRwE-0000X8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, the whole theory with this driver is a failure.

Its the same driver core XFree86 uses.  Also if you are not looking at a 
currentish 2.4 or 2.5 you'll have the wrong code.

> Are you willing to include the new driver in the kernel?
> It's available here: http://members.aon.at/~twinisch/sisfb.tar.gz

If your timings are wrong you may destroy the LCD panel. 
