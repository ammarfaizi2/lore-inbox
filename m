Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283621AbRLIQ6g>; Sun, 9 Dec 2001 11:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283626AbRLIQ60>; Sun, 9 Dec 2001 11:58:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26884 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283621AbRLIQ6Y>;
	Sun, 9 Dec 2001 11:58:24 -0500
Date: Sun, 9 Dec 2001 17:58:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Richard Hoechenberger <GeekuX@web.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-pre8 doesn't compile w/ LVM support
Message-ID: <20011209165816.GG28729@suse.de>
In-Reply-To: <20011209175221.A19993@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011209175221.A19993@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09 2001, Richard Hoechenberger wrote:
> Any idea what's causing the problem?

Yes, it's the new block interface which LVM hasn't been converted to
yet. It'll most likely be a while before LVM works in 2.5, so far noone
has stepped up and taken an interest in fixing it.

-- 
Jens Axboe

