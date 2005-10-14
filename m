Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbVJNJpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVJNJpb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 05:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJNJpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 05:45:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56918 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751146AbVJNJpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 05:45:30 -0400
Date: Fri, 14 Oct 2005 11:46:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
Message-ID: <20051014094613.GA6603@suse.de>
References: <200510132128.45171.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510132128.45171.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13 2005, Jesper Juhl wrote:
> This is the remaining misc drivers/ part of the big kfree cleanup patch.
> 
> Remove pointless checks for NULL prior to calling kfree() in misc
> files in drivers/.

ide/block bits look fine to me - in the future, can you please thread
your postings so that 1...n/n are followups to 0/n?

-- 
Jens Axboe

