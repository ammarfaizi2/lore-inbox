Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289082AbSAGCdf>; Sun, 6 Jan 2002 21:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289083AbSAGCd0>; Sun, 6 Jan 2002 21:33:26 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:14350 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289082AbSAGCdQ>; Sun, 6 Jan 2002 21:33:16 -0500
Date: Sun, 6 Jan 2002 18:36:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>,
        <mjh@vr-web.de>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] 2.5.2 scheduler code for 2.4.18-pre1 ( was 2.5.2-pre
 performance degradation on an old 486 )
In-Reply-To: <200201070133.CAA03628@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.40.0201061836030.1000-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Mikael Pettersson wrote:

> On Sun, 6 Jan 2002 15:59:05 -0800 (PST), Davide Libenzi wrote:
> >I made this patch for Andrea and it's the scheduler code for 2.4.18-pre1
> >Could someone give it a try on old 486s
>
> Done. On my '93 vintage 486, 2.4.18p1 + your scheduler results in very
> bursty I/O and poor performance, just like I reported for 2.5.2-pre7.

Can you try some changes that i'll tell you ?




- Davide


