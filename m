Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTFJDde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 23:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTFJDdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 23:33:33 -0400
Received: from web40011.mail.yahoo.com ([66.218.78.29]:43604 "HELO
	web40011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262263AbTFJDdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 23:33:33 -0400
Message-ID: <20030610034713.45207.qmail@web40011.mail.yahoo.com>
Date: Mon, 9 Jun 2003 20:47:13 -0700 (PDT)
From: Jeff Smith <whydoubt@yahoo.com>
Subject: [PATCH][2.5.70] ALSA help text correction
To: linux-kernel@vger.kernel.org, perex@suse.cz
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct help text to match available states.
 -- Jeff Smith

========================================================================
--- a/sound/core/Kconfig	Mon May 26 20:00:44 2003
+++ b/sound/core/Kconfig	Mon Jun  9 15:17:14 2003
@@ -41,7 +41,7 @@
 	bool "OSS Sequencer API"
 	depends on SND_OSSEMUL && SND_SEQUENCER
 	help
-	  Say 'Y' or 'M' to enable OSS sequencer emulation (both /dev/sequencer and
+	  Say 'Y' to enable OSS sequencer emulation (both /dev/sequencer and
 	  /dev/music interfaces).

 config SND_RTCTIMER


__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
