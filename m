Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932674AbVIEVnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbVIEVnj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbVIEVnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:43:39 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:17490 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932656AbVIEVni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:43:38 -0400
Date: Mon, 05 Sep 2005 18:26:16 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 18/24] V4L: #include <linux/config.h> no longer needed.
Message-ID: <431cb7f8.AnZ+EC9SQeu4mDnu%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f8.1dn3VwkQ0vkxhnCWYIoulaIGXEgK7bpxBPVX7v8BXh27iuHN"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f8.1dn3VwkQ0vkxhnCWYIoulaIGXEgK7bpxBPVX7v8BXh27iuHN
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f8.1dn3VwkQ0vkxhnCWYIoulaIGXEgK7bpxBPVX7v8BXh27iuHN
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-18-patch.diff"

- #include <linux/config.h> no longer needed.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/video/saa7134/saa7134-dvb.c |    1 -
 1 files changed, 1 deletion(-)

diff -u /tmp/dst.800 linux/drivers/media/video/saa7134/saa7134-dvb.c
--- /tmp/dst.800	2005-09-05 11:43:09.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-dvb.c	2005-09-05 11:43:09.000000000 -0300
@@ -28,7 +28,6 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/suspend.h>
-#include <linux/config.h>
 
 
 #include "saa7134-reg.h"

--=_431cb7f8.1dn3VwkQ0vkxhnCWYIoulaIGXEgK7bpxBPVX7v8BXh27iuHN--
