Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUEKG3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUEKG3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUEKG25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:28:57 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:31864 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262279AbUEKGZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:25:07 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 5/9] New set of input patches - 07-power-license.patch
Date: Tue, 11 May 2004 01:06:30 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200405110101.42805.dtor_core@ameritech.net> <200405110105.08839.dtor_core@ameritech.net> <200405110105.58112.dtor_core@ameritech.net>
In-Reply-To: <200405110105.58112.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405110106.32081.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1587.20.8, 2004-05-10 01:32:39-05:00, dtor_core@ameritech.net
  Input: power - add MODULE_LICENSE


 power.c |    1 +
 1 files changed, 1 insertion(+)


===================================================================



diff -Nru a/drivers/input/power.c b/drivers/input/power.c
--- a/drivers/input/power.c	Tue May 11 00:56:54 2004
+++ b/drivers/input/power.c	Tue May 11 00:56:54 2004
@@ -172,3 +172,4 @@
 
 MODULE_AUTHOR("James Simmons <jsimmons@transvirtual.com>");
 MODULE_DESCRIPTION("Input Power Management driver");
+MODULE_LICENSE("GPL");
