Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129770AbQKYSoj>; Sat, 25 Nov 2000 13:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129648AbQKYSoa>; Sat, 25 Nov 2000 13:44:30 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:56590 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S129770AbQKYSoQ>; Sat, 25 Nov 2000 13:44:16 -0500
Date: Sat, 25 Nov 2000 12:10:49 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: J Sloan <jjs@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setting up pppd dial-in on linux
Message-ID: <20001125121049.A29510@vger.timpanogas.org>
In-Reply-To: <20001125003600.A28207@vger.timpanogas.org> <3A1F6EB6.A5E47686@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A1F6EB6.A5E47686@pobox.com>; from jjs@pobox.com on Fri, Nov 24, 2000 at 11:48:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2000 at 11:48:06PM -0800, J Sloan wrote:
> "Jeff V. Merkey" wrote:
> 
> > Anyone out there a whiz at setting up a pppd dialin server?  I am
> > trying to put together an RPM for pppd dialin configurations
> > that will support default Windows NT and Linux dial in clients
> > without requiring the poor user to learn bash scripting, chat
> > scripting, mgetty and inittab configuration, etc.  The steps
> > in setting this up are about as easy as going on a U.N. relief
> > mission to equatorial Africa, and most customers who are
> > "mere mortals" would give up about an hour into it.
> 
> Red Hat's ppp client setup is about a 90 second job

I am using theirs as a base.   Setup's not the issue.  It's the 
chap MD5 authentication for NT clients and the constant 
crashing that's troublesome.  I have it working, just not
with NT clients.

> 
> > I am seeing massive problems with pppd dial-in and IP/IPX
> > routing with problems that range from constant Oops, to
> > the bug infested pppd daemon failing valid MD5 chap
> > authentication.  The HOW-TO's and man pages provide
> > wonderful commentary on all the things about pppd
> > that don't work, but it's not too helpful on getting
> > it to work reliably.  An NT dial-in server takes about
> > 5 minutes to configure on W2K.  Linux takes about 2 days, and
> > won't stay up reliably.
> 
> hmm, an awful lot of ISPs use Linux dialup servers...
> 
> I set up a linux ppp server back in 1996 - things might have
> changed, but it seemed fairly straightforward at the time -
> 
> can't imagine it's gotten worse since then...
> 
> > Who out there is an expert on Linux pppd that would like
> > to help put together some easy configs for standard
> > dial-in scenarios?
> 
> Crunch time for me right now, finals coming right up...

Thank's anyway.  I'll keep working on the bugs.

:-)

Jeff

> 
> I'll bet there's quite a few ISP-savvy admins who could
> lend a hand though -
> 
> jjs
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
