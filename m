Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263614AbUE3NOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUE3NOs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 09:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263641AbUE3NOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 09:14:47 -0400
Received: from aun.it.uu.se ([130.238.12.36]:36810 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263614AbUE3NOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 09:14:47 -0400
Date: Sun, 30 May 2004 15:14:33 +0200 (MEST)
Message-Id: <200405301314.i4UDEXW8005730@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: evil@g-house.de, linux-kernel@vger.kernel.org
Subject: Re: unable to compile 2.4 with gcc-3.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2004 12:49:51 +0200, Christian Kujau wrote:
>reading the thread "Recommended compiler version" i don't know if it
>states wether this is a known issue or not, so here, and for the record:
>
>i'm unable to compile a recent 2.4 kernel (BK) with gcc-3.4.0.

This has been discussed on LKML recently. Get
http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-2.4.27-pre3
and try again.
