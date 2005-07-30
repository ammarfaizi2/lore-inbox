Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVG3NEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVG3NEN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 09:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVG3NEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 09:04:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30629 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261193AbVG3NEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 09:04:12 -0400
Date: Sat, 30 Jul 2005 15:04:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>,
       rmk@arm.linux.org.uk
Subject: -rc4: arm broken?
Message-ID: <20050730130406.GA4285@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I merged -rc4 into my zaurus tree, and now zaurus will not boot. I see
oops-like display, and it seems to be __call_usermodehelper /
do_execve / load_script related. Anyone seen it before?

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
