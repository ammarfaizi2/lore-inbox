Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTJCX3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbTJCX3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:29:07 -0400
Received: from [203.152.107.236] ([203.152.107.236]:53377 "HELO
	skieu.myftp.org") by vger.kernel.org with SMTP id S261473AbTJCX26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:28:58 -0400
Date: Sat, 4 Oct 2003 11:29:31 +0000 (UTC)
From: haiquy@yahoo.com
X-X-Sender: sk@darkstar.example.net
Reply-To: kieusnz@yahoo.co.nz
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6 with low mem box, too slow to start openoffice
Message-ID: <Pine.LNX.4.53.0310041127020.23814@darkstar.example.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Notice one problem probably it is due to the rrmap in VM, with 64Mb RAM
celeron 400Mhz openoffice 1.1 takes 1 minute and 55 second to start!

Compare with 2.4.23-pre5 it only takes 45 seconds!

But this problem doesn't happen with the box of 192Mb of RAM

Best regards,

Steve Kieu

Homepage http://scorpius.spaceports.com/~skieu/

PGP Key http://scorpius.spaceports.com/~skieu/steve-pub.key

