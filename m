Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267359AbSLER2Q>; Thu, 5 Dec 2002 12:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267362AbSLER2Q>; Thu, 5 Dec 2002 12:28:16 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:59786 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S267359AbSLER2O>; Thu, 5 Dec 2002 12:28:14 -0500
Date: Thu, 5 Dec 2002 12:34:45 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20 gets duplex wrong on NIC
In-Reply-To: <Pine.LNX.3.96.1021205120739.18090D-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.50.0212051230151.13104-100000@filesrv1.baby-dragons.com>
References: <Pine.LNX.3.96.1021205120739.18090D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Bill , Severly clipped original message .
	If that 5509 is running slightly older code (and maybe even
	newer) there is(was?) a difficulty with auto-negotiation between
	the cisco & many adapters .  This btw is(was?) a known issue with
	cisco .  Also the last item I had concerning the matter ,  cisco
	recommeded static duplex & rate settings .  Hth ,  JimL

On Thu, 5 Dec 2002, Bill Davidsen wrote:
 ...
> > Please give _plenty_ of details about what is on the other side of the
> > cable: hub? switch? vendor of hub/switch?  crossover to another NIC?
> > what is the port configuration and what are the capabilities of the
> > other end?  is it set to autonegotiate (on the other end)?
>
> Cisco 5509 set auto.
> >
> > Why do you force full duplex?  It is often the wrong thing to do.
>
> It gives about 4x throughput...
...
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
