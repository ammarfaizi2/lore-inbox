Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSCRQhA>; Mon, 18 Mar 2002 11:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286521AbSCRQgv>; Mon, 18 Mar 2002 11:36:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8576 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S284933AbSCRQgj>; Mon, 18 Mar 2002 11:36:39 -0500
Date: Mon, 18 Mar 2002 11:36:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Nayyer Tiger <tigerkhan_1@hotmail.com>, faheemullahkhan101@aol.com,
        zohair420@hotmail.com, danish4000@hotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help
In-Reply-To: <Pine.LNX.4.33L2.0203180809120.2434-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.3.95.1020318112042.740A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, Randy.Dunlap wrote:

> On Mon, 18 Mar 2002, Nayyer Tiger wrote:
> 
> | I see that in the very latest Configure.help version, 2.76, available at
> | http:/www.tuxedo.org/~esr/cml2/
> | Eric has decided to follow the following standard:
> | IEC 60027-2, Second edition, 2000-11, Letter symbols to be used in
> | electrical technology - Part 2: Telecommunications and electronics.
> | and has changed all the abbreviations for Kilobyte (KB) to KiB, Megabyte
> | (MB) to MiB, etc, etc.
> |
> | Now, granted that this is the "standard", should there be some discussion
> | related to this
> | change, or is everyone comfortable with this?  It certainly made me do a
> | double take.
> 
> Either decision will be disliked.  I don't care for the new/standard
> abbreviations, but I can get used to them, and I expect that most
> people can.
> 
> Let's get over it and back to the good stuff.
> 
> ~Randy
> 

Is it a standard or is it something in-process? The reason I ask is
that neither KB nor KiB can possibly be correct.

According to the standards, where capitalization is used:
	(1) For a proper name.
	(2) To differentiate between otherwise identical symbols.

"KB" would mean:

	Kirchoff-Bell

It needs to be:

	"kb" to mean kilobyte.

In any event, I suggest that whatever exists just be left alone.
Both the present and the proposed changes are incorrect. The
present incorrect symbols are widely used, therefore the intent
is known. The proposed symbols are not widely used and will just
aggravate a sore created by Tech-Writers who can't read or write.

We have seen, in recent years, a continual change in English Language
usage where, what was once considered absolutely wrong, is now considered
correct. For instance double-negatives like "irregardless" are now
even codified by insertion into the dictionary. FYI, it is either
"regardless" or "irrespective". It can't be "irregardless".

So, let's let sleeping dogs lie. Oh yes, contractions are now getting
clobbered too. It is now acceptable to spell "dont" without the
apostrophe! I think Alan had something to do with that.... ;)


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

