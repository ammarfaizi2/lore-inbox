Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265761AbUFDITb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265761AbUFDITb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 04:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbUFDITb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 04:19:31 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:23465 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S265761AbUFDIT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 04:19:28 -0400
Date: Fri, 4 Jun 2004 10:19:26 +0200
From: Jasper Spaans <jasper@vs19.net>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: how to fix timestamps in bk repo?
Message-ID: <20040604081926.GA24427@spaans.vs19.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Copyright: Copyright 2004 Jasper Spaans, unauthorised distribution prohibited
User-Agent: Mutt/1.5.6i
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: spaans@spaans.vs19.net
X-SA-Exim-Scanned: No (on spaans.vs19.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

Is it possible to reset the (BK-)timestamps on the following files in the
http://linus.bkbits.net:8080/linux-2.5 repository? Somehow, they've gotten a
timestamp which lies in the future, causing lots of warnings when I use a bk
exported tree.

./drivers/base/class.c
./drivers/pci/hotplug/rpaphp_pci.c
./drivers/pci/hotplug/rpaphp_slot.c
./drivers/pci/hotplug/rpaphp_vio.c
./include/linux/kobject.h
./lib/kobject.c

Regards,
-- 
Jasper Spaans                                       http://jsp.vs19.net/
 10:06:49 up 9970 days, 53 min, 0 users, load average: 6.76 6.14 5.69
  -... .- -.. --. . .-. -... .- -.. --. . .-. -... .- -.. --. . .-.
