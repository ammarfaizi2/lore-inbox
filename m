Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289118AbSANW2Y>; Mon, 14 Jan 2002 17:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289116AbSANW2T>; Mon, 14 Jan 2002 17:28:19 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:5 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289102AbSANW0d>; Mon, 14 Jan 2002 17:26:33 -0500
Date: Mon, 14 Jan 2002 14:32:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
In-Reply-To: <20020114165909.A20808@thyrsus.com>
Message-ID: <Pine.LNX.4.40.0201141430070.933-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Eric S. Raymond wrote:

> Scenario #3: Penelope goes where the geeks are surfing.
>
> The girl geek Melvin noticed over at the computer lab is named
> Penelope.  She's studying proteomics, and runs Linux on the laptop she
> just bought because Linux supports the best software she can afford
> for modeling protein folding.
>
> Penelope is what the trade rags call a "power user".  She's pretty
> bright, and likes computers, but she's got more important things to
> think about than the details of how to configure a kernel.  Like
> getting a better handle on the effect of van der Waals forces on alpha
> sheets, or the latest paper on ribosomal electron transport, or why
> she can't seem to meet men who don't bore the crap out of her even in
> a fair-sized college town.
>
> She's just heard about a PCMCIA card that has a MEMS array of chemical
> sensors on it.  The thing could replace the bulky, balky
> gel-chromatography setup she's using now, and make it unnecessary for
> her to fight other students for bench time.  There's even a Linux
> driver for the card (and user-space utilities to talk to it) on one of
> the bio sites she uses -- way too specialized an item for her distro
> to carry, and anyway she doesn't want to wait for the next release.
>
> Penelope needs to build a kernel to support her exotic driver, but she
> hasn't got more than the vaguest idea how to go about it.  The
> instructions with the driver source patch tell her to apply it at the
> top level of a current Linux source tree and then just say "build the
> kernel" before getting off into technicalia about the user-space
> tools.
>
> She could ask that guy who's been eyeing her over at the computer lab
> for help; Penelope knows what a penguin T-shirt means, and he's not
> too bad-looking, if a bit on the skinny side.  On the other hand, she
> knows that guys like that tend to take over the whole process when
> they're trying to be helpful; they can't help displaying their prowess
> and doing more than you asked for, it's biologically wired in.  And
> she's learned that letting someone else take over maintaining your
> equipment properly in a way you don't understand is a good way to have
> it flake out on you just short of a deadline.
>
> On the third hand, she really *doesn't* want to spend her think time
> absorbing a bunch of irrelevant hardware details just to get the one
> driver she needs up and running.  What she needs is some fast,
> hassle-free technological empowerment, not Yet Another Learning
> Experience. (And a boyfriend would be nice too, while she's wishing.)
>
> If Penelope learns from the README file that all *she* has to do is
> type "configure; make" to build a kernel that supports her hardware,
> she can apply that MEMS card patch and build with confidence that the
> effort is unlikely to turn into an infinite time sink.
>
> Autoconfigure saves the day again.  That guy in the penguin T-shirt
> might even be impressed...


With todays lack of hooking methods you do want to give up even this one ?!
Damn you ... :-)




- Davide


