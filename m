Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWAPJWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWAPJWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWAPJWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:22:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20971 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932262AbWAPJWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:22:05 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 06/25] Updated MODULE_AUTHOR
Date: Mon, 16 Jan 2006 07:11:20 -0200
Message-id: <20060116091120.PS40192100006@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@m1k.net>

- Updated MODULE_AUTHOR

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-usb/cxusb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/media/dvb/dvb-usb/cxusb.c b/drivers/media/dvb/dvb-usb/cxusb.c
index 18d1698..a7fb06f 100644
--- a/drivers/media/dvb/dvb-usb/cxusb.c
+++ b/drivers/media/dvb/dvb-usb/cxusb.c
@@ -691,6 +691,8 @@ module_init (cxusb_module_init);
 module_exit (cxusb_module_exit);
 
 MODULE_AUTHOR("Patrick Boettcher <patrick.boettcher@desy.de>");
+MODULE_AUTHOR("Michael Krufky <mkrufky@m1k.net>");
+MODULE_AUTHOR("Chris Pascoe <c.pascoe@itee.uq.edu.au>");
 MODULE_DESCRIPTION("Driver for Conexant USB2.0 hybrid reference design");
 MODULE_VERSION("1.0-alpha");
 MODULE_LICENSE("GPL");

