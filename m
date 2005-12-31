Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVLaQhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVLaQhn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 11:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVLaQhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 11:37:42 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:58781 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965014AbVLaQhl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 11:37:41 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sat, 31 Dec 2005 17:37:34 +0100
In-reply-to: <200500919343.923456789ble@anxur.fi.muni.cz>
Subject: Re: [PATCH 0/5] maestro radio driver rewritten to 2.6 pci api
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, atlka@pg.gda.pl
Message-Id: <20051231163733.005661E33CD@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[video_device_owner patch added]

This patches convert maestro radio driver to 2.6 pci API.

Generated in 2.6.15-rc5-mm3 kernel version.

01-pci-probing-for-maestro-radio.patch
02-maestro-radio-lindent.patch
03-maestro-types-change.patch
04-maestro-avoid-accessing-private-structures-directly.patch
05-video_device_owner.patch
