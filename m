Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbUBACqB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 21:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265191AbUBACqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 21:46:01 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:9734 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S265188AbUBACqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 21:46:00 -0500
To: linux-kernel@vger.kernel.org
Subject: no console with current (bk) kernel
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: Sat, 31 Jan 2004 21:45:49 -0500
Message-ID: <m3fzdvy0te.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From my .config:

# CONFIG_FB is not set
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

and yet the boot fails with a complaint that it cannot open a
console, followed by a reboot.  (Too fast to copy anything down.)

Box is p3 notebook, gcc is 3.3.2 (gentoo -r5).

What am I missing?

-JimC

