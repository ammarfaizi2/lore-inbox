Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268287AbRHFMop>; Mon, 6 Aug 2001 08:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268305AbRHFMof>; Mon, 6 Aug 2001 08:44:35 -0400
Received: from weta.f00f.org ([203.167.249.89]:60304 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S268287AbRHFMoQ>;
	Mon, 6 Aug 2001 08:44:16 -0400
Date: Tue, 7 Aug 2001 00:45:10 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>,
        David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: /proc/<n>/maps growing...
Message-ID: <20010807004510.A23992@weta.f00f.org>
In-Reply-To: <997080081.3938.28.camel@typhaon> <20010806105904.A28792@athlon.random> <15214.24938.681121.837470@pizda.ninka.net> <20010806125705.I15925@athlon.random> <20010807002650.B23937@weta.f00f.org> <20010806143603.C20837@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010806143603.C20837@athlon.random>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 02:36:03PM +0200, Andrea Arcangeli wrote:

    (assuming you speak about 2.2 because 2.4 obviously doesn't merge
    anything and that's the point of the discussion) So what? What do you
    mean with your observation?

for anonymous maps, when it can extend the previos map, mmap will do
so --- it happens to occur quite often in practice




  --cw
