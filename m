Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbWKGON4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWKGON4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 09:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWKGON4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 09:13:56 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:52424 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932638AbWKGONz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 09:13:55 -0500
Date: Tue, 7 Nov 2006 15:12:41 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, Andrew Victor <andrew@sanpeople.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-mm patch 5/4] Atmel SPI driver: MAINTAINERS entry
Message-ID: <20061107151241.1ccbd36e@cad-250-152.norway.atmel.com>
In-Reply-To: <20061107124128.0d847889@cad-250-152.norway.atmel.com>
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
	<20061107122715.3022da2f@cad-250-152.norway.atmel.com>
	<20061107123106.69032174@cad-250-152.norway.atmel.com>
	<20061107123345.2de13fed@cad-250-152.norway.atmel.com>
	<20061107124128.0d847889@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer of the atmel_spi driver.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d708702..401fa5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -426,6 +426,13 @@ L:	linux-atm-general@lists.sourceforge.n
 W:	http://linux-atm.sourceforge.net
 S:	Maintained
 
+ATMEL SPI DRIVER
+P:	Atmel AVR32 Support Team
+M:	avr32@atmel.com
+P:	Haavard Skinnemoen
+M:	hskinnemoen@atmel.com
+S:	Supported
+
 ATMEL WIRELESS DRIVER
 P:	Simon Kelley
 M:	simon@thekelleys.org.uk
-- 
1.4.3.2

