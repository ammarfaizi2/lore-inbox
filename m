Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWCUQiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWCUQiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWCUQfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:35:41 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28940 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932432AbWCUQVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:12 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 24/46] kbuild: Add copyright to modpost.c
In-Reply-To: <1142958055509-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:56 +0100
Message-Id: <11429580561641-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems popular to protect your work with copyright, so I decided to do
so for modpost which I patch a great deal atm.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/modpost.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

382168f4791822de7d44d9c634fbfdf8bc08c91b
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7f25354..de0a9ee 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2,7 +2,7 @@
  *
  * Copyright 2003       Kai Germaschewski
  * Copyright 2002-2004  Rusty Russell, IBM Corporation
- *
+ * Copyright 2006       Sam Ravnborg
  * Based in part on module-init-tools/depmod.c,file2alias
  *
  * This software may be used and distributed according to the terms
-- 
1.0.GIT


