Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287169AbRL2JaQ>; Sat, 29 Dec 2001 04:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287171AbRL2JaG>; Sat, 29 Dec 2001 04:30:06 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:60429 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287169AbRL2J3z>;
	Sat, 29 Dec 2001 04:29:55 -0500
Date: Sat, 29 Dec 2001 20:24:37 +1100
From: Anton Blanchard <anton@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
        Keith Owens <kaos@ocs.com.au>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011229092437.GA1295@krispykreme>
In-Reply-To: <20011227180148.A3727@work.bitmover.com> <E16JxmP-0000Yo-00@the-village.bc.nu> <20011228094318.B3727@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011228094318.B3727@work.bitmover.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Taking nothing away from Tridge, I like Tridge, I'd like to see numbers.
> I'm sure that Tridge's stuff is great, but we were very motivated to 
> go well beyond the normal effort when we wrote this code.

How large is your core db stuff? The thing I like about tdb is that it
is very simple, only recently growing over 1024 lines.

Anton
