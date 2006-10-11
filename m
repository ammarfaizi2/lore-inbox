Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161543AbWJKV7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161543AbWJKV7d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161542AbWJKV7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:59:33 -0400
Received: from mx0.karneval.cz ([81.27.192.123]:30037 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1161543AbWJKV7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:59:31 -0400
Message-id: <83333ewww3221213@karneval.cz>
In-Reply-To: <20061011145530.1762a4e5.rdunlap@xenotime.net>
References: <20061011143306.e3ae39f8.rdunlap@xenotime.net>
	<89743ewww3221213@karneval.cz>
	<20061011145530.1762a4e5.rdunlap@xenotime.net>
Subject: [PATCH try3] maintainers: add me to isicom, mxser
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>
Date: Wed, 11 Oct 2006 23:59:28 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On Wed, 11 Oct 2006 23:45:02 +0200 (CEST) Jiri Slaby wrote:
>> Ok, thanks, here is a corrected patch.
>
> Did you resend the version 1 patch instead??

Exactly :(. Now:

--

maintainers: add me to isicom, mxser

I can maintain moxa and isicom char drivers, because I've rewritten them to
the new API.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit a17f8130e4af536608ed6f93341003dd5f0af825
tree 5712fa3dc9a5a69550d3c17c3617ac4276304bdd
parent b2090dd621f58423950e8e79b0959889d26a8227
author Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 23:42:04 +0200
committer Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 23:42:04 +0200

 MAINTAINERS |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c4563ce..b1d6e8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2020,6 +2020,12 @@ M:	rubini@ipvvis.unipv.it
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+MOXA SMARTIO/INDUSTIO SERIAL CARD (MXSER 2.0)
+P:	Jiri Slaby
+M:	jirislaby@gmail.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 MSI LAPTOP SUPPORT
 P:	Lennart Poettering
 M:	mzxreary@0pointer.de
@@ -2042,6 +2048,12 @@ P:	Andrew Veliath
 M:	andrewtv@usa.net
 S:	Maintained
 
+MULTITECH MULTIPORT CARD (ISICOM)
+P:	Jiri Slaby
+M:	jirislaby@gmail.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 NATSEMI ETHERNET DRIVER (DP8381x)
 P: 	Tim Hockin
 M:	thockin@hockin.org
