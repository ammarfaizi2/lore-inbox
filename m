Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbTLKPNN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbTLKPNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:13:12 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:13029 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265102AbTLKPND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:13:03 -0500
Subject: Re: Linux GPL and binary module exception clause?
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Pimlott <andrew@pimlott.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
       Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20031211135422.GA4315@pimlott.net>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
	 <20031205004653.GA7385@codepoet.org>
	 <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com>
	 <20031205010349.GA9745@codepoet.org>
	 <20031205012124.GB15799@work.bitmover.com>
	 <Pine.LNX.4.58.0312041750270.6638@home.osdl.org>
	 <1071146277.5712.589.camel@hades.cambridge.redhat.com>
	 <20031211135422.GA4315@pimlott.net>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1071155568.5712.686.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.1) 
Date: Thu, 11 Dec 2003 15:12:49 +0000
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-11 at 08:54 -0500, Andrew Pimlott wrote:
> NAL, but look up "misuse of copyright".  You can't just require
> whatever pleases your fancy.

>     http://www.digital-law-online.com/lpdi1.0/cases/15PQ2D1846.htm

The misuse of copyright defence: It is forbidden to use a patent or
copyright 'to secure an exclusive right or limited monopoly not granted
by the [Patent/Copyright] office and which it is contrary to public
policy to grant.'

It's _not_ just about conditions which are 'unreasonable' (cf. contract
law). In particular, the 'public policy' to which the court was
referring was the raison d'etre of copyright and patent law -- the
encouragement of creativity and development for the general benefit of
society.

So the hypothetical Creosote Public Licence should be fine.

In the case you cite, the licence was prohibiting the licensee (and even
others) from creativity which might benefit society:

	"Each time Lasercomb sells its Interact program to a company
	and obtains that company’s agreement to the noncompete
	language, the company is required to forego utilization of
	the creative abilities of all its officers, directors and
	employees in the area of CAD/CAM die-making software. Of yet
	greater concern, these creative abilities are withdrawn from
	the public. The period for which this anticompetitive
	restraint exists is ninety-nine years, which could be longer
	than the life of the copyright itself."

Even my other hypothetical licence, which requires you to release _all_
your future work under an open-source licence, does _not_ stop you from
benefiting society by being creative. It just makes requirements about
the _licensing_ of what you create.

Neither does the same licence create an exclusive right or limited
monopoly for the licensor -- quite the opposite, in fact, since it's
asking the licensee to do the _same_ as the licensor, not enforcing any
_difference_ in permitted behaviour.

I don't believe that a prosecution for violation of such a licence would
fall foul of the 'misuse of copyright' defence, either.

Furthermore, no other arrangement exists which allows you to make (other
than fair) use of the work in question. You didn't pay the licensor for
it and get lumbered with these extra clauses on the side -- the
hypothetical licence _only_ asks that you license your own creations in
a certain way, and asks nothing else.

This is not a 'normal' commercial software agreement with some
unreasonable clause tacked on the side; you get to use my software
_only_ because you agreed to these conditions and I didn't ask anything
else of you. A court _would_ take that into account. 

> > I could write a piece of software and tell you that you're only allowed
> > to use it if you release _all_ future software you write under the GPL.
> > Even stuff which isn't at all related, let alone non-derived.
> 
> Highly doubtful.

In the case where I accept financial reward from you and we enter into
any kind of agreement, I'm inclined to agree.

But in the case where no money (or other consideration) has been
exchanged, I very much doubt that a court would rule that my work
effectively becomes public domain -- the court might not award me
damages but you would not be permitted to use my work. 

-- 
dwmw2

