Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbVJPWbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbVJPWbo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 18:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVJPWbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 18:31:44 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:16855 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751374AbVJPWbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 18:31:43 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Mon, 17 Oct 2005 00:31:37 +0200
In-reply-to: <200100919343.123456789ble@anxur.fi.muni.cz>
Subject: [PATCHv3 0/6] isicom char driver rewritten to 2.6 api
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Message-Id: <20051016223136.5E3EB22AF10@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ONE MORE IMPORTANT THING, Andrew, if you haven't dropped previous patches yet
(as I wrote, if the e-mail was delivered),
that were commented by that fellows, please, do it before applying, thanks.

This patches convert isicom char driver to 2.6 API.

Thanks to G. KH, AC and D. Torokhov for their comments.

Generated in 2.6.14-rc2-mm2 kernel version.

01-whitespace-cleanup
02-type-conversion-and-variables-deletion
03-others-little-changes
04-pci-probing-added
05-firmware-loading
06-more-whitespaces-and-coding-style
