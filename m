Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVCCMBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVCCMBC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVCCLJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:09:30 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:1460 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262510AbVCCKl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:41:26 -0500
Date: Thu, 3 Mar 2005 11:41:13 +0100
Message-Id: <200503031041.j23AfD0p020680@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 1/16] DocBook: remove reference to drivers/net/net_init.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: remove reference to drivers/net/net_init.c
This file has been removed and is breaking documentation generation.
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2025  -> 1.2026 
#	Documentation/DocBook/kernel-api.tmpl	1.32    -> 1.33   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/01/26	tali@admingilde.org	1.2026
# DocBook: remove reference to drivers/net/net_init.c
# 
# This file has been removed and is breaking documentation generation.
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
--- a/Documentation/DocBook/kernel-api.tmpl	Thu Mar  3 11:41:17 2005
+++ b/Documentation/DocBook/kernel-api.tmpl	Thu Mar  3 11:41:17 2005
@@ -152,7 +152,6 @@
   <chapter id="netdev">
      <title>Network device support</title>
      <sect1><title>Driver Support</title>
-!Edrivers/net/net_init.c
 !Enet/core/dev.c
      </sect1>
      <sect1><title>8390 Based Network Cards</title>
