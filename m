Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281703AbRK2TnG>; Thu, 29 Nov 2001 14:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282071AbRK2Tm4>; Thu, 29 Nov 2001 14:42:56 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1923 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S281703AbRK2Tmq>;
	Thu, 29 Nov 2001 14:42:46 -0500
Date: Wed, 28 Nov 2001 23:15:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: viro@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: 2.4.14 still not making fs dirty when it should
Message-ID: <20011128231504.A26510@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I still can mount / read/write, press reset, and not get fsck on next
reboot. That strongly suggests kernel bug to me.
								Pavel
-- 
<sig in construction>
