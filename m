Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130418AbRBMGwK>; Tue, 13 Feb 2001 01:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130534AbRBMGwA>; Tue, 13 Feb 2001 01:52:00 -0500
Received: from dsl-45-165.muscanet.com ([208.164.45.165]:8917 "EHLO grace")
	by vger.kernel.org with ESMTP id <S130532AbRBMGvx>;
	Tue, 13 Feb 2001 01:51:53 -0500
Date: Tue, 13 Feb 2001 00:51:28 -0600 (CST)
From: Josh Myer <jbm@joshisanerd.com>
To: george anzinger <george@mvista.com>
cc: "Michael B. Trausch" <fd0man@crosswinds.net>,
        Tom Eastep <teastep@seattlefirewall.dyndns.org>,
        linux-kernel@vger.kernel.org
Subject: Re:  Major Clock Drift
In-Reply-To: <3A88A335.E8E41626@mvista.com>
Message-ID: <Pine.LNX.4.21.0102130047210.23828-100000@grace>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

When i originally posted this, it was _highly_ OT. the machine in question
runs windows ME, but i figured the best place to find hardware gurus was
here.

the topic has rather degraded, and while i enjoy getting mail from alan,
the fact that it has nothing to do with me dampens the enthusiasm =)

if you're going to go changing the subject, at least mention framebuffers,
as that seems to be the common thread.

if you all could de-cc me on these, it'd be appreciated.
--
- josh

On Mon, 12 Feb 2001, george anzinger wrote:

> I may be off base here, but the problem as described below does _NOT_
> seem to be OT so I removed that from the subject line.  A clock drift
> change with an OS update is saying _something_ about the OS, not the
> hardware.  In this case it seems to be the 2.4.x OS that is loosing
> time.  I suspect the cause is some driver that is not being nice to the
> hardware, either by abusing the interrupt off code or locking up the bus
> or some such.  In any case I think it should _not_ be considered OT.
> 
> George

--
/jbm, but you can call me Josh. Really, you can.
  Rap-Rock is neither Modern nor Alternative.
             Not that I'm bitter.


