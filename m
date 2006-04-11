Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWDKLPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWDKLPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWDKLPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:15:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12049 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750726AbWDKLPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:15:42 -0400
Date: Tue, 11 Apr 2006 13:15:49 +0200
From: Jens Axboe <axboe@suse.de>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: add splice_write and splice_read to documentation
Message-ID: <20060411111548.GA4791@suse.de>
References: <Pine.LNX.4.58.0604111402550.15286@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0604111402550.15286@sbz-30.cs.Helsinki.FI>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11 2006, Pekka J Enberg wrote:
> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> This patch adds the new splice_write and splice_read file operations to
> Documentation/filesystems/vfs.txt.
> 
> Cc: Jens Axboe <axboe@suse.de>
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

Thanks, I'll add that to the splice branch since it wants updating for
the modified interface anyways.

-- 
Jens Axboe

