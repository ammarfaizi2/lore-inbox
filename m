Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWJ2JzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWJ2JzW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 04:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWJ2JzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 04:55:22 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:21127 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932143AbWJ2JzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 04:55:21 -0500
Date: Sun, 29 Oct 2006 10:55:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.18 is problematic in VMware
Message-ID: <Pine.LNX.4.61.0610290953010.4585@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


I have observed a strange slowdown with the 2.6.18 kernel in VMware. 
This happened both with the SUSE flavor and with the FC6 installer CD 
(which I am trying right now). In both cases, the kernel "takes its 
time" after the following text strings:

* Checking if this processor honours the WP bit even in supervisor mode... Ok.
* Checking 'hlt' instruction... OK.

What's with that?


	-`J'
-- 
