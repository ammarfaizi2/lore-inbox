Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282902AbSAUK40>; Mon, 21 Jan 2002 05:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbSAUK4Q>; Mon, 21 Jan 2002 05:56:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18948 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282902AbSAUK4N>;
	Mon, 21 Jan 2002 05:56:13 -0500
Date: Mon, 21 Jan 2002 11:56:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020121115600.X27835@suse.de>
In-Reply-To: <Pine.LNX.4.40.0201201054011.7238-100000@blue1.dev.mcafeelabs.com> <Pine.LNX.4.10.10201201555040.12376-100000@master.linux-ide.org> <20020121114311.A24604@suse.cz> <20020121114830.W27835@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020121114830.W27835@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21 2002, Jens Axboe wrote:
> Time for a new patch...

Actually, then I did get it right in 2.5.3-pre2 so no issues. Only
problem is the 48-bit addressing nr_sectors bug, however that can't hit
right now so it's not an issue.

That just leaves Davide's lost interrupt issue, lets look into that
now...

-- 
Jens Axboe

