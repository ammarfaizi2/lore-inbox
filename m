Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVATKmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVATKmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 05:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVATKmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 05:42:24 -0500
Received: from gprs215-87.eurotel.cz ([160.218.215.87]:21717 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262109AbVATKmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 05:42:22 -0500
Date: Thu, 20 Jan 2005 11:40:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Machine no longer enters C3 on 2.6.11-rc1-bk
Message-ID: <20050120104033.GA25889@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

bus master activity: is changing all the time, mostly 555555555 and
aaaaaaa, and cpu refuses to enter C3 for obvious reasons. I compiled
out USB and sound... Does anybody else see the same problem?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
