Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289129AbSAGICO>; Mon, 7 Jan 2002 03:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289120AbSAGIB7>; Mon, 7 Jan 2002 03:01:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38418 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289006AbSAGIBp>;
	Mon, 7 Jan 2002 03:01:45 -0500
Date: Mon, 7 Jan 2002 09:00:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
Message-ID: <20020107090047.F1755@suse.de>
In-Reply-To: <Pine.LNX.4.33.0201060349380.3424-100000@localhost.localdomain> <Pine.LNX.4.33.0201051722540.24370-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201051722540.24370-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05 2002, Linus Torvalds wrote:
>   shown more bugs than that, though. I'd happily test a buggy scheduler,
>   but I don't want to mix bio problems _and_ scheduler problems, so I'm

Too late :-)

-- 
Jens Axboe

