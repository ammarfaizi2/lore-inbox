Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288947AbSAETl6>; Sat, 5 Jan 2002 14:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288946AbSAETls>; Sat, 5 Jan 2002 14:41:48 -0500
Received: from web20504.mail.yahoo.com ([216.136.226.139]:24837 "HELO
	web20504.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S288941AbSAETlk>; Sat, 5 Jan 2002 14:41:40 -0500
Message-ID: <20020105194140.67038.qmail@web20504.mail.yahoo.com>
Date: Sat, 5 Jan 2002 20:41:40 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Linux Kernel-2.4.18-nj1
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020105180601.GC756@cpe-24-221-152-185.az.sprintbbd.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tom,

> I'd actually argue against this.  When Alan picked
> up 2.2.x, there wasn't someone else doing an -ac'ish
> 2.2 release as well.

Right, but at 2.2 times, there were less features and
less users than now. Preemption, PNPBios, Tux,
schedulers, additionnal filesystems are many features
that interest lots of people. Not that Alan did
include
them all either, but at least he gave the opportunity
to test some of them (think about ext3 and pnpbios).

> Marcelo is doing 2.4.x now, and seems to be doing a
> good job of making sure stable stuff gets in, and
> other stuff doesn't. The only patches that won't
> make it into Marcelos tree in the very-near-term
> (Which is all I'll speculate about) are the preempt
> (and lock-break) patches.

I totally agree. And that's why I find it still
acceptable to have one tree (and not 1000) to test
other features such as the ones above, so a large set
of users can test them (eg: filesystems).
 
> Please people, more trees are not always a better
> thing when you're all doing the same thing.

Perhaps people who have a solid personal tree would
like to continue this discussion off-list and find
an arrangement about a single test tree. Concerning
stable trees, I think that both Marcello's and
Andrea's are rock solid. Othe people may want to use
their distributor's.

I'll stop here to avoid decreasing the s/n ratio too
much. Off-list correspondance OK.

Regards,
Willy

PS: I really like your domain name, it could have been
    dedicated to my tree :-)


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
