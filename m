Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVB1XRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVB1XRf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 18:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVB1XRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 18:17:35 -0500
Received: from gprs215-65.eurotel.cz ([160.218.215.65]:51669 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261812AbVB1XRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 18:17:34 -0500
Date: Tue, 1 Mar 2005 00:17:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-ID: <20050228231721.GA1326@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In `subj` kernel, machine no longer powers down at the end of
swsusp. 2.6.11-rc5-pavel works ok, as does 2.6.11-bk.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
