Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWIQTlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWIQTlS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 15:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWIQTlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 15:41:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23692 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932373AbWIQTlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 15:41:18 -0400
Date: Sun, 17 Sep 2006 21:41:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 8 hours of battery life on thinkpad x60
Message-ID: <20060917194118.GA3477@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

I did a presentation about getting 8 hours of runtime out of common
notebooks. You can get it at
http://atrey.karlin.mff.cuni.cz/~pavel/swsusp/8hours.odp . Biggest
offenders are USB (being worked on) and SATA (controller eats 1W --
more than spinning disk, strange!).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
