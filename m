Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313801AbSDIANP>; Mon, 8 Apr 2002 20:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313802AbSDIANO>; Mon, 8 Apr 2002 20:13:14 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57861 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313801AbSDIANO>; Mon, 8 Apr 2002 20:13:14 -0400
Date: Mon, 8 Apr 2002 20:10:48 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mark Mielke <mark@mark.mielke.cc>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
In-Reply-To: <20020408174529.A546@mark.mielke.cc>
Message-ID: <Pine.LNX.3.96.1020408200748.23533A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, Mark Mielke wrote:

> I think the fact that it works with FreeBSD should have been enough
> to show that 'excessive' doesn't need to be qualified.
> 
> The question is, how is CD burning of raw data different from
> CD burning of ISO images, in respect to Linux drivers for the
> hardware, and why does FreeBSD not suffer from this ailment?

  Let's say it didn't give me a clue how much time was being used and
where. There are various options like bytes swap which could drive up user
time, and other things like PIO which drive up system.

  I find I give a better quality of help if I understand the problem...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
 

