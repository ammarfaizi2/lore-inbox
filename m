Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267620AbRG0PDj>; Fri, 27 Jul 2001 11:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267602AbRG0PC3>; Fri, 27 Jul 2001 11:02:29 -0400
Received: from weta.f00f.org ([203.167.249.89]:59525 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267620AbRG0PCX>;
	Fri, 27 Jul 2001 11:02:23 -0400
Date: Sat, 28 Jul 2001 03:02:55 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010728030255.A804@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl> <0107270818120A.06707@widmers.oce.srci.oce.int> <3B6180CD.9D68CC07@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B6180CD.9D68CC07@namesys.com>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 06:55:09PM +0400, Hans Reiser wrote:

    Don't use RedHat with ReiserFS, they screw things up so many
    ways.....

    For instance, they compile it with the wrong options set, their
    boot scripts are wrong, they just shovel software onto the CD.

    Use SuSE, and trust me, ReiserFS will boot faster than ext2.

    Actually, I am curious as to exactly how they manage to make
    ReiserFS boot longer than ext2.  Do they run fsck or what?

FWIW, Debian although it doesn't support reiserfs "out of the box" at
present, works flawlessly for a large number of people I know.  I also
hear Mandrake 7.2 and 8.0 work pretty nice if you want a pointy-clicky
experience :)

Since so many people seem to run RedHat, perhaps it's worth someone
determining exactly what is busted with their init scripts or whatever
that makes reiserfs barf more often that with other distributions.



  --cw
