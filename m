Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317444AbSHHLE0>; Thu, 8 Aug 2002 07:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSHHLE0>; Thu, 8 Aug 2002 07:04:26 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:41220 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S317444AbSHHLEZ>;
	Thu, 8 Aug 2002 07:04:25 -0400
Date: Thu, 8 Aug 2002 07:08:04 -0400
From: Rob Radez <rob@osinvestor.com>
To: linux-kernel@vger.kernel.org
Cc: watchdogng@lists.tummy.com
Subject: Watchdog Updates
Message-ID: <20020808070804.F1625@osinvestor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

I've updated my big watchdog patch to 2.4.20-pre1.  New changes include:
adding error handling to initialization,
fixing pci_enable_device calls,
adding in the C99 struct initializers,
remove the entry in MAINTAINERS for the pcwd driver.

I've stopped tracking the 2.4-ac tree because I'm planning to start adding in
Configure.help, Config.in, and Makefile changes, as well as hopefully starting
to track 2.5 (or 2.5-dj, one or the other).

Patch is up at http://osinvestor.com/wd/wd-2.4.20-pre1-1.diff

Regards,
Rob Radez
