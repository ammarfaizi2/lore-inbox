Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290470AbSBFMKT>; Wed, 6 Feb 2002 07:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290454AbSBFMKJ>; Wed, 6 Feb 2002 07:10:09 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:32012 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290461AbSBFMJv>;
	Wed, 6 Feb 2002 07:09:51 -0500
Date: Tue, 5 Feb 2002 22:45:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Trivial typo fix in Documentation
Message-ID: <20020205214539.GA14952@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This needs to go at least to 2.5.3...

--- clean/Documentation/SubmittingDrivers	Mon Aug 27 17:59:16 2001
+++ linux/Documentation/SubmittingDrivers	Thu Oct 25 13:26:15 2001
@@ -3,7 +3,7 @@
 
 This document is intended to explain how to submit device drivers to the
 Linux 2.2 and 2.4 kernel trees. Note that if you are interested in video
-card drivers you should probably talk to XFree86 (http://wwww.xfree86.org) 
+card drivers you should probably talk to XFree86 (http://www.xfree86.org) 
 instead.
 
 Also read the Documentation/SubmittingPatches document.

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
