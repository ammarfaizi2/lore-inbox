Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUI0Irm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUI0Irm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 04:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUI0Irm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 04:47:42 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:5760 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S266308AbUI0Irl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 04:47:41 -0400
Date: Mon, 27 Sep 2004 18:45:51 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: promise controller resource alloc problems with ~2.6.8
Message-ID: <20040927084550.GA1134@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Promise PDC20267 card in my desktop and whilst it works
in 2.6.8-rc2, it no longer functions beginning with at least 2.6.9-rc2.
Latest kernel I ran is 2.6.9-rc2-bk8 and it was still not available.

dmesg does mention it though as:

PDC20267: IDE controller at PCI slot 0000:00:0d.0
PCI: Found IRQ 11 for device 0000:00:0d.0
PCI: Unable to reserve I/O region #5:40@1080 for device 0000:00:0d.0

And that's as far as it gets.

-- 
    Red herrings strewn hither and yon.
