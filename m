Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbTLXRhk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 12:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbTLXRgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 12:36:44 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:21685 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263740AbTLXRe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 12:34:59 -0500
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Typo: 2.6.0 docs about kbuild.
Date: Wed, 24 Dec 2003 18:33:12 +0100
User-Agent: KMail/1.5
Cc: akpm@osdl.org
MIME-Version: 1.0
Message-Id: <200312241236.24038.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Y3c6/qnHaSkRawE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Y3c6/qnHaSkRawE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This fixes a "typo" for Kconfig-language docs. It's against 2.6.0.
CC me on replies, as I'm not subscribed, please.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade





--Boundary-00=_Y3c6/qnHaSkRawE
Content-Type: text/x-diff;
  charset="us-ascii";
  name="KConfig_help-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="KConfig_help-fix.patch"

--- ./Documentation/kbuild/kconfig-language.txt.fix	2003-12-20 20:02:15.000000000 +0100
+++ ./Documentation/kbuild/kconfig-language.txt	2003-12-22 11:06:35.000000000 +0100
@@ -141,8 +141,8 @@
     otherwise 'y'.
 (4) Returns the value of the expression. Used to override precedence.
 (5) Returns the result of (2-/expr/).
-(6) Returns the result of max(/expr/, /expr/).
-(7) Returns the result of min(/expr/, /expr/).
+(6) Returns the result of min(/expr/, /expr/).
+(7) Returns the result of max(/expr/, /expr/).
 
 An expression can have a value of 'n', 'm' or 'y' (or 0, 1, 2
 respectively for calculations). A menu entry becomes visible when it's

--Boundary-00=_Y3c6/qnHaSkRawE--


