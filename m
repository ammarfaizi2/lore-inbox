Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSGYM5L>; Thu, 25 Jul 2002 08:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSGYM5K>; Thu, 25 Jul 2002 08:57:10 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35851 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313125AbSGYM5K>; Thu, 25 Jul 2002 08:57:10 -0400
Date: Thu, 25 Jul 2002 08:53:59 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: nejhdeh <nejhdeh@aimedics.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Basic question
In-Reply-To: <200207190831.55757.nejhdeh@aimedics.com>
Message-ID: <Pine.LNX.3.96.1020725085219.11202D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002, nejhdeh wrote:
> My question is: How can I tell gcc or even within the module itself (e.g. 
> KERNEL_VERSION) to compile for lower version kernel (i.e tell kernel 2.4.18 
> to compile for 2.2.20)

You go to the 2.2.20 kernel tree and use 'make.' You can't move modules
from one kernel to another, they're totally different programs!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

