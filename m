Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbTBPMoR>; Sun, 16 Feb 2003 07:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbTBPMoR>; Sun, 16 Feb 2003 07:44:17 -0500
Received: from dp.samba.org ([66.70.73.150]:53396 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266609AbTBPMoR>;
	Sun, 16 Feb 2003 07:44:17 -0500
Date: Sun, 16 Feb 2003 23:53:24 +1100
From: Anton Blanchard <anton@samba.org>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] elv_former_request reversion
Message-ID: <20030216125324.GK9833@krispykreme>
References: <20030215161236.67ce3f24.akpm@digeo.com> <20030216093244.GP26738@suse.de> <20030216115908.GY26738@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030216115908.GY26738@suse.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Andrew, does this work for you?

Looks good on my ppc64 box too, it was hitting the BUG() when running
SDET before.

Anton
