Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268150AbRHFMgF>; Mon, 6 Aug 2001 08:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268218AbRHFMf4>; Mon, 6 Aug 2001 08:35:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26464 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268150AbRHFMfk>; Mon, 6 Aug 2001 08:35:40 -0400
Date: Mon, 6 Aug 2001 14:36:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: "David S. Miller" <davem@redhat.com>,
        David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: /proc/<n>/maps growing...
Message-ID: <20010806143603.C20837@athlon.random>
In-Reply-To: <997080081.3938.28.camel@typhaon> <20010806105904.A28792@athlon.random> <15214.24938.681121.837470@pizda.ninka.net> <20010806125705.I15925@athlon.random> <20010807002650.B23937@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010807002650.B23937@weta.f00f.org>; from cw@f00f.org on Tue, Aug 07, 2001 at 12:26:50AM +1200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 12:26:50AM +1200, Chris Wedgwood wrote:
> mmap does merge in many common cases.

(assuming you speak about 2.2 because 2.4 obviously doesn't merge
anything and that's the point of the discussion) So what? What do you
mean with your observation?

Andrea
