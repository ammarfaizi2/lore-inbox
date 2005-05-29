Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVE2TO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVE2TO0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 15:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVE2TO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 15:14:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52111 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261408AbVE2TOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 15:14:23 -0400
Date: Sun, 29 May 2005 21:14:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: James.Bottomley@steeleye.com, bzolnier@gmail.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc5-mm1 00/06] blk: barrier flushing reimplementation
Message-ID: <20050529191437.GA30586@suse.de>
References: <20050529042034.5FF4CF1C@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050529042034.5FF4CF1C@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29 2005, Tejun Heo wrote:
>  Hello, guys.
> 
>  This patchset is reimplementation of QUEUE_ORDERED_FLUSH feature.  It
> doens't update API docs yet.  If it's determined that this patchset
> can go in, I'll regenerate this patchset with doc updates (sans the
> last debug message patch of course).

Awesome work, that's really the last step in getting the barrier code
fully unified and working with tags. I'll review your patchset tomorrow.

-- 
Jens Axboe

