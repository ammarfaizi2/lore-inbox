Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTKMNx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 08:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTKMNx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 08:53:29 -0500
Received: from [212.35.254.18] ([212.35.254.18]:26846 "EHLO mail2.midnet.co.uk")
	by vger.kernel.org with ESMTP id S264283AbTKMNx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 08:53:28 -0500
Date: Thu, 13 Nov 2003 13:52:45 +0000
From: Tim Kelsey <mn@midnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9-mm3 initrd strangeness
Message-Id: <20031113135245.128ec5e0.mn@midnet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first mailing list post so Sorry for any breach of etiquette.

I am experiencing problems with 2.6.0-test9-mm3 and initrd ramdisks
I have support for ramdisks and initrd compiled directly into the kernel and have an initrd image gzipped and placed in /boot called initrd-crypt.gz

When booting off a 2.4.22 kernel the image is loaded and linuxrc is executed perfectly but with a 2.6.0-test9-mm3 kernel i get the following msg at boot time

	RAMDISK: Compressed image found at block 0
	RAMDISK: incomplete Write (-1 != 32768) 4194304

Any comments, advice, opinions greatly appreciated also if someone could explain what those numbers actually mean i would be very grateful 

Many Thanx,

Tim Kelsey
Systems Admin, Midland Internet
