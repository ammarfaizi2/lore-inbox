Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWG2HWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWG2HWk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbWG2HT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:19:57 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:52403 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422680AbWG2HTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:19:54 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] kbuild: .gitignore utsrelease.h
Reply-To: sam@ravnborg.org
Date: Sat, 29 Jul 2006 09:19:35 +0200
Message-Id: <11541575811267-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1.rc2.gfc04
In-Reply-To: <11541575813716-git-send-email-sam@ravnborg.org>
References: <20060729071540.GA6738@mars.ravnborg.org> <11541575812597-git-send-email-sam@ravnborg.org> <11541575813716-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 27fd376..3f9bb5e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,6 +30,7 @@ include/config
 include/linux/autoconf.h
 include/linux/compile.h
 include/linux/version.h
+include/linux/utsrelease.h
 
 # stgit generated dirs
 patches-*
-- 
1.4.1.rc2.gfc04

