Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310776AbSCPVvy>; Sat, 16 Mar 2002 16:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310788AbSCPVvp>; Sat, 16 Mar 2002 16:51:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61706 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310776AbSCPVva> convert rfc822-to-8bit; Sat, 16 Mar 2002 16:51:30 -0500
Date: Sat, 16 Mar 2002 13:49:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <yodaiken@fsmlabs.com>
cc: Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020316143916.A23204@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0203161342190.24457-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g2GLncN29178
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Mar 2002 yodaiken@fsmlabs.com wrote:
>
> If you want to optimize for gnome, you get a very different
> layout. But Hammer and ia64 are supposedly designed for huge
> databases, routing tables, and images.

Yeah, and I'm claiming that databases etc count for a whole lot less than
most other apps.

> What's the "common case" for 64 bit ? Do you really think it will
> be on desktop soon?

Oh, not Itanium for sure. But if AMD succeeds even reasonably with Hammer,
Intel will certainly see the error of its ways (except they won't admit
it) and make their version of a 64-bit P4 core available. They're
reportedly working on it already, just in case the Itanic sinks (and
judging by current market behaviour it certainly isn't flying).

> > In short, youäre
>
> Don't use umlauts unless you are ready to back it up.

That's not an umlaut, that's an "ä", which is a real letter in Finnish and
Swedish (it just _looks_ like an a with an umlaut to you uncultured
people), and it happens to be a letter that is just left of the ' mark on
a Finnish keyboard.

		Linus

