Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVLMIlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVLMIlO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbVLMIlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:41:14 -0500
Received: from styx.suse.cz ([82.119.242.94]:2769 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964775AbVLMIlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:41:13 -0500
Date: Tue, 13 Dec 2005 09:41:11 +0100
From: Vojtech Pavlik <vojtech@ucw.cz>
To: torvalds@osdl.org, akpm@osdl.org, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
Subject: [patch] Giving the reins over to Dmitry
Message-ID: <20051213084111.GA20748@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I haven't been very actively maintaining the input layer in past months,
mostly because of my lack of time to concentrate on that. For that
reason, I've decided to pass the maintainership of the Linux Input Layer
to Dmitry Torokhov, whom I trust to do the job very well.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

--- dmitry.orig/MAINTAINERS	2005-11-23 16:20:20.000000000 +0100
+++ dmitry/MAINTAINERS	2005-12-13 09:39:43.000000000 +0100
@@ -1275,8 +1275,8 @@
 S:	Supported
 
 INPUT (KEYBOARD, MOUSE, JOYSTICK) DRIVERS
-P:	Vojtech Pavlik
-M:	vojtech@suse.cz
+P:	Dmitry Torokhov
+M:	dtor_core@ameritech.net
 L:	linux-input@atrey.karlin.mff.cuni.cz
 L:	linux-joystick@atrey.karlin.mff.cuni.cz
 S:	Maintained

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
