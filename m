Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271122AbTG1XJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271147AbTG1XJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:09:25 -0400
Received: from smtp2.libero.it ([193.70.192.52]:33705 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S271122AbTG1XJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:09:22 -0400
Subject: [PATCH] LIRC drivers for 2.6.0-test2 (and earliers) - 3rd version
From: Flameeyes <dgp85@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1059433753.8366.14.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 29 Jul 2003 01:09:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can download it from here
http://flameeyes.web.ctonet.it/patch-2.6.0-test2-lirc.diff.bz2.
Sorry for not inlining it but it seens too big to be sent to lkml.

This version fixes problems using lirc_dev as a module (it needs to be
compiled in the kernel), merges the patch that Koos Vriezen sent to me
for homebrew receivers, the lirc's cvs fixes for lirc_serial, and add
the new atiusb driver (from lirc's cvs).
I'm trying to rejoin the i2c driver but it need more work.
I hope this patch will work for everyone.
-- 
Flameeyes <dgp85@users.sourceforge.net>

