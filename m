Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSLIA72>; Sun, 8 Dec 2002 19:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbSLIA72>; Sun, 8 Dec 2002 19:59:28 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:2062 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262023AbSLIA71>; Sun, 8 Dec 2002 19:59:27 -0500
Date: Sun, 8 Dec 2002 20:05:30 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20 gets duplex wrong on NIC
In-Reply-To: <Pine.LNX.4.50.0212051230151.13104-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.3.96.1021208200339.3390C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2002, Mr. James W. Laferriere wrote:

> 
> 	Hello Bill , Severly clipped original message .
> 	If that 5509 is running slightly older code (and maybe even
> 	newer) there is(was?) a difficulty with auto-negotiation between
> 	the cisco & many adapters .  This btw is(was?) a known issue with
> 	cisco .  Also the last item I had concerning the matter ,  cisco
> 	recommeded static duplex & rate settings .  Hth ,  JimL

Yeah, I was really trying that;-) I'm working for the moment, there's a
6500 waiting to be deployed, so no effort will go into upgrading the old
machine.

Thanks for the note, I'm not clear why full_duplex doesn't work, but I
have it working now and hopefully the new router will be better.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

