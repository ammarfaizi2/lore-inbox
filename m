Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289003AbSAGHeJ>; Mon, 7 Jan 2002 02:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289006AbSAGHdu>; Mon, 7 Jan 2002 02:33:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62225 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289003AbSAGHdh>;
	Mon, 7 Jan 2002 02:33:37 -0500
Date: Mon, 7 Jan 2002 08:33:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, lkml <linux-kernel@vger.kernel.org>,
        mjh@vr-web.de, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] 2.5.2 scheduler code for 2.4.18-pre1 ( was 2.5.2-pre performance degradation on an old 486 )
Message-ID: <20020107083331.C1755@suse.de>
In-Reply-To: <200201070133.CAA03628@harpo.it.uu.se> <Pine.LNX.4.40.0201061836030.1000-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0201061836030.1000-100000@blue1.dev.mcafeelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06 2002, Davide Libenzi wrote:
> On Mon, 7 Jan 2002, Mikael Pettersson wrote:
> 
> > On Sun, 6 Jan 2002 15:59:05 -0800 (PST), Davide Libenzi wrote:
> > >I made this patch for Andrea and it's the scheduler code for 2.4.18-pre1
> > >Could someone give it a try on old 486s
> >
> > Done. On my '93 vintage 486, 2.4.18p1 + your scheduler results in very
> > bursty I/O and poor performance, just like I reported for 2.5.2-pre7.
> 
> Can you try some changes that i'll tell you ?

Did you _try_ the ISA bounce trick to reproduce locally??

-- 
Jens Axboe

