Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265328AbUAYXL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbUAYXL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:11:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:52964 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265328AbUAYXLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:11:21 -0500
Date: Sun, 25 Jan 2004 15:11:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <willy@debian.org>
Cc: hch@infradead.org, bunk@fs.tum.de, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [2.6 patch] show "Fusion MPT device support" menu only if
 BLK_DEV_SD
Message-Id: <20040125151107.1ac381f1.akpm@osdl.org>
In-Reply-To: <20040125230756.GI11844@parcelfarce.linux.theplanet.co.uk>
References: <20040120232507.GC6441@fs.tum.de>
	<20040120233537.A23375@infradead.org>
	<20040120160346.7e466ad2.akpm@osdl.org>
	<20040125230756.GI11844@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> wrote:
>
> Andrew, shall I start
>  feeding all my Kconfig cleanups through you rather than through
>  kernel-janitors?

Doesn't Randy have some system going there?
