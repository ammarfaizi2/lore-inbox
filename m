Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVCWQCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVCWQCg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 11:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVCWQCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 11:02:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48305 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261637AbVCWQCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 11:02:32 -0500
Date: Wed, 23 Mar 2005 16:54:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Seger <Mark.Seger@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Process level I/O stats?
Message-ID: <20050323155403.GF16149@suse.de>
References: <42409313.1010308@hp.com> <42419007.6090101@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42419007.6090101@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23 2005, Mark Seger wrote:
> Apologies if this has been discussed recently but I couldn't find 
> anything.  As I've seen others ask over the years, have there been any 
> newer thoughts on when and how this capability might be added?

Several patches have been posted for that, try and search the
linux-kernel archive for per-process io stats.

-- 
Jens Axboe

