Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263923AbTCWVfz>; Sun, 23 Mar 2003 16:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263924AbTCWVfy>; Sun, 23 Mar 2003 16:35:54 -0500
Received: from cygnus-ext.enyo.de ([212.9.189.162]:15626 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S263923AbTCWVfx>;
	Sun, 23 Mar 2003 16:35:53 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ptrace hole / Linux 2.2.25
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 23 Mar 2003 22:46:57 +0100
In-Reply-To: <1048458288.10712.78.camel@irongate.swansea.linux.org.uk> (Alan
 Cox's message of "23 Mar 2003 22:24:49 +0000")
Message-ID: <87of41ah7y.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) Emacs/21.2 (gnu/linux)
References: <20030323194012$6886@gated-at.bofh.it>
	<20030323194014$66c3@gated-at.bofh.it>
	<20030323195010$5026@gated-at.bofh.it>
	<20030323195012$6f30@gated-at.bofh.it>
	<20030323200029$737b@gated-at.bofh.it>
	<20030323202005$2a74@gated-at.bofh.it> <87znnlakmc.fsf@deneb.enyo.de>
	<1048458288.10712.78.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sun, 2003-03-23 at 20:33, Florian Weimer wrote:
>> Well, this is a problem which will be fixed over time.  Amorphous
>> distributions such as Debian will no longer be notified first, and
>
> Why would anyone do that.

Read the IIS rationale for not contacting Apache.

For a different perspective, ask some folks who are involved in the
current IIS issue.  There are many reasons nowadays to restrict
information to non-citizens.

I'm not saying that this is reasonable, but there will always be
people unable to make a rational, informed decision, and if things get
irrational, those without the big pockets tend to lose.

Anyway, the current way security issues are handled will last a year,
maybe two.  I'm not sure in which direction it will evolve, either far
more anarchistic (unlikely), or completely regulated (very likely, I
smell a lot of money down that road).

> Debian is a bunch of amateurs true, but they happen to be a bunch of
> extremely professional amateurs when it comes to security.

I'm not in a position to judge this because the process is too closed.
But in general, they seem to do a good job, I agree.

> If you get it wrong stuff leaks, take a look at the latest CERT fiasco

I don't think things were different if the issues were revealed in a
coordinated manner in June or July.  You can't really fix it anyway
and my Kerberos guru tells me that the community has known for ages
that Kerberos 4 was broken at the protocol level.  Nobody was bothered
enough to write it down, though.

And CERT/CC deliberately leaks stuff to unrelated parties, you know.
This time, you just don't have to pay for it.
