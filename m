Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSFLPAh>; Wed, 12 Jun 2002 11:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317290AbSFLPAg>; Wed, 12 Jun 2002 11:00:36 -0400
Received: from mark.mielke.cc ([216.209.85.42]:50951 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S317286AbSFLPAf>;
	Wed, 12 Jun 2002 11:00:35 -0400
Date: Wed, 12 Jun 2002 10:53:55 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: jamal <hadi@cyberus.ca>
Cc: Lincoln Dale <ltd@cisco.com>, Horst von Brand <vonbrand@inf.utfsm.cl>,
        "David S. Miller" <davem@redhat.com>,
        Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
Message-ID: <20020612105355.A20760@mark.mielke.cc>
In-Reply-To: <5.1.0.14.2.20020612224038.0251bd08@mira-sjcm-3.cisco.com> <Pine.GSO.4.30.0206120853320.799-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 09:00:08AM -0400, jamal wrote:
> On Wed, 12 Jun 2002, Lincoln Dale wrote:
> > At 08:33 AM 12/06/2002 -0400, jamal wrote:
> > >If 3 people need it, then i would like to ask we add lawn mower
> > >support that my relatives have been asking for the last 5 years.
> > lawn-mower support sounds like a userspace application to me.
> But we need a new system call support

This is another non-argument not dissimilar to the method of arguing that
David has used up to this point.

If lawn-mower support (whatever that is) is something that people
would use, then perhaps it *should* be added, even if it needs a new
system call. You have not shown a valid argument against your own
sarcastic suggestion, other than an implicit sneer.

There is no evidence that only three people would use a feature that
allows one to measure the exact bandwidth being used by a specific
TCP/IP connection (including retransmissions). There is evidence that
if such a patch was not accepted into the kernel that people that
desired this feature would either reinvent the wheel, because they
could not locate the private patch, likely doing it *wrong* because
they did not have wonderful people such as David to make strategic
suggestions regarding the exact implementation, or that they would
find other less adequate ways of doing something that approximates
what they actually need using existing functionality.

Anyways... I'll drop out of this one as my presence here was only
to try to encourage creativity, not to create any anger. I never
intended to slight David.

I would like to see stronger arguments presented when saying no to a
feature, as they allow me, and others around here, to learn. Cliche's
don't teach me anything, and they make the speaker appear less
qualified. (Appearance may != Reality)

Good work David, and I look forward to seeing clearer objections.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

