Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbVJITj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbVJITj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 15:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVJITj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 15:39:58 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:1427 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750888AbVJITj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 15:39:57 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sun,  9 Oct 2005 21:39:45 +0200
Subject: [PATCH2 0/6] isicom char driver rewritten to 2.6 api
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Message-Id: <20051009193943.943E522AEB1@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patches convert isicom char driver to 2.6 API.

Repost, posted yet on:
19 Aug

01-whitespace-cleanup
02-type-conversion-and-variables-deletion
03-others-little-changes
04-pci-probing-added
05-firmware-loading
06-more-whitespaces-and-coding-style
