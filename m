Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTIPBS1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 21:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbTIPBS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 21:18:27 -0400
Received: from web41806.mail.yahoo.com ([66.218.93.140]:48480 "HELO
	web41806.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261724AbTIPBS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 21:18:26 -0400
Message-ID: <20030916011825.98277.qmail@web41806.mail.yahoo.com>
Date: Mon, 15 Sep 2003 18:18:25 -0700 (PDT)
From: M M <mokomull@yahoo.com>
Subject: Kernel 2.6.0-test5 Refuses to Boot (ceases after "mice: PS/2 mouse device common for all mice")
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've downloaded, configured (make oldconfig using
.config from 2.4.21), and compiled kernel 2.6.0-test5,
but it just refuses to boot completely.

It prints:
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice

and just stops booting.

Which configuration option(s) did I miss?

-MrM

P.S.  Thanks in advance!

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
