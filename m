Return-Path: <linux-kernel-owner+w=401wt.eu-S1751165AbXAPN5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbXAPN5l (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 08:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbXAPN5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 08:57:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37594 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751165AbXAPN5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 08:57:40 -0500
Date: Tue, 16 Jan 2007 14:57:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>,
       dtor@mail.ru
Subject: 2.6.20-rc5: usb mouse breaks suspend to ram
Message-ID: <20070116135727.GA2831@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I started using el-cheapo usb mouse... only to find out that it breaks
suspend to RAM. Suspend-to-disk works okay. I was not able to extract
any usefull messages... 

Resume process hangs; I can still switch console and even type on
keyboard, but userland is dead, and I was not able to get magic sysrq
to respond.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
