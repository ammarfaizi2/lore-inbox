Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284752AbSAGSHS>; Mon, 7 Jan 2002 13:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284711AbSAGSHJ>; Mon, 7 Jan 2002 13:07:09 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:1810 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284694AbSAGSHD>; Mon, 7 Jan 2002 13:07:03 -0500
Date: Mon, 7 Jan 2002 10:12:02 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jens Axboe <axboe@suse.de>
cc: Mikael Pettersson <mikpe@csd.uu.se>, lkml <linux-kernel@vger.kernel.org>,
        <mjh@vr-web.de>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] 2.5.2 scheduler code for 2.4.18-pre1 ( was 2.5.2-pre
 performance degradation on an old 486 )
In-Reply-To: <20020107083331.C1755@suse.de>
Message-ID: <Pine.LNX.4.40.0201071011010.1612-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Jens Axboe wrote:

> On Sun, Jan 06 2002, Davide Libenzi wrote:
> > On Mon, 7 Jan 2002, Mikael Pettersson wrote:
> >
> > > On Sun, 6 Jan 2002 15:59:05 -0800 (PST), Davide Libenzi wrote:
> > > >I made this patch for Andrea and it's the scheduler code for 2.4.18-pre1
> > > >Could someone give it a try on old 486s
> > >
> > > Done. On my '93 vintage 486, 2.4.18p1 + your scheduler results in very
> > > bursty I/O and poor performance, just like I reported for 2.5.2-pre7.
> >
> > Can you try some changes that i'll tell you ?
>
> Did you _try_ the ISA bounce trick to reproduce locally??

I'll try today even if i think that one of the guy that had problems
pointed out it.




- Davide


