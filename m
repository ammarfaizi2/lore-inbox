Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965234AbVKGW4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbVKGW4J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965588AbVKGW4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:56:09 -0500
Received: from admingilde.org ([213.95.32.146]:46985 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S965234AbVKGW4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:56:08 -0500
Message-Id: <20051107225605.630743000@admingilde.org>
References: <20051107225408.911193000@admingilde.org>
Date: Mon, 07 Nov 2005 23:54:12 +0100
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 3/4] DocBook: comment about paper type
Content-Disposition: inline; filename=docbook-paper-type.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: comment about paper type

Add a comment showing how to change paper type.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---
 Documentation/DocBook/stylesheet.xsl |    1 +
 1 files changed, 1 insertion(+)

Index: linux-docbook/Documentation/DocBook/stylesheet.xsl
===================================================================
--- linux-docbook.orig/Documentation/DocBook/stylesheet.xsl	2005-05-31 09:58:55.000000000 +0200
+++ linux-docbook/Documentation/DocBook/stylesheet.xsl	2005-05-31 22:22:11.879399511 +0200
@@ -3,4 +3,5 @@
 <param name="chunk.quietly">1</param>
 <param name="funcsynopsis.style">ansi</param>
 <param name="funcsynopsis.tabular.threshold">80</param>
+<!-- <param name="paper.type">A4</param> -->
 </stylesheet>

--
Martin Waitz
