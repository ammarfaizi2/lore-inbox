Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291072AbSBGCWl>; Wed, 6 Feb 2002 21:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291075AbSBGCWb>; Wed, 6 Feb 2002 21:22:31 -0500
Received: from [208.147.64.186] ([208.147.64.186]:18677 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S291072AbSBGCVt>; Wed, 6 Feb 2002 21:21:49 -0500
Date: Wed, 6 Feb 2002 13:55:02 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Daniel Egger <degger@fhm.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Please add me to the kernel change distribution list
In-Reply-To: <1013024988.27753.28.camel@sonja>
Message-ID: <Pine.LNX.4.44.0202061350030.26707-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is not a linux vs. windows issue.

it's an issue of paranoid firewall companies not allowing unknown stuff
through. I am behind a Raptor firewall running on Solaris that has the
same problem. the first new version of the software that has been released
since the ECN stuff went from proposal to draft was released last week and
does support this. it will take some time for everyone to migrate to new
versions of software.

and I for one would not want firewall vendors to program their firewalls
to allow all proposed standard changes through them. expecting firewalls
to allow stuff the day it is accepted into draft status is not reasonable
either.

yes firewalls need to be updated to reflect changes in the standards, but
these updates should be able to happen as part of the normal
development/release cycle.

David Lang



 On 6 Feb 2002, Daniel Egger wrote:

> Date: 06 Feb 2002 20:49:48 +0100
> From: Daniel Egger <degger@fhm.edu>
> To: linux-kernel@vger.kernel.org
> Subject: Re: Please add me to the kernel change distribution list
>
> Am Mit, 2002-02-06 um 17.45 schrieb Matti Aarnio:
>
> >   Can't.  COMPAQ is one of those companies which have covered their
> > incoming email systems with firewalls rejecting connections with IP-
> > header option bits that were "reserved, set to zero when sending" for
> > first about 20 years, but which now got other specification.
> > (The firewall makers made an error and tought it to mean: "reserved,
> >  must forever be zero".)
>
> I had been once behind one of their firewalls and it's like hell on
> earth; Even trivial actions like ssh'ing somewhere or getting the
> kernel sources caused problems. Maybe Compaq should reconsider their
> security policy and work more with Linux instead of Windows to get a
> clue.
>
> --
> Servus,
>        Daniel
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
