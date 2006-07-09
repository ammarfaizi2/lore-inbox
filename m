Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161209AbWGIWwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbWGIWwe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWGIWwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:52:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18109 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932459AbWGIWwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:52:33 -0400
Date: Mon, 10 Jul 2006 00:52:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Cc: kristen.c.accardi@intel.com
Subject: 2.6.18-rc1-mm1 on thinkpad x32
Message-ID: <20060709225208.GA1787@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

* acpi problems are gone, good -- it now boots with acpi=off and boots
with enabled pci hotplugging.

	(that uncovered other problem where machine dies if I try to
	undock it... This has worked before. I'll report it properly.)

* pcmcia ide now works, good.

* swsusp still works, thanks for speedup!
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
