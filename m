Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbUJZA6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbUJZA6S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUJZA6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 20:58:17 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:22704 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261835AbUJZA5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 20:57:55 -0400
Date: Tue, 26 Oct 2004 02:58:27 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK kernel workflow
Message-ID: <20041026005827.GQ14325@dualathlon.random>
References: <4d8e3fd304102403241e5a69a5@mail.gmail.com> <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random> <pan.2004.10.25.19.51.30.753221@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.10.25.19.51.30.753221@smurf.noris.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 09:51:31PM +0200, Matthias Urlichs wrote:
> Wrong. Since when does usage constitute "tainted" knowledge?
> You get tainted knowledge by looking at source code, not by usage.

come on, as someone stated in other thread the licence doesn't even
appear legal in europe, so what do you expect?

> By the same token, users of MS Office, which is even more restrictively
> licensed than BK (no free use whatsoever, remember?), couldn't work on
> OpenOffice.org.

Note that if I would be buying a BK non-free licence the "restrictions"
would go away AFIK. However Miles (on the arch list) tries to buy one
(exactly so he could test BK) and he failed to get one.

"no free use" may be less restrictive than the "free licence". You pay
to get more freedom, which sounds fair.

> The license says that, if you work on a competing system, you cannot use
> BK. It cannot prevent somebody who has used BK sometime in the past, from
> writing an SCM sometime in the future, since the license governs only your
> use of BK, but not whatever else you're doing. It's a license for
> BitKeeper and not for anybody's brain, after all.

either you're completely wrong or Larry did not protect any IP.

Larry said in an earlier email today: "we have to protect our IP.
Rightly or wrongly, we feel we did some new work that is worth
protecting.".

don't get me wrong, I've nothing against protecting IP, but my point is
how can he protect IP if I can use BK, learn all the features, then the
next day I stop using them and contribute to another SCM after the
knowledge learned? I mean, there must be a delay between the two events
otherwise what a protection is that. I can use BK the next second I stop
using BK and I make a patch to arch, the next second I use BK again.

I would be *very* happy if you were right in the way you interpret the
licence, if Larry could confirm you didn't misread the licence, I could
sure use bitkeeper too (at least to try it once, you know I may be
curious about testing bk speed after all these talks).

But I'm not attempting that unless Larry confirms I can learn using bk
and immediatly after I can contribute to arch or some other SCM to
possibly implement overlapping features (and so far I clearly understood
this was not possible, and this is also why it didn't look legal in
europe but IANAL).
