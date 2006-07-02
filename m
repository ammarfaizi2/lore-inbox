Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWGBV1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWGBV1Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 17:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWGBV1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 17:27:25 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:37024 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750877AbWGBV1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 17:27:25 -0400
Message-ID: <44A83A25.9090906@linuxtv.org>
Date: Sun, 02 Jul 2006 17:27:01 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mike Isely <isely@pobox.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH] add Mike Isely as pvrusb2 maintainer
Content-Type: multipart/mixed;
 boundary="------------030901040008000309080001"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030901040008000309080001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------030901040008000309080001
Content-Type: text/x-patch;
 name="MAINTAINERS-pvrusb2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MAINTAINERS-pvrusb2.patch"

[PATCH] add Mike Isely as pvrusb2 maintainer

This patch updates MAINTAINERS with contact info for
Mike Isely, the PVRUSB2 maintainer, while also adding
the pvrusb2 mailing list and web site.

Signed-off-by: Mike Isely <isely@pobox.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42be131..4374efc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2298,6 +2298,14 @@ M:	promise@pnd-pc.demon.co.uk
 W:	http://www.pnd-pc.demon.co.uk/promise/
 S:	Maintained
 
+PVRUSB2 VIDEO4LINUX DRIVER
+P:	Mike Isely
+M:	isely@pobox.com
+L:	pvrusb2@isely.net
+L:	video4linux-list@redhat.com
+W:	http://www.isely.net/pvrusb2/
+S:	Maintained
+
 PXA2xx SUPPORT
 P:	Nicolas Pitre
 M:	nico@cam.org

--------------030901040008000309080001--
