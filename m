Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVLaQR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVLaQR1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 11:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbVLaQRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 11:17:04 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:57808 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S964998AbVLaQQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 11:16:58 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sat, 31 Dec 2005 17:16:35 +0100
Message-id: <200500919343.923456789ble@anxur.fi.muni.cz>
Subject: [PATCH 0/4] maestro radio driver rewritten to 2.6 pci api
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, atlka@pg.gda.pl
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patches convert maestro radio driver to 2.6 pci API.

Generated in 2.6.15-rc5-mm3 kernel version.

01-pci-probing-for-maestro-radio.patch
02-maestro-radio-lindent.patch
03-maestro-types-change.patch
04-maestro-avoid-accessing-private-structures-directly.patch
