Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUBHQjT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbUBHQjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:39:19 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:14564 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S263806AbUBHQjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:39:17 -0500
Date: Sun, 8 Feb 2004 17:39:10 +0100
From: David Weinehall <tao@kernel.org>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Linux-kernel 2.0.40 aka ``The Moss-covered Tortoise''
Message-ID: <20040208163910.GQ5776@khan.acc.umu.se>
Mail-Followup-To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Umea, Sweden, 2004-02-08, 14:30 CET

Hereby I wish to announce Linux-kernel v2.0.40,
aka ``The Moss-covered Tortoise''.  This release fixes several remote
information-leaks, a few local exploits, possible group descriptor
corruption for ext2fs, a few network related issues, a few SUS/LSB
compliance issues, and various other minor changes.  A complete changelog
can be found at the same places the kernel itself can be downloaded.

This upgrade is of medium urgency, and is a recommended upgrade if you
experience problems.  This kernel is only maintained, not developed, and
hence, if you miss support for hardware/software or any feature, then
you should consider upgrading to either the latest v2.4.xx kernel or
the latest v2.6.xx kernel.

The kernel can be found at:

ftp.xx.kernel.org (where xx is your country-code)

Complete tarballs (compressed with gz and bzip2 respectively):

/pub/linux/kernel/v2.0/linux-2.0.40.tar.gz
/pub/linux/kernel/v2.0/linux-2.0.40.tar.bz2

As a patch to be applied on top of the v2.0.39 kernel-tree
(compressed with gz and bzip2 respectively):

/pub/linux/kernel/v2.0/patch-2.0.40.gz
/pub/linux/kernel/v2.0/patch-2.0.40.bz2

Note that some mirrors might not keep both compression-formats.


Regards: David Weinehall <tao@kernel.org>
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
