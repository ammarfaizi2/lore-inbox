Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbTH3SR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 14:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbTH3SR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 14:17:28 -0400
Received: from imap.gmx.net ([213.165.64.20]:12681 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262112AbTH3SR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 14:17:28 -0400
Date: Sat, 30 Aug 2003 20:16:54 +0200
From: Sebastian Reichelt <SebastianR@gmx.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIA VT8231 router detection
Message-Id: <20030830201654.403f1421.SebastianR@gmx.de>
In-Reply-To: <3F50E0E6.2040907@pobox.com>
References: <20030830151112.550df1a6.Sebastian@tigcc.ticalc.org>
	<3F50E0E6.2040907@pobox.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, Mr. Newbie, your patch looks fine to me :)

Good :-)
I did forget one thing, though: It's the file pci-irq.c in
arch/i386/kernel. Well, there are only three files with this name in
2.4, but I just thought I'd mention it. ;-)

> I'll test it out locally, and make sure it gets into 2.4 and 2.6, if 
> nobody beats me to it.

That's cool! Thank you so much for spending your time on things like
these!

-- 
Sebastian Reichelt
