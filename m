Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRJaWgi>; Wed, 31 Oct 2001 17:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274990AbRJaWg2>; Wed, 31 Oct 2001 17:36:28 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:10121 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S274875AbRJaWgU>;
	Wed, 31 Oct 2001 17:36:20 -0500
Message-ID: <3BE07D05.3B71B67D@pobox.com>
Date: Wed, 31 Oct 2001 14:36:53 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ville Herva <vherva@niksula.hut.fi>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
In-Reply-To: <3BDDBC90.7E16E492@lexus.com> <20011029151036.F20280@mikef-linux.matchmail.com> <3BDDE422.938C1D95@lexus.com> <20011030102124.H1598@niksula.cs.hut.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vile Hernia wrote:

> BTW, on win95 the HZ is 1024, which caused it to _always_ crash if it ever
> reached 48.5 days of uptime. I've seen NT4 SMP to to crash at same point as
> well (though it doesn't do it always).

It's funny that windoze went for years
without anybody ever realizing about
the 49 day crash - heck, one crash
every 49 days is lost in the noise on
a windoze pee cee - no wonder they
never noticed.

OTOH, when our Linux uptimes went back
to zero at 497 days, I noticed immediately,
and screamed bloody murder until I found
it was just a timer wraparound.

cu

jjs


