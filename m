Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUEJIIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUEJIIw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 04:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUEJIIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 04:08:52 -0400
Received: from port-213-148-152-119.reverse.qsc.de ([213.148.152.119]:20560
	"EHLO mbs-software.de") by vger.kernel.org with ESMTP
	id S264550AbUEJIIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 04:08:48 -0400
Date: Mon, 10 May 2004 10:08:44 +0200
From: Alex Riesen <fork0@users.sf.net>
To: Len Brown <len.brown@intel.com>
Cc: Bob Gill <gillb4@telusplanet.net>,
       Alex Riesen <fork0@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hdc: lost interrupt ide-cd: cmd 0x3 timed out ...
Message-ID: <20040510080844.GA4693@linux-ari.internal>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <A6974D8E5F98D511BB910002A50A6647615FAE21@hdsmsx403.hd.intel.com> <1084071367.2326.62.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084071367.2326.62.camel@dhcppc4>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown, Sun, May 09, 2004 04:56:07 +0200:
> I need some info to find out why your system recently broke.
...
> ps. would also be good to verify you're running an up-to-date BIOS.

I think I am.

> pps. taking a wild guess, can you try backing out this patch?

cannot be it. There is a message before the changed line (a warning
regarding no irq), which is never seen in the logs.

