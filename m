Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271223AbUJVL2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271223AbUJVL2v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271221AbUJVL2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:28:50 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:49540 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S271239AbUJVLYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:24:51 -0400
From: margitsw@t-online.de (Margit Schubert-While)
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 linux-2.6.9] Add prism54 to MAINTAINERS
Date: Fri, 22 Oct 2004 11:39:15 +0200
User-Agent: KMail/1.5.4
Cc: prism54-devel@prism54.org, akpm@osdl.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DVNeBegOLcCT7hJ"
Message-Id: <200410221139.15540.margitsw@t-online.de>
X-ID: JlEEXuZloeZ1rBY2sTvRvMtzVoMH7xeGZ7rJgByn4RHi7l-plobTr0
X-TOI-MSGID: 184b1d4c-f4a2-4efb-a57b-7508be33344f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_DVNeBegOLcCT7hJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2004-10-22 Margit Schubert-While <margitsw@t-online.de>

* Add prism54 to MAINTAINERS

Margit





















--Boundary-00=_DVNeBegOLcCT7hJ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="maintainer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="maintainer.patch"

diff -Naur linux-2.6.9bk/MAINTAINERS linux-2.6.9msw/MAINTAINERS
--- linux-2.6.9bk/MAINTAINERS	2004-10-22 12:27:39.000000000 +0200
+++ linux-2.6.9msw/MAINTAINERS	2004-10-22 12:27:01.000000000 +0200
@@ -1760,6 +1760,13 @@
 W:	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel
 S:	Supported
 
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

--Boundary-00=_DVNeBegOLcCT7hJ--

