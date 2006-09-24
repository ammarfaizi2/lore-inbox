Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWIXVT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWIXVT5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWIXVRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:17:50 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:19164 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932140AbWIXVNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:11 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@xenotime.net>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 27/28] dontdiff: add utsrelease.h
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:23 +0200
Message-Id: <1159132707316-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327073393-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org> <11591327061478-git-send-email-sam@ravnborg.org> <115913
 2706423-git-send-email-sam@ravnborg.org> <115913270694-git-send-email-sam@ravnborg.org> <1159132706126-git-send-email-sam@ravnborg.org> <11591327063625-git-send-email-sam@ravnborg.org> <11591327063733-git-send-email-sam@ravnborg.org> <11591327073816-git-send-email-sam@ravnborg.org> <11591327073393-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add auto-generated utsrelease.h to dontdiff file.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/dontdiff |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 24adfe9..63c2d0c 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -135,6 +135,7 @@ tags
 times.h*
 tkparse
 trix_boot.h
+utsrelease.h*
 version.h*
 vmlinux
 vmlinux-*
-- 
1.4.1

