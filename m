Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRIYSvi>; Tue, 25 Sep 2001 14:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271769AbRIYSv2>; Tue, 25 Sep 2001 14:51:28 -0400
Received: from [195.223.140.107] ([195.223.140.107]:46830 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268861AbRIYSvR>;
	Tue, 25 Sep 2001 14:51:17 -0400
Date: Tue, 25 Sep 2001 20:51:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 VM vs. 2.4.9-ac14 (+ ac14-aging)
Message-ID: <20010925205143.C8350@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109232255250.14107-100000@loke.as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109232255250.14107-100000@loke.as.arizona.edu>; from ckulesa@as.arizona.edu on Mon, Sep 24, 2001 at 05:08:49AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 05:08:49AM -0700, Craig Kulesa wrote:
> 2.4.10 streaming IO test: failed (stutters, frequent gaps in playback)
> 2.4.10 app test: 30020 kB swapped out; 22308 kB swapped in (cumulative)
> 		 22 second StarOffice load time; 6-7 sec GIMP img rotate

I'd appreciate if you could repeat the test with vm-tweaks-1 applied to
see the difference.

Andrea
