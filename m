Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSFJTuW>; Mon, 10 Jun 2002 15:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315929AbSFJTuV>; Mon, 10 Jun 2002 15:50:21 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:128 "EHLO bilbo.tmr.com")
	by vger.kernel.org with ESMTP id <S315928AbSFJTuU>;
	Mon, 10 Jun 2002 15:50:20 -0400
Date: Mon, 10 Jun 2002 15:50:16 -0400 (EDT)
From: Bill Davidsen <root@tmr.com>
To: linux-kernel@vger.kernel.org
Subject: sc520cdp still NG as a module
Message-ID: <Pine.LNX.4.21.0206101547330.9624-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre10-ac2/kernel/drivers/mtd/maps/sc520cdp.o
depmod:         mtd_concat_destroy
depmod:         mtd_concat_create

AFAIK every pre{8,10}-ac kernel, haven't tried others.

This account is likely to bouce, pls. reply to the list if you feel the
need at all.

