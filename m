Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbTBYBua>; Mon, 24 Feb 2003 20:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbTBYBua>; Mon, 24 Feb 2003 20:50:30 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:31906
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S266932AbTBYBu2>; Mon, 24 Feb 2003 20:50:28 -0500
Message-ID: <3E5ACE4C.5080908@tupshin.com>
Date: Mon, 24 Feb 2003 18:00:44 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Server shipments [was Re: Minutes from Feb 21 LSE Call]
References: <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <1630000.1046072374@[10.10.2.4]> <20030224161716.GC5665@work.bitmover.com> <12680000.1046105345@[10.10.2.4]> <20030225004113.GB12146@work.bitmover.com> <351250000.1046133664@flay> <20030225005451.GC12146@work.bitmover.com>
In-Reply-To: <20030225005451.GC12146@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This conversation has not only gotten out of hand, it's gotten quite
silly. People are arguing semantics and relative economic value where a
few simple assertions should do:

1) There is a significant interest from developers and users in having
Linux run efficiently on *small* platforms.
2) There is a significant interest from developers and users in having
Linux run efficiently on *large* platforms.
3) There is disagreement on whether it is possible to accomplish 1 and 2
simultaneously.
4) There is disagreement on whether adequate testing is taking place to
make sure 2 doesn't degrade 1(or vice versa).

This leads to two choices:
a) Fork. Obviously to be avoided at all reasonable costs.
b) Identify reasonable improvements to the testing methodology so that
any design conflicts are identified immediately instead of gradually
accumulating and degrading performance over time.

I vote b(surprise surprise), however, this just changes the debate to
"what is reasonable testing methodology?" This, however is a debate much
more worth having than "who ships more of what" and "who said what when".

Given that a fairly thorough performance testing suite is already in
place, it would seem to be up to the advocates for the "threatened"
computing environment (large or small) to convince the "testers that be"
that certain tests should be added. It is inherently unreasonable to
expect the developer of a feature/change to be unbiased and neutral with
respect to that feature, therefore it is unreasonable to expect them to
prove beyond a reasonable doubt that their feature has no negative
impact. The best that they can do is convince themselves that the
feature passes the really deep sniff test. The rest is up to the
community. The ability of a third party to critique code changes is a
large part of why the bazaar nature of linux development is so valuable.

-Tupshin


