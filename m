Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbUK0CMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbUK0CMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbUK0CL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:11:58 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262708AbUKZThG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:06 -0500
Date: Thu, 25 Nov 2004 10:12:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: axboe@suse.de, tim@cyberelk.net, mike.miller@hp.com,
       Andrew Morton <akpm@osdl.org>, linux-parport@lists.infradead.org,
       linux-kernel@vger.kernel.org, iss_storagedev@hp.com
Subject: Re: [2.6 patch] drivers/block/: some cleanups
Message-ID: <20041125101220.GC29539@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, axboe@suse.de, tim@cyberelk.net,
	mike.miller@hp.com, Andrew Morton <akpm@osdl.org>,
	linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org,
	iss_storagedev@hp.com
References: <20041124231055.GN19873@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124231055.GN19873@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 12:10:55AM +0100, Adrian Bunk wrote:
> the patch below removes some unused code from drivers/block/, makes 
> some needlessly global code static and does some other small cleanups.
> 
> Please review and comment.

Probably easier to review if split at a per-driver basis.

