Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277653AbRLLLQX>; Wed, 12 Dec 2001 06:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277713AbRLLLQN>; Wed, 12 Dec 2001 06:16:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:64848 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277653AbRLLLP7>; Wed, 12 Dec 2001 06:15:59 -0500
Date: Wed, 12 Dec 2001 12:16:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <20011212121624.B4801@athlon.random>
In-Reply-To: <20011211144223.E4801@athlon.random> <Pine.LNX.4.33L.0112111157410.4079-100000@imladris.surriel.com> <20011211152356.I4801@athlon.random> <E16DooZ-0001J4-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E16DooZ-0001J4-00@starship.berlin>; from phillips@bonn-fries.net on Tue, Dec 11, 2001 at 04:27:23PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 04:27:23PM +0100, Daniel Phillips wrote:
> On December 11, 2001 03:23 pm, Andrea Arcangeli wrote:
> > As said I wrote some documentation on the VM for my last speech at the
> > one of the most important italian linux events, it explains the basic
> > design. It should be published on their webside as soon as I find the
> > time to send them the slides. I can post a link once it will be online.
> 
> Why not also post the whole thing as an email, right here?

I uploaded it here:

	ftp://ftp.suse.com//pub/people/andrea/talks/english/2001/pluto-dec-pub-0.tar.gz

Hopefully it's understandable standalone.

> > It shoud allow non VM-developers to understand the logic behind the VM
> > algorithm, but understanding those slides it's far from allowing anyone
> > to hack the VM.
> 
> It's a start.
> 
> > I _totally_ agree with Linus when he said "real world is totally
> > dominated by the implementation details".
> 
> Linus didn't say anything about not documenting the implementation details, 
> nor did he say anything about not documenting in general.

yes, my only point was that "documentation" isn't nearly enough, and
that it's not mandatory (given all the changes don't affect any user
API), but I certainly agree documentation helps.

Andrea
