Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbUBOWat (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 17:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUBOWat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 17:30:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:57502 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265246AbUBOWal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 17:30:41 -0500
Subject: Re: Linux 2.6.3-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: earny@net4u.de
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Peter Osterlund <petero2@telia.com>
In-Reply-To: <200402152252.17301.earny@net4u.de>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	 <200402152052.50596.earny@net4u.de> <m28yj42jcm.fsf@p4.localdomain>
	 <200402152252.17301.earny@net4u.de>
Content-Type: text/plain
Message-Id: <1076884158.6959.105.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 09:29:19 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch does not help, the console is still blank. The monitor shows:
> 
> H. Freq 63.98 kHz
> V. Freq 60.00 HZ
> Pixel Clock 107.98 Mhz
> Resolution 1280x1024
> Belinea101705
> 
> .. but with a black screen...

Can you compare the above informations with a working setup ? Also,
please send me the full dmesg log. Your problem is probably different
than the laptop one.

Did it work with the older driver at all ?

Ben.


