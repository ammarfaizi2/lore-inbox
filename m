Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965218AbWIERnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbWIERnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 13:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWIERnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 13:43:31 -0400
Received: from 71-215-130-30.ptld.qwest.net ([71.215.130.30]:9453 "EHLO
	vonnegut.anholt.net") by vger.kernel.org with ESMTP id S965218AbWIERn2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:43:28 -0400
From: Eric Anholt <eric@anholt.net>
To: linux-kernel@vger.kernel.org
Cc: davej@codemonkey.org.uk, Eric Anholt <eric@anholt.net>
Subject: [PATCH] Remove attribution section, which is unnecessary with revision control.
Reply-To: Eric Anholt <eric@anholt.net>
Date: Tue, 05 Sep 2006 10:37:35 -0700
Message-Id: <11574779041178-git-send-email-eric@anholt.net>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11574778924142-git-send-email-eric@anholt.net>
References: 11551502672606-git-send-email-eric@anholt.net <115747785570-git-send-email-eric@anholt.net> <115747787383-git-send-email-eric@anholt.net> <11574778924142-git-send-email-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index e643445..4ad5a03 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -2,20 +2,6 @@
  * Intel AGPGART routines.
  */
 
-/*
- * Intel(R) 855GM/852GM and 865G support added by David Dawes
- * <dawes@tungstengraphics.com>.
- *
- * Intel(R) 915G/915GM support added by Alan Hourihane
- * <alanh@tungstengraphics.com>.
- *
- * Intel(R) 945G/945GM support added by Alan Hourihane
- * <alanh@tungstengraphics.com>.
- *
- * Intel(R) 946GZ/965Q/965G support added by Alan Hourihane
- * <alanh@tungstengraphics.com>.
- */
-
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-- 
1.4.1

