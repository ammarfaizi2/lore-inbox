Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbTAEPy7>; Sun, 5 Jan 2003 10:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbTAEPy7>; Sun, 5 Jan 2003 10:54:59 -0500
Received: from boo-mda02.boo.net ([216.200.67.22]:27909 "EHLO
	boo-mda02.boo.net") by vger.kernel.org with ESMTP
	id <S264857AbTAEPy7>; Sun, 5 Jan 2003 10:54:59 -0500
Message-Id: <200301051603.LAA18650@boo-mda02.boo.net>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: jasonp@boo.net
Subject: Re: [PATCH] rewritten page coloring for 2.4.20 kernel
Date: Sun, 5 Jan 2003 16:03:33 GMT
X-Mailer: Endymion MailMan Standard Edition v3.0.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This is an early attempt to get some feedback on mistakes I may have made.
> 
> Any chance for a 2.5.x-mm port? This is a bit feature-ish for 2.4.x.

I know. The problem is that 2.5.53 cannot finish booting on the Alpha I have
here (IDE issues). While I can port the patch over, I'm not comfortable being
unable to test it at all.

jasonp

---------------------------------------------
This message was sent using Endymion MailMan.
http://www.endymion.com/products/mailman/


