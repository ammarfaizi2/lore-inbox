Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVGYF70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVGYF70 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 01:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVGYF5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:57:49 -0400
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:43873 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261661AbVGYFzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:55:43 -0400
Message-Id: <20050725054533.170123000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:08 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 19/24] elo - fix help in Kconfig
Content-Disposition: inline; filename=elo-fix-name-in-help.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Prokop <mika@grml.org>

Input: elo - fix help in Kconfig (wrong module name)

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/touchscreen/Kconfig
===================================================================
--- work.orig/drivers/input/touchscreen/Kconfig
+++ work/drivers/input/touchscreen/Kconfig
@@ -58,7 +58,7 @@ config TOUCHSCREEN_ELO
 	  If unsure, say N.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called gunze.
+	  module will be called elo.
 
 config TOUCHSCREEN_MTOUCH
 	tristate "MicroTouch serial touchscreens"

