Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270660AbTGNS6s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270709AbTGNS6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:58:47 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:57995 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270660AbTGNS6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:58:45 -0400
Date: Mon, 14 Jul 2003 16:11:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: ajoshi@kernel.crashing.org
Cc: lkml <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org
Subject: Re: radeonfb patch for 2.4.22...
In-Reply-To: <Pine.LNX.4.10.10307141342420.28472-100000@gate.crashing.org>
Message-ID: <Pine.LNX.4.55L.0307141605110.8994@freak.distro.conectiva>
References: <Pine.LNX.4.10.10307141342420.28472-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jul 2003 ajoshi@kernel.crashing.org wrote:

>
>
> On Mon, 14 Jul 2003, Marcelo Tosatti wrote:
>
> >
> > Ah really? I though that his changes were not merged in your 0.1.8 patch.
> >
> > So can I just revert his patch and accept your instead that all of his
> > stuff is in ? Whoaa, great.
>
> Here is an xcept from ChangeLong section of the driver from the patch I
> sent you:
>
> + *     2003-04-12      Mac PowerBook sleep fixes, Benjamin Herrenschmidt,
> + *                     0.1.8
>
> I agree this isn't very descriptive of this other fixes and I can change
> that, but a lot of his Mac changes have been merged in, but apparently
> nobody has taken the time to actually look at that patch.  If there are
> things that are missing then I asked him to tell me, which he has not so I
> assume there are none.

Ben, can you submit a patch against Ani's latest driver which adds all
your fixes, please?

> > Ani, I received complains that you were not accepting patches from Ben. He
> > needs that code in.
>
> This is not true, see the above.  Also, its hard to "accept patches" from
> people if you do NOT recieve any patches from them!  Ben's style is to get
> the maintainers of drivers to go around and search for his personal tree
> and do their own diffs from that tree, instead of him sending a patch to
> the maintainer.

I'vee asked Ben to submit his code against yours 1

>
> > > If so then please let me know, so I don't waste anymore of my time on
> > > this driver and let someone else play these silly games and maintain it.
> >
> > I prefer playing no silly games in the 2.4 stable series, as I've been
> > trying to do so far. If you had accepted Ben's changes in the first place
> > I wouldnt need to apply his patch.
>
> I did accept most all of his changes when this patch was made (originally
> I sent it May 12, which you did not merge into 2.4.21, probably because I
> sent it during the RC stange, but after that you lost the patch ?).

Yes I lost it.

> Since that time, I assume Ben has made some other changes, which I have
> not recieved any word about.
>
> Please don't accuse people of not accpeting patches when that is simply
> not true, as it can be easily said for you too.

I received complains from people I trust. I'm sorry for accusing you of
something you have not made.

Now lets have a 0.1.8 + "ok with you" ben changes patch ?

I will revert Ben patch and apply that instead once we have it.

Seems everyone will be happy that way, right?
