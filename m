Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143938AbRA1Tkh>; Sun, 28 Jan 2001 14:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143939AbRA1Tk2>; Sun, 28 Jan 2001 14:40:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37131 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S143938AbRA1TkZ>;
	Sun, 28 Jan 2001 14:40:25 -0500
Date: Sun, 28 Jan 2001 20:40:02 +0100
From: Jens Axboe <axboe@suse.de>
To: mirabilos <eccesys@topmail.de>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: Q: Release of 2.4.1
Message-ID: <20010128204002.E5522@suse.de>
In-Reply-To: <01a301c0895e$b142cc90$0100a8c0@homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a301c0895e$b142cc90$0100a8c0@homeip.net>; from eccesys@topmail.de on Sun, Jan 28, 2001 at 07:15:13PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28 2001, mirabilos wrote:
> Does 2.4.1 when released, include e.g. Jens' loop patch?

No, I haven't submitted it yet due to the massive restructering. Plus,
it also touches other parts than loop itself.

> Because it seems stable and loop else were buggy.
> So for others if there are.

It needs a bit more testing, and crypto hasn't been verified either.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
