Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318974AbSHFDvV>; Mon, 5 Aug 2002 23:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318975AbSHFDvV>; Mon, 5 Aug 2002 23:51:21 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55823 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318974AbSHFDvV>; Mon, 5 Aug 2002 23:51:21 -0400
Date: Mon, 5 Aug 2002 23:48:47 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Nick Orlov <nick.orlov@mail.ru>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <Pine.SOL.4.30.0208030241540.18115-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.3.96.1020805234655.4423B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Aug 2002, Bartlomiej Zolnierkiewicz wrote:

> And second problem is that 20265 is used as primary onboard
> sometimes and sometimes as offboard (another config option?).

Can that not be configured at boot time with ide0=xxx or similar? I'm
clearly missing why it would matter on or off board as long as the
controller(s) were checked in the right order.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

