Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262220AbSJNW6w>; Mon, 14 Oct 2002 18:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262234AbSJNW6w>; Mon, 14 Oct 2002 18:58:52 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:10931 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262220AbSJNW6v> convert rfc822-to-8bit; Mon, 14 Oct 2002 18:58:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Shawn <core@enodev.com>
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Date: Tue, 15 Oct 2002 01:04:13 +0200
User-Agent: KMail/1.4.3
Cc: Shawn <core@enodev.com>, Christoph Hellwig <hch@infradead.org>,
       Michael Clark <michael@metaparadigm.com>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com> <200210150035.14923.oliver@neukum.name> <20021014175304.A28906@q.mn.rr.com>
In-Reply-To: <20021014175304.A28906@q.mn.rr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210150104.13593.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As I said before, edicts help no one. I appreciate your sentiment, and
> to some degree share it, but you have to take a non-cheerleader look at
> things like this.

I'd be happy if there were no such problem.

> > Besides people who compile their own kernels are not that unimportant.
>
> No one is saying that. No one is even saying that mainline inclusion
> isn't extremely beneficial to EVMS or DM. The question isn't whether DM
> or EVMS would be impacted more positively if it were included. The
> question is whether mainline would be better off including them, and not
> the other way around.
>
> Also, let me define the phrase "better off" to mean "better off W.R.T.
> design, architecture, overall code quality, abstractions in the right
> place, etc etc", and not to mean politically, as in, more users.

While these are important choices, Linux is an OS for practical use
and needs to meet some minimum of necessary features.

> Honestly though, if you aren't able to do the work it takes to be a 3rd
> party patch tester, it's less likely you can properly test or submit
> proper bug reports in the first place.

That's not the problem. There'd be bug reports from half a dozen vendor
kernels, one incorporating lvm2, the other evms and probably several
versions of them plus their own kernel patches.
A gigantic mess.

	Regards
		Oliver

