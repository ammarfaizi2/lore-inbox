Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWDDMWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWDDMWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 08:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWDDMWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 08:22:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6878 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932356AbWDDMWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 08:22:23 -0400
Date: Tue, 4 Apr 2006 14:22:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: 2.6.17-rc1: collie -- oopsen in pccardd?
Message-ID: <20060404122212.GG19139@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm getting some oopses when inserting/removing pccard (on collie,
oopses in pccardd). It does not break boot, so it is not immediate
problem, but I wonder if it also happens on non-collie machines?
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
