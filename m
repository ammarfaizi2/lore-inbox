Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268015AbUHPXGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268015AbUHPXGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268017AbUHPXDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:03:35 -0400
Received: from the-village.bc.nu ([81.2.110.252]:30693 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268015AbUHPXCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 19:02:50 -0400
Subject: Re: [PATCH] HPT374 kernel panic - regression in 2.6.8
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408170030.45553.bzolnier@elka.pw.edu.pl>
References: <411DF42E.5030504@kmlinux.fjfi.cvut.cz>
	 <1092496584.27144.3.camel@localhost.localdomain>
	 <200408170030.45553.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092693626.21067.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 23:00:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-16 at 23:30, Bartlomiej Zolnierkiewicz wrote:
> http://linus.bkbits.net:8080/linux-2.5/cset@40586b50zsHhQgPLGTlje7g_f5wGTw?nav=index.html|
> src/|src/drivers|src/drivers/ide|src/drivers/ide/pci|
> related/drivers/ide/pci/hpt366.c
> 
> please read bugzilla bugs mentioned in the changelong and fix this

Already did and sent out the patch. 2.4.x is missing that small change
so it might be a good one for Marcelo to merge ?

