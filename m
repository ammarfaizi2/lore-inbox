Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281457AbRKFErR>; Mon, 5 Nov 2001 23:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278041AbRKFErH>; Mon, 5 Nov 2001 23:47:07 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:16002 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S281457AbRKFEq4>;
	Mon, 5 Nov 2001 23:46:56 -0500
Message-ID: <3BE76B25.F670E250@pobox.com>
Date: Mon, 05 Nov 2001 20:46:29 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Tux mailing list <tux-list@redhat.com>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Thomas Lussnig <tlussnig@bewegungsmelder.de>,
        linux-kernel@vger.kernel.org,
        khttpd mailing list <khttpd-users@zgp.org>
Subject: Re: [khttpd-users] khttpd vs tux
In-Reply-To: <Pine.LNX.4.33.0111051013230.2914-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Thanks for commenting on this -

Ingo Molnar wrote:

> On Sat, 3 Nov 2001, J Sloan wrote:
>
> > Nobody scales better 1-4 CPUs, as indicated
> > by specweb99 - at 8 CPUs linux is OK, but not
> > as dominating....
>
> This is a common misinterpretation of the TUX SPECweb99 numbers.
> Performance and scalability are two distinct things.

Absolutely correct, I spoke sloppily.
I should have said, "nobody performs better...".

But the scalability certainly _appears_
to be better than average -

> TUX maxes out 2-way and 4-way systems as well, while IIS does not appear
> to do a good job there. So we can say that it's proven that IIS does not
> scale well. I can still not say whether Linux+TUX scales well, i can only
> say that it's too fast for the given hardware :-)

indeed...

> why does it look like as if TUX scaled well on 1, 2, 4 CPUs? Because
> hardware designers are sizing up systems with more CPUs, so the true
> limits of the hardware show a similar scalability graph as the scalability
> graph would be of a scalable webserver.

Excellent point, thanks for making the distinction.

Thanks as well for the other excellent insights,
it was informative to hear what you had to say.

cu

jjs

