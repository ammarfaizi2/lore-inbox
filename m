Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVEDHR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVEDHR3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVEDHP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:15:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:59369 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262062AbVEDHLm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:11:42 -0400
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: update version number to 10
In-Reply-To: <11151906962505@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:11:36 -0700
Message-Id: <11151906961976@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] aoe: update version number to 10

update version number to 10

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0e57c7166675a86293f150d5ef7779edd629fe2a
tree 5227de18bbd59513f48766b4f38694d122ffeb59
parent 4613ed277ab8a41640434181898ef4649cc7301e
author Ed L Cashin <ecashin@coraid.com> 1114784668 -0400
committer Greg KH <gregkh@suse.de> 1115188495 -0700

Index: drivers/block/aoe/aoe.h
===================================================================
--- a1993e2276302a253f73e5139347e9ab374561bc/drivers/block/aoe/aoe.h  (mode:100644 sha1:aa8b547ffafa669f7cd3d547e4ac025203d799af)
+++ 5227de18bbd59513f48766b4f38694d122ffeb59/drivers/block/aoe/aoe.h  (mode:100644 sha1:721ba8086043bd714c06e5353f60a348e7989f50)
@@ -1,5 +1,5 @@
 /* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "6"
+#define VERSION "10"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 

