Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265651AbUAMVEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265656AbUAMVEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:04:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:641 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265651AbUAMVCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:02:11 -0500
Date: Tue, 13 Jan 2004 16:04:49 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@suse.cz>
cc: Chuck Campbell <campbell@accelinc.com>, Jamie Lokier <jamie@shareable.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Lennert Buytenhek <buytenh@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
In-Reply-To: <20040113193549.GB294@elf.ucw.cz>
Message-ID: <Pine.LNX.4.53.0401131525290.9807@chaos>
References: <20031218231137.GA13652@gnu.org> <1071823624.5223.1.camel@laptop.fenrus.com>
 <20031221103308.GB3438@mail.shareable.org> <20031221165755.GB12866@openzaurus.ucw.cz>
 <20040113153507.GG14044@helium.inexs.com> <20040113193549.GB294@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004, Pavel Machek wrote:

> Hi!
>
> > > > I know that equivalent code, which is covered by most if not all of
> > > > the patents, is sold by some software companies to product developers
> > > > _in the USA_ without prelicensed patents.  The problem of acquiring
> > > > suitable patent licenses is left to the purchasers.
> > > >
> > > > Rationally I would expect that if someone is able to sell code and
> > > > leave the problem of patent licensing to the purchaser, then one
> > > > should be able to _give away_ code and leave the problem of patent
> > > > licensing to the recipient.
> > >
> > > As far as I can see, it is okay to ignore patents *if
> > > you are doing research*. So you should be able to offer
> > > it to US people for research purposes.
> >
> > According to recently passed legislation, this may no longer be true.  It
> > remains to be tested, but my understanding is that this "research" shield
> > is now gone.
>
> Time to move to Cuba?
>
> [Well, I thought that explicit reason for patents is "to promote
> research", and it used to be okay to improve upon someone else's
> patent. If patents no longer serve that purpose (if you can't improve
> upon someone elses work, it is worse than he keeping it secret; and
> patents were made so that people would not keep stuff secret), perhaps
> its time to ask if they are still constitutional?]
> 								Pavel
>

According to current Patent Law in the United States;

FYI: Read

http://www4.law.cornell.edu/uscode/35/273.html

You infringe just by smelling like a patent. However, there
are lots of defenses to infringement: prior art, prior reduction
to practice, practically anything done in "good faith", i.e., use
of a process that was not known to be patented. Good faith is
required to show that infringement was stopped as soon as the
inventor brought the infringement to the attention of the
infringer, etc.

Basically, you do NOT have to check to see if your "process" or
whatever has been previously invented. You do, however, need to
stop infringing as soon as such infringement becomes known.

For that reason, it is my opinion (not the opinion of any court,
or officer of the court) that a search for possible patent
infringements can only lead to hardship. You might find an
infringement that was never enforced or is not enforceable,
forcing you to rewrite stuff that is "common public knowledge".
Or you might find that everything is original and, therefore have
a false sense of security (Santa Claus Operations ^M^MSCO^M^M might
sue you anyway....)

For patents that have been secured by a company, but made secret
by the government, you certainly have no way of knowing if an
invention exists. For instance, it is common knowledge that the
transistor was invented by Bill Shockley and John Bardeen at
AT&T in 1948.  However, arming mechanisms for torpedos, used
in WWII, used transistors. The boards containing them had a
US Navy Anchor stamp, marked 1945, 3 years before they were
invented. This was my source of transistors, from Eli Hefferon's
electronic scrap, as a boy!

Also, when I made a  solid-state rate-gyro as a high school
Science Fair project, I got a cease and desist order from a
federal court in New York, because Sperry claimed that what
I developed was their secret invention... Go figure.

It was many years later that I understood that the "acoustic gyro"
I made  as a kid used the same principles as the strap-down-laser-gyro
that Sperry had developed for ICBMs. The government apparently thought
that my project would make obvious to "the enemy" what was obvious to
all my class-mates, --hardly an earth shaking invention.

Basically do what original thought, review of published documentation,
and ordinary care lets you do. Don't waste time worrying about suits
from the ass^M^Mrectums that exist. If they want to sue, they will.
If they don't, they won't. They won't let facts get in the way.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


