Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVJBR5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVJBR5R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 13:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVJBR5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 13:57:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16770 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751148AbVJBR5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 13:57:17 -0400
Date: Sun, 2 Oct 2005 19:57:03 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: thinkpad suspend to ram and backlight
Message-ID: <20051002175703.GA3141@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When I suspend to RAM on x32, backlight is not turned off. (And, IIRC,
video chips is not turned off, too). Unfortunately, backlight is not
turned even when lid is closed. I know some patches were floating
around to solve that... but I can't find them now. Any ideas?
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
