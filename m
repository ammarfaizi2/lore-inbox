Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131022AbRBJNJI>; Sat, 10 Feb 2001 08:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130918AbRBJNI6>; Sat, 10 Feb 2001 08:08:58 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:2054 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131418AbRBJNIs>; Sat, 10 Feb 2001 08:08:48 -0500
Date: Sun, 11 Feb 2001 02:08:45 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Daniel Stone <daniel@kabuki.eyep.net>
Cc: Chris Mason <mason@suse.com>, David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <20010211020845.B9570@metastasis.f00f.org>
In-Reply-To: <479040000.981564496@tiny> <E14QkfM-0004EL-00@piro.kabuki.eyep.net> <20010211020200.A9570@metastasis.f00f.org> <E14RZiG-0001s1-00@piro.kabuki.eyep.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14RZiG-0001s1-00@piro.kabuki.eyep.net>; from daniel@kabuki.eyep.net on Sun, Feb 11, 2001 at 12:05:12AM +1100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2001 at 12:05:12AM +1100, Daniel Stone wrote:

    Actually, I meant to say my hard drive crashing.
    I have two hard drives, side-by-side, and sometimes they overheat and
    one of them powers down due to the excess heat.

OK then... if it weren't for the fact other people have reported
similar problems I would say all bets are off. mbox files get
corrupted when machines crash because of their (mis)design; might
this be the case for you here? Or do you see corruption without hard
drive crashes and OS crashes?

It's pretty much impossible to debug and test software when the
hardware if unreliable or unpredictable.


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
