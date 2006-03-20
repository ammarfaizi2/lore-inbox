Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965283AbWCTPXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbWCTPXT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965278AbWCTPXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:23:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55010 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964983AbWCTPWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:22:42 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 084/141] V4L/DVB (3336): Bt8xx documentation authors fix
Date: Mon, 20 Mar 2006 12:08:51 -0300
Message-id: <20060320150851.PS045649000084@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1141009666 -0300

- use one Author per line, which allows us to add more
  authors later without creating a mess.
- Add Michael Krufky due to -git commit
	2cbeddc976645262dbe036d6ec0825f96af70da3

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/dvb/bt8xx.txt b/Documentation/dvb/bt8xx.txt
diff --git a/Documentation/dvb/bt8xx.txt b/Documentation/dvb/bt8xx.txt
index df6c054..52ed462 100644
--- a/Documentation/dvb/bt8xx.txt
+++ b/Documentation/dvb/bt8xx.txt
@@ -111,4 +111,8 @@ source:  linux/Documentation/video4linux
 If you have problems with this please do ask on the mailing list.
 
 --
-Authors: Richard Walker, Jamie Honan, Michael Hunold, Manu Abraham
+Authors: Richard Walker,
+	 Jamie Honan,
+	 Michael Hunold,
+	 Manu Abraham,
+	 Michael Krufky

