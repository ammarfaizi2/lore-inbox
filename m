Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVK0SVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVK0SVW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 13:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVK0SVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 13:21:22 -0500
Received: from 18.112.63.81.cust.bluewin.ch ([81.63.112.18]:60836 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S1751138AbVK0SVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 13:21:21 -0500
Date: Sun, 27 Nov 2005 19:20:58 +0100
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Cc: Lucas Vogelsang <lucasvo@gmx.ch>
Subject: 2 bugs in Philips webcam description
Message-ID: <20051127182058.GA7498@kestrel.twibright.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
X-Stance: Goofy
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug 1:
USB Philips Cameras
See <file:Documentation/usb/philips.txt>
clock@kestrel:/usr/src/linux/Documentation/usb$ ls philips.txt
ls: philips.txt: No such file or directory

Bug 2:
pointers to "v4l" programs may be found at
<file:Documentation/video4linux/API.html>

This is not true. They cannot be found there because there are none.

CL<
