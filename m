Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWCAO7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWCAO7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWCAO7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:59:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23716 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932372AbWCAO7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:59:08 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 01/13] Bt8xx documentation authors fix
Date: Wed, 01 Mar 2006 09:05:37 -0300
Message-id: <20060301120536.PS84404300001@infradead.org>
In-Reply-To: <20060301120529.PS80375900000@infradead.org>
References: <20060301120529.PS80375900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1141009666 \-0300

- use one Author per line, which allows us to add more
  authors later without creating a mess.
- Add Michael Krufky due to -git commit
	2cbeddc976645262dbe036d6ec0825f96af70da3

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 Documentation/dvb/bt8xx.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

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

