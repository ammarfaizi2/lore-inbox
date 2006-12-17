Return-Path: <linux-kernel-owner+w=401wt.eu-S932349AbWLQTB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWLQTB1 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 14:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWLQTB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 14:01:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:29158 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349AbWLQTB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 14:01:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:subject:mime-version:content-type:content-transfer-encoding;
        b=EBRP8ZnMewltcrFHrF5x3zCFtzxTUOwgseTZMcrSt42F3hFO9oBIAigdgoijYJYyJxdvB+tSqpJ+VBxqgrB4oNsMWupIAuGHiLDn4YuWGSvh7YAJSKITS39KWesedCxNB4lCzENXx2uW0bB2tKP4Ch/SW1D/frUdLUhT2DM8KLw=
Date: Sun, 17 Dec 2006 21:01:21 +0200
From: Paul Sokolovsky <pmiscml@gmail.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <3610410734.20061217210121@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Random typo in drivers/rtc/Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,


      Well, this was (at least) since 2.6.18, so I guess, someone
should finally submit it patch for it. And yes, kbuild parses that,
but that doesn't make it not typo, right?


--- drivers/rtc/Kconfig 2 Dec 2006 02:18:35 -0000       1.3
+++ drivers/rtc/Kconfig 17 Dec 2006 18:56:29 -0000
@@ -1,4 +1,4 @@
-\#
+#
 # RTC class/drivers configuration
 #
 


-- 
Best regards,
 Paul                          mailto:pmiscml@gmail.com

