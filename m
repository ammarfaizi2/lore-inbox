Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263061AbUJ1Nhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbUJ1Nhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 09:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUJ1Nhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 09:37:37 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:56081 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S263061AbUJ1NhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 09:37:23 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: Multiple serial port detection messages on PC
In-Reply-To: <Pine.GSO.4.44.0410271308570.19695-100000@math.ut.ee>
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.10-rc1 (i686))
Message-Id: <E1CNASo-00013U-Vl@rhn.tartu-labor>
Date: Thu, 28 Oct 2004 16:37:14 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MR> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
MR> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
MR> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
MR> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
MR> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
MR> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

Todays BK snapshot detects them only twice (4 lines instead of 6) - a
clear imprevement :)

-- 
Meelis Roos
