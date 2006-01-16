Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWAPPdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWAPPdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWAPPdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:33:47 -0500
Received: from ns1.suse.de ([195.135.220.2]:35515 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750976AbWAPPdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:33:47 -0500
Date: Mon, 16 Jan 2006 16:33:33 +0100
From: Olaf Hering <olh@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export writeback_bdev and writeback_inode
Message-ID: <20060116153333.GA12474@suse.de>
References: <20060116140230.GA10157@suse.de> <20060116152826.GA16617@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060116152826.GA16617@infradead.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jan 16, Christoph Hellwig wrote:

> On Mon, Jan 16, 2006 at 03:02:30PM +0100, Olaf Hering wrote:
> > 
> > *** Warning: "writeback_bdev" [fs/msdos/msdos.ko] undefined!
> > *** Warning: "writeback_inode" [fs/msdos/msdos.ko] undefined!
> 
> What tree is this against?  Neither writeback_bdev nor writeback_inode
> exist in current mainline.

Thanks for pointing that out.
Some GUI stuff from mason, to avoid mount -o sync.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
