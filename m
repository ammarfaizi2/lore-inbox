Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUB1XIV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 18:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbUB1XIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 18:08:21 -0500
Received: from gprs146-251.eurotel.cz ([160.218.146.251]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261939AbUB1XIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 18:08:21 -0500
Date: Sun, 29 Feb 2004 00:00:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Dropping CONFIG_PM_DISK?
Message-ID: <20040228230039.GA246@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Would there be any major screaming if I tried to drop CONFIG_PM_DISK?
It seems noone is maintaining it, equivalent functionality is provided
by swsusp, and it is confusing users...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
