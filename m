Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbRGKIcg>; Wed, 11 Jul 2001 04:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267228AbRGKIc0>; Wed, 11 Jul 2001 04:32:26 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:41967 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S267224AbRGKIcO>; Wed, 11 Jul 2001 04:32:14 -0400
Date: Wed, 11 Jul 2001 11:32:07 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Adam Sampson <azz@gnu.org>
Cc: Rob Landley <landley@webofficenow.com>, linux-kernel@vger.kernel.org
Subject: Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))
Message-ID: <20010711113207.H1419@niksula.cs.hut.fi>
In-Reply-To: <E15JIVD-0000Qc-00@the-village.bc.nu> <01070912485904.00705@localhost.localdomain> <20010710121724.Z1503@niksula.cs.hut.fi> <87ith0a35m.fsf@cartman.azz.us-lot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87ith0a35m.fsf@cartman.azz.us-lot.org>; from azz@gnu.org on Tue, Jul 10, 2001 at 10:24:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 10:24:21PM +0100, you [Adam Sampson] claimed:
> Ville Herva <vherva@niksula.hut.fi> writes:
> 
> > It is coded is assembly specificly to heat the CPU as much as possible. See
> > the README for details, but it seems that floating point operations are
> > tougher than integers and MMX can be even harder (depending on CPU model, of
> > course). Not sure what kind of role SSE, SSE2, 3dNow! play these days.
> > Perhaps Alan knows?
> 
> I would have thought this would be a nice problem for a genetic
> algorithm to solve---start with random blocks of data, execute them
> repeatedly for a period of time (restarting upon CPU traps), and
> "breed" those that cause the greatest temperature increase. Any bored
> research students out there?

I'm sure getting an Intel or AMD engineer to comment on this would be far
more fertile. After all, engineers developed a computer in just 50 years,
but it took millions of years for the evolution to come up something like a
human being... [1]


-- v --

v@iki.fi

[1] Now, of course someone will insist that it was in fact God who created
    man... Perhaps someone ought to go to the desert and wait for an
    enlightenment on the Right Instruction Sequence.

    Ob-;), no offense intended.


