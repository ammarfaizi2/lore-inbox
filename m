Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290701AbSBFRed>; Wed, 6 Feb 2002 12:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290707AbSBFReO>; Wed, 6 Feb 2002 12:34:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10252 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290701AbSBFReD>; Wed, 6 Feb 2002 12:34:03 -0500
Date: Wed, 6 Feb 2002 09:33:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.33.0202061828190.31718-100000@serv>
Message-ID: <Pine.LNX.4.33.0202060931220.19836-100000@athlon.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Feb 2002, Roman Zippel wrote:
>
> On Tue, 5 Feb 2002, Linus Torvalds wrote:
>
> > However, some of it pays off already. Basically, I'm aiming to be able to
> > accept patches directly from email, with the comments in the email going
> > into the revision control history.
>
> Um, what's so special about it, what a shell script couldn't do as well?

About this particular change-set? Nothing. In fact, most of it is
generated from a shell script before it goes into the BK archive.

The advantage is mainly that (a) you can generate this changeset listing
yourself, and not limit it to the stuff I merged and (b) when the
developers I work with start sending me their bitkeeper merges _as_
bitkeeper merges and we start having the advantage of various tools to
help resolve conflicts.

		Linus

