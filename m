Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQLNSIr>; Thu, 14 Dec 2000 13:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLNSIh>; Thu, 14 Dec 2000 13:08:37 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:65286 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S129289AbQLNSIZ>;
	Thu, 14 Dec 2000 13:08:25 -0500
Date: Thu, 14 Dec 2000 11:38:40 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <20001214021044.C6380@work.bitmover.com>
Message-ID: <Pine.LNX.4.21.0012141137340.26708-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > There is a large perception of CORBA being slow, but for the most part it
> > > is unjustified.  
> 
> Really?  I have that same perception but I can't claim that I've measured it.
> On the other hand, I have measured the overhead of straight UDP, TCP, and
> Sun RPC ping/pong tests and you can find the code for that in any version
> of lmbench.  It should be a 5 minute task for someone who groks corba to
> do the same thing using the same framework.  If someone wants to do it,
> I'll guide them through the lmbench stuff.  It's pretty trivial, start 

Urm... thanks for the offer... but you misunderstand me if you think that
I'm claiming that kORBit is the ideal/fast implementation that everyone
has been looking for.  There is still much to be done.  :)

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
