Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTEETq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbTEETq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:46:59 -0400
Received: from p508EE977.dip.t-dialin.net ([80.142.233.119]:20400 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id S261267AbTEETq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:46:58 -0400
Date: Mon, 5 May 2003 21:59:27 +0200
From: Patrick Mau <mau@oscar.ping.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.69, DRI, Radeon 8500 AGP working for me
Message-ID: <20030505195927.GA28347@oscar.ping.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thnks, Linus

The current BK 2.5 tree fixes all my DRI and AGP related problems.
I did stress it very hard running various screensavers and quake 3,
so far everything is all right.

I'm currently using XFree from CVS:

XFree86 Version 4.3.99.3
Release Date: 29 April 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.4.20 i686 [ELF]
Build Date: 01 May 2003

"Page Flipping" and "AGP Fast Write" are enabled,
AGP speed is set to "1" (the default ?).

Thanks a lot,
Patrick
