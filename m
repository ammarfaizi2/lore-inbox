Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWAPP2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWAPP2b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWAPP2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:28:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18049 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750840AbWAPP2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:28:30 -0500
Date: Mon, 16 Jan 2006 15:28:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export writeback_bdev and writeback_inode
Message-ID: <20060116152826.GA16617@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060116140230.GA10157@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116140230.GA10157@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 03:02:30PM +0100, Olaf Hering wrote:
> 
> *** Warning: "writeback_bdev" [fs/msdos/msdos.ko] undefined!
> *** Warning: "writeback_inode" [fs/msdos/msdos.ko] undefined!

What tree is this against?  Neither writeback_bdev nor writeback_inode
exist in current mainline.

