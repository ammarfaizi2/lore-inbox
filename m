Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbVKMLEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVKMLEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 06:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVKMLEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 06:04:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28488 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932373AbVKMLEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 06:04:16 -0500
Date: Sun, 13 Nov 2005 12:05:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051113110517.GG3699@suse.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <20051113090156.GA4417@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051113090156.GA4417@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13 2005, Christoph Hellwig wrote:
> Shouldn't fs/bio.c, fs/block_dev.c and fs/partitions/* move to block/
> aswell?

Yup, that's the intention. I just started off with drivers/block/* to
get it going.

-- 
Jens Axboe

