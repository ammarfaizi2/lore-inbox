Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbSKFOag>; Wed, 6 Nov 2002 09:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265547AbSKFOag>; Wed, 6 Nov 2002 09:30:36 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35594 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265508AbSKFOad>; Wed, 6 Nov 2002 09:30:33 -0500
Date: Wed, 6 Nov 2002 09:35:34 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rob Landley <landley@trommello.org>
cc: Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_TINY
In-Reply-To: <200211051755.56586.landley@trommello.org>
Message-ID: <Pine.LNX.3.96.1021106093413.23780C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, Rob Landley wrote:

> Reason 4 is inertia.  You are explicitly considering inertia a good reason, 
> then?  I remember back around 1998, the argument over "-fno-strength-reduce" 
> which accomplished nothing whatsoever (and was in fact disabled in gcc 2.7.x 
> for i386) but was in the kernel compile for a long time becaue nobody could 
> be bothered to remove it...

However, there were versions of gcc which generated bad x86 code if you
didn't use it. It stayed until that version would no longer compile the
kernel.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

