Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWJNMJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWJNMJI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWJNMIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:08:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22695 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932203AbWJNMIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:08:20 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Uwe Bugla <uwe.bugla@gmx.de>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 06/18] V4L/DVB (4732): Fix spelling error in Kconfig help
	text for DVB_CORE_ATTACH
Date: Sat, 14 Oct 2006 09:00:50 -0300
Message-id: <20061014120050.PS56934600006@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Uwe Bugla <uwe.bugla@gmx.de>

Signed-off-by: Uwe Bugla <uwe.bugla@gmx.de>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-core/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/dvb-core/Kconfig b/drivers/media/dvb/dvb-core/Kconfig
index e46eae3..1990eda 100644
--- a/drivers/media/dvb/dvb-core/Kconfig
+++ b/drivers/media/dvb/dvb-core/Kconfig
@@ -19,6 +19,6 @@ config DVB_CORE_ATTACH
 	  allow the card drivers to only load the frontend modules
 	  they require. This saves several KBytes of memory.
 
-	  Note: You will need moudule-init-tools v3.2 or later for this feature.
+	  Note: You will need module-init-tools v3.2 or later for this feature.
 
 	  If unsure say Y.

