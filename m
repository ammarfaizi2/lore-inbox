Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265962AbUGMV25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265962AbUGMV25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266042AbUGMV24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:28:56 -0400
Received: from gprs214-150.eurotel.cz ([160.218.214.150]:9088 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265962AbUGMV2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:28:14 -0400
Date: Tue, 13 Jul 2004 23:27:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: radeonfb badly broken on amd64 in 2.6.8-rc1
Message-ID: <20040713212757.GA730@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I do not know if it is new breakage or if it was broken before...

If I compile kernel for 32-bit, radeon is okay. If I compile it for
64-bit, I get very interesting effects. I never thought LCD can
flicker like this...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
