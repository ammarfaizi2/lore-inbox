Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVGDVML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVGDVML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 17:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVGDVMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 17:12:10 -0400
Received: from soufre.accelance.net ([213.162.48.15]:12490 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261662AbVGDVMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 17:12:07 -0400
Message-ID: <42C9A624.6040705@xenomai.org>
Date: Mon, 04 Jul 2005 23:12:04 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] I-pipe 2.6.12-v0.9-00
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The interrupt pipeline patch v0.9-00 has been released, adding support 
for the ia64 architecture.

A split version of the patch for x86, ppc32 and ia64 is available here: 
http://download.gna.org/adeos/patches/v2.6/ipipe/split/

Patch sequence to build a Linux 2.6.12 tree with I-pipe support:

http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
http://download.gna.org/adeos/patches/v2.6/ipipe/ipipe-2.6.12-v0.9-00.patch

-- 

Philippe.
