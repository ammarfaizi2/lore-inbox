Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283000AbRK1BMv>; Tue, 27 Nov 2001 20:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282999AbRK1BMm>; Tue, 27 Nov 2001 20:12:42 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:20949 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S283000AbRK1BMe>; Tue, 27 Nov 2001 20:12:34 -0500
Date: Tue, 27 Nov 2001 20:15:16 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
        andrea@suse.de
Subject: Re: VM tests on 5 recent kernels
Message-ID: <20011127201516.A223@earthlink.net>
In-Reply-To: <20011127021513.A228@earthlink.net> <Pine.LNX.4.33.0111270853460.1860-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111270853460.1860-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Nov 27, 2001 at 08:58:51AM -0800
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 08:58:51AM -0800, Linus Torvalds wrote:
> What happens to the MP3 numbers if you run it a few times on the exact
> same kernel?

There is some variance between tests.  On the 5 kernels tested bunch, 
2.4.16 was up for about 1.5 days before it's test was run.  (the other 
kernels were booted before tests) 

2.4.16
mp3 played 372 of 392 seconds (95%) fresh boot
mp3 played 312 of 371 seconds (84%)

2.5.1-pre1 was up for about 18 hours, and I re-ran the test on it.

2.5.1-pre1
mp3 played 361 of 365 seconds (99%) fresh boot
mp3 played 350 of 378 seconds (93%)

It may be normal variance, or fresh boot syndrome.  

-- 
Randy Hron

