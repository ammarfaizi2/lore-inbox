Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266553AbUHXBDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266553AbUHXBDo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 21:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUHWTYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:24:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:63171 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267184AbUHWSgn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:43 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860873079@kroah.com>
Date: Mon, 23 Aug 2004 11:34:47 -0700
Message-Id: <10932860874161@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.30, 2004/08/06 15:43:00-07:00, johnpol@2ka.mipt.ru

[PATCH] w1: Spelling fix.

Spelling fix.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/matrox_w1.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/w1/matrox_w1.c b/drivers/w1/matrox_w1.c
--- a/drivers/w1/matrox_w1.c	2004-08-23 11:03:46 -07:00
+++ b/drivers/w1/matrox_w1.c	2004-08-23 11:03:46 -07:00
@@ -94,7 +94,7 @@
 /*
  * These functions read and write DDC Data bit.
  *
- * Using tristate pins, since i can't  fin any open-drain pin in whole motherboard.
+ * Using tristate pins, since i can't find any open-drain pin in whole motherboard.
  * Unfortunately we can't connect to Intel's 82801xx IO controller
  * since we don't know motherboard schema, wich has pretty unused(may be not) GPIO.
  *

