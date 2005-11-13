Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVKMJCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVKMJCD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 04:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVKMJCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 04:02:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46263 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932170AbVKMJCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 04:02:00 -0500
Date: Sun, 13 Nov 2005 09:01:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>, axboe@suse.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051113090156.GA4417@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, axboe@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't fs/bio.c, fs/block_dev.c and fs/partitions/* move to block/
aswell?
