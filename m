Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273000AbTHAKqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273611AbTHAKob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:44:31 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:55057 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S270000AbTHAKoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:44:20 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.22-pre10] [1/2] CONFIG: Rename "Second extended fs support" to "Ext2 file system support"
Date: Fri, 1 Aug 2003 12:40:00 +0200
User-Agent: KMail/1.5.2
Organization: Working Overloaded Linux Kernel
MIME-Version: 1.0
Message-Id: <200307312218.41481.m.c.p@wolk-project.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AOkK/PVfLqMDGFu"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_AOkK/PVfLqMDGFu
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcelo,

this is pure cosmetic cleanup. Subject says it all.

Please apply for 2.4.22-pre10. Thank you :)

ciao, Marc

--Boundary-00=_AOkK/PVfLqMDGFu
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="2.4-ext2-rename.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4-ext2-rename.patch"

--- a/fs/Config.in		Thu Sep 26 12:19:14 2002
+++ b/fs/Config.in		Thu Sep 26 19:26:31 2002
@@ -87,7 +87,7 @@
 
 tristate 'ROM file system support' CONFIG_ROMFS_FS
 
-tristate 'Second extended fs support' CONFIG_EXT2_FS
+tristate 'Ext2 file system support' CONFIG_EXT2_FS
 
 tristate 'System V/Xenix/V7/Coherent file system support' CONFIG_SYSV_FS
 

--Boundary-00=_AOkK/PVfLqMDGFu--


