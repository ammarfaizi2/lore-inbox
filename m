Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264102AbTE0SW4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTE0SWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:22:55 -0400
Received: from h2.prohosting.com.ua ([217.106.231.81]:5580 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S264099AbTE0SWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:22:35 -0400
From: Artemio <artemio@artemio.net>
To: linux-kernel@vger.kernel.org
Subject: HELP: No framebuffer option in config
Date: Tue, 27 May 2003 21:30:50 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305272130.50993.artemio@artemio.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have a clean 2.4.20 kernel.

I run "make menuconfig" but I can't see the "Frame-buffer support" section in 
"Console drivers" menu.

I can only compile the kernel without famebuffer support.It runs okay in text 
mode, but you know why FB support is needed.

Yes, I copied all the sources from tarball. Tried several times.

I tried to insert the lines from a standard config that add framebuffer 
support, but "make bzImage" returned an error at framebuffer font support.

Where did the frame-buffer section go?

What should I do to bring it back into config menu?



Thanks for any advise.

Artemio.
