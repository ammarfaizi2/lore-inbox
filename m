Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285704AbRLTBR0>; Wed, 19 Dec 2001 20:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285725AbRLTBRQ>; Wed, 19 Dec 2001 20:17:16 -0500
Received: from tierra.ucsd.edu ([132.239.214.132]:402 "EHLO burn")
	by vger.kernel.org with ESMTP id <S285704AbRLTBQ4>;
	Wed, 19 Dec 2001 20:16:56 -0500
Date: Wed, 19 Dec 2001 17:16:31 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: bcrl@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011219171631.A544@burn.ucsd.edu>
In-Reply-To: <E16Gjuw-0000UT-00@starship.berlin> <Pine.LNX.4.33.0112190859050.1872-100000@penguin.transmeta.com> <20011219135708.A12608@devserv.devel.redhat.com> <20011219.161359.71089731.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011219.161359.71089731.davem@redhat.com>; from davem@redhat.com on Wed, Dec 19, 2001 at 04:13:59PM -0800
From: Bill Huey <billh@tierra.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 04:13:59PM -0800, David S. Miller wrote:
> Maybe it's because the majority of people don't care nor would ever
> need to use AIO.  Are you willing to accept this possibly? :-) Linux
> is anything but doomed, because you will notice that the things that
> actually matter for most people are in fact improved and worked on
> within a reasonable timescale.
> 
> Only very specialized applications can even benefit from AIO.  This
> doesn't make it useless, but it does decrease the amount of interest
> (and priority) anyone in the community will have in working on it.

Folks doing serious server side Java and runtime internals would
definitely be able to use this stuff, namely me. It'll remove the
abuse of threading used to deal with large IO systems when NIO comes out
for 1.4. And as a JVM engineer for the FreeBSD community I'm drooling
over stuff like that.

> Now, if these few and far between people who are actually interested
> in AIO are willing to throw money at the problem to get it worked on,
> that is how the "reasonable timescale" will be arrived at.  And if
> they aren't willing to toss money at the problem, how important can it
> really be to them? :-)

Like the Java folks ? few and far between ? What you're saying it just
plain outdated and from a previous generation of thinking that has
become irrelevant as the community has grown.

> Maybe, just maybe, most people simply do not care one iota about AIO.
> 
> Linux caters to the general concerns not the nooks and cranies, that
> is why it is anything but doomed.

Again, Linux collectively has outgrown that thinking and the scope of
what the previous generation of engineers can responsible for, which is
why it's important for folks like Ben should be encourage to take it to
the next level.

bill

