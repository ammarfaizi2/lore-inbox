Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269829AbRHWS0W>; Thu, 23 Aug 2001 14:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269868AbRHWS0M>; Thu, 23 Aug 2001 14:26:12 -0400
Received: from stanis.onastick.net ([207.96.1.49]:55057 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S269829AbRHWS0A>; Thu, 23 Aug 2001 14:26:00 -0400
Date: Thu, 23 Aug 2001 14:26:15 -0400
From: Disconnect <lkml@sigkill.net>
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: releasing driver to kernel in source+binary format
Message-ID: <20010823142615.E25051@sigkill.net>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880B3E@xsj02.sjs.agilent.com> <Pine.LNX.4.33.0108231414000.14247-100000@terbidium.openservices.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0108231414000.14247-100000@terbidium.openservices.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001, Ignacio Vazquez-Abrams did have cause to say:

> 
> It's probably just easier to supply a non-GPLed binary-only driver. Realize,
> though, that if you have any sort of binary-only driver in any way, there are
> those who will a) refuse to buy or use your product(s), and b) persuade others
> to do the same.

And don't forget c) every single bug or problem report about any machine
with that driver will get sent to you - none of the developers and very
few of the others (especially on LKML) will touch it if the problem occurs
while that driver is loaded.

(For references, check the mail archives for issues from people w/ nvidia
cards - you'll see the occasional help request, followed by quite a lot of
"go talk to nvidia about it, its a binary driver so we can't help"...)

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P- L+++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t
5--- X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
