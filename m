Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUFGMOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUFGMOd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264628AbUFGMOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:14:04 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:13953 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264629AbUFGL4c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:32 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093542390@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1086609354396@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 28/39] input: Power - add MODULE_LICENSE
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.8, 2004-05-10 01:32:39-05:00, dtor_core@ameritech.net
  Input: power - add MODULE_LICENSE


 power.c |    1 +
 1 files changed, 1 insertion(+)

===================================================================

diff -Nru a/drivers/input/power.c b/drivers/input/power.c
--- a/drivers/input/power.c	2004-06-07 13:11:18 +02:00
+++ b/drivers/input/power.c	2004-06-07 13:11:18 +02:00
@@ -172,3 +172,4 @@
 
 MODULE_AUTHOR("James Simmons <jsimmons@transvirtual.com>");
 MODULE_DESCRIPTION("Input Power Management driver");
+MODULE_LICENSE("GPL");

