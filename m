Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbVLaW0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbVLaW0T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 17:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbVLaW0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 17:26:19 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:49286 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965057AbVLaW0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 17:26:19 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sat, 31 Dec 2005 23:25:57 +0100
Message-id: <200512319343.965475189bla@anxur.fi.muni.cz>
Subject: [PATCH 0/4] stradis video driver rewritten to 2.6 pci api
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, laredo@gnu.org
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patches convert stradis video driver to 2.6 pci API and changes one url
in Kconfig.

Generated in 2.6.15-rc5-mm3 kernel version.

01-pci-probing-for-stradis-driver.patch
02-stradis-video-little-cleanup.patch
03-stradis-lindent.patch
04-stradis-kconfig-url-changed.patch
