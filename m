Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSL2XS6>; Sun, 29 Dec 2002 18:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSL2XS6>; Sun, 29 Dec 2002 18:18:58 -0500
Received: from [81.2.122.30] ([81.2.122.30]:32516 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S262089AbSL2XS5>;
	Sun, 29 Dec 2002 18:18:57 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212292327.gBTNR6k4000745@darkstar.example.net>
Subject: [TRIVIAL] fix typo in drivers/video/pmagb-b-fb.h
To: trivial@rustcorp.com.au
Date: Sun, 29 Dec 2002 23:27:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.707.1041204426--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.707.1041204426--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch is against 2.5.53, and applies to 2.4.20 as well.

John.

--%--multipart-mixed-boundary-1.707.1041204426--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: ASCII English text
Content-Disposition: attachment; filename="my_patch"

--- linux-2.5.53-orig/drivers/video/pmagb-b-fb.h	2002-12-29 23:15:34.000000000 +0000
+++ linux-2.5.53/drivers/video/pmagb-b-fb.h	2002-12-29 23:19:48.000000000 +0000
@@ -4,7 +4,7 @@
  *      TurboChannel PMAGB-B framebuffer card support,
  *      Copyright (C) 1999, 2000, 2001 by
  *      Michael Engel <engel@unix-ag.org> and 
- *      Karsten Merker <merker@linxutag.org>
+ *      Karsten Merker <merker@linuxtag.org>
  *      This file is subject to the terms and conditions of the GNU General
  *      Public License.  See the file COPYING in the main directory of this
  *      archive for more details.

--%--multipart-mixed-boundary-1.707.1041204426--%--
