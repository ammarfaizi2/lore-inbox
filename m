Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287572AbSAURie>; Mon, 21 Jan 2002 12:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287595AbSAURiZ>; Mon, 21 Jan 2002 12:38:25 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:50960 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287572AbSAURiR>; Mon, 21 Jan 2002 12:38:17 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 21 Jan 2002 09:44:07 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jens Axboe <axboe@suse.de>
cc: Vojtech Pavlik <vojtech@suse.cz>, Andre Hedrick <andre@linuxdiskcert.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020121115600.X27835@suse.de>
Message-ID: <Pine.LNX.4.40.0201210943120.1579-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Jens Axboe wrote:

> On Mon, Jan 21 2002, Jens Axboe wrote:
> > Time for a new patch...
>
> Actually, then I did get it right in 2.5.3-pre2 so no issues. Only
> problem is the 48-bit addressing nr_sectors bug, however that can't hit
> right now so it's not an issue.
>
> That just leaves Davide's lost interrupt issue, lets look into that
> now...

Guys, am i the only fool in town getting this one ?



- Davide


