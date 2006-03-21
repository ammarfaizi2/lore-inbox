Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWCUQhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWCUQhI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWCUQft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:35:49 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30732 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932426AbWCUQVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:11 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 16/46] kbuild: fix comment in Kbuild.include
In-Reply-To: <1142958055225-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <11429580552866-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noted by Olaf Hering <olh@suse.de>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/Kbuild.include |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

9d6e7a709cdb8f43d9a9ac5532b54a3e70415b9b
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 3e7e0b2..c3d2e4e 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -45,7 +45,7 @@ define filechk
 endef
 
 ######
-# cc support functions to be used (only) in arch/$(ARCH)/Makefile
+# gcc support functions
 # See documentation in Documentation/kbuild/makefiles.txt
 
 # as-option
-- 
1.0.GIT


