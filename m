Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUBIIYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 03:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbUBIIYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 03:24:00 -0500
Received: from outbound03.telus.net ([199.185.220.222]:45493 "EHLO
	priv-edtnes11-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id S263571AbUBIIX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 03:23:59 -0500
Subject: [patch] Re: psmouse.c, throwing 3 bytes away
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076315101.5070.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 09 Feb 2004 01:25:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I rebuilt with your patch and ran while running Fedora Prelink
(actually Fedora was running that on its own) and an FPS (graphics and
mouse intensive).  Did not have any problems even though system load was
over 200%.  Thanks for the good work!  

Bob

