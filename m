Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268664AbUGXPBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268664AbUGXPBT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 11:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268663AbUGXPBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 11:01:19 -0400
Received: from quechua.inka.de ([193.197.184.2]:51908 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S268662AbUGXPBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 11:01:13 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: [PATCH] Delete cryptoloop
Date: Sat, 24 Jul 2004 17:11:54 +0200
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2004.07.24.15.11.53.260222@dungeon.inka.de>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <20040721230044.20fdc5ec.akpm@osdl.org> <4411.24.6.231.172.1090470409.squirrel@24.6.231.172> <20040722014649.309bc26f.akpm@osdl.org> <4546.24.6.231.172.1090476838.squirrel@24.6.231.172> <20040722113625.GA386@lain.chroot.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'ma happy user of dm-crypt since march, too.
No problems here.

However I wonder: can people switch to a 2.4.*
kernel if they are using dm-crypt? Even if the
disk format is compatible, the software used
to setup the decrypted access is different.
I guess for / partitions people need to use
loop-crypt, if they want to use 2.4.* and 2.6.*
kernels?

Andreas

