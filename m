Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271217AbUJVLbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271217AbUJVLbw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271219AbUJVL3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:29:09 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:44681 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S271229AbUJVL14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:27:56 -0400
From: margitsw@t-online.de (Margit Schubert-While)
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 linux-2.4.28-pre4] Add prism54 to MAINTAINERS
Date: Fri, 22 Oct 2004 11:42:15 +0200
User-Agent: KMail/1.5.4
Cc: prism54-devel@prism54.org, marcelo.tosatti@cyclades.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3XNeBhZ6luo/sXm"
Message-Id: <200410221142.15056.margitsw@t-online.de>
X-ID: bN-0ggZUoervGmBDt1AXsYyOtqYL9vyqBvt2uG6j6HLPKEHmVCODUK
X-TOI-MSGID: f702f010-8756-4f75-bfcf-029bed214d93
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_3XNeBhZ6luo/sXm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Resend - ignore previous 2.4.28 mail

2004-10-22 Margit Schubert-While <margitsw@t-online.de>

* Add prism54 to MAINTAINERS

Eeek, wrong attachment - Sorry
Now we have the right one.

Margit






















--Boundary-00=_3XNeBhZ6luo/sXm
Content-Type: text/x-diff;
  charset="us-ascii";
  name="maintainer24.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="maintainer24.patch"

diff -Naur linux-2.4.8-pre4/MAINTAINERS linux-2.4.8-pre4msw/MAINTAINERS
--- linux-2.4.8-pre4/MAINTAINERS	2004-10-22 11:31:48.000000000 +0200
+++ linux-2.4.8-pre4msw/MAINTAINERS	2004-10-22 11:32:38.000000000 +0200
@@ -1536,6 +1536,13 @@
 M:	mostrows@styx.uwaterloo.ca
 S:	Maintained
 
+PRISM54 WIRELESS DRIVER
+P:	Prism54 Development Team
+M:	prism54-private@prism54.org
+L:	netdev@oss.sgi.com
+W:	http://prism54.org
+S:	Maintained
+
 PROMISE DC4030 CACHING DISK CONTROLLER DRIVER
 P:	Peter Denison
 M:	promise@pnd-pc.demon.co.uk

--Boundary-00=_3XNeBhZ6luo/sXm--

