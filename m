Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268511AbUIQJGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268511AbUIQJGW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 05:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268581AbUIQJGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 05:06:22 -0400
Received: from math.ut.ee ([193.40.5.125]:21667 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S268511AbUIQJGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 05:06:20 -0400
Date: Fri, 17 Sep 2004 12:06:16 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Keyboard problem with 2.6.9-rc* and X
Message-ID: <Pine.GSO.4.44.0409171201070.12456-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running up to date Debian unstable and BK kernels (one or two
updates a week) on an x86 (i815 chipset), ps2 keyboard, usb mouse.

Somewhere after 2.6.8 a keyboard problem appeared. After boot, kdm
starts X and the keyboard is dead in X (even no Ctrl-Alt-F1 for console
switching). Keyboard works fine on console before X startup. The mouse
still works even in X, I can select console login from kdm menu, X is
stopped, the keyboard works again on the console so I can log in as root
and restart kdm - this time the keyboard works too. This is 100%
reproducible.

This might also be an X problem (recently X server was updated too).

-- 
Meelis Roos (mroos@linux.ee)

