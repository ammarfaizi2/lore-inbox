Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264768AbUDWJJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbUDWJJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 05:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264771AbUDWJJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 05:09:54 -0400
Received: from math.ut.ee ([193.40.5.125]:52211 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264768AbUDWJJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 05:09:52 -0400
Date: Fri, 23 Apr 2004 11:48:49 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: modular vga16fb on PPC32
Message-ID: <Pine.GSO.4.44.0404231147360.15262-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is from current 2.6.6-rc2+BK:

*** Warning: "vgacon_remap_base" [drivers/video/vga16fb.ko] undefined!

Do we need to export vgacon_remap_base?

-- 
Meelis Roos (mroos@linux.ee)

