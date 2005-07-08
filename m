Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVGHVs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVGHVs7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 17:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbVGHVrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 17:47:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18949 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262580AbVGHVo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:44:58 -0400
Date: Fri, 8 Jul 2005 23:44:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Jesper Juhl <juhl-lkml@dif.dk>
Subject: [2.6 patch] Documentation/Changes: document the required udev version
Message-ID: <20050708214454.GJ3671@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document that udev 058 is required.

A similar patch (that no longger applies due to unrelated context 
changes) was sent by Jesper Juhl.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 2 Jul 2005

--- linux-2.6.13-rc1-mm1-full/Documentation/Changes.old	2005-07-02 12:41:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1-full/Documentation/Changes	2005-07-02 12:41:42.000000000 +0200
@@ -66,6 +66,7 @@
 o  nfs-utils              1.0.5                   # showmount --version
 o  procps                 3.2.0                   # ps --version
 o  oprofile               0.9                     # oprofiled --version
+o  udev                   058                     # udevinfo -V
 
 Kernel compilation
 ==================

