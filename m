Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbTAIHUl>; Thu, 9 Jan 2003 02:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbTAIHUl>; Thu, 9 Jan 2003 02:20:41 -0500
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:49788 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S261847AbTAIHUj>; Thu, 9 Jan 2003 02:20:39 -0500
Date: Thu, 9 Jan 2003 08:29:19 +0100 (CET)
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: Andrew McGregor <andrew@indranet.co.nz>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
In-Reply-To: <20030108224339.GO22951@wiggy.net>
Message-ID: <Pine.LNX.4.51.0301090822001.19862@trider-g7.ext.fabbione.net>
References: <20030108130850.GQ22951@wiggy.net>
 <Pine.LNX.4.51.0301081849550.564@diapolon.int.fabbione.net>
 <78180000.1042055993@localhost.localdomain> <20030108224339.GO22951@wiggy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Jan 2003, Wichert Akkerman wrote:

> Previously Andrew McGregor wrote:
> > Probably on the server's side it got an ICMP Host Unreachable or two as
> > some router updated its tables, and decided to close the connection.
>
> The fact that this problem does not seem to occur when using a window
> XP client seems to contradict the suggestions that it may be a router
> problem.
>
> Wichert.
>
>

Is the WinXP client located in the same place where you are?

>From my side the ISP that is giving me problems is xs26.net
at 2 different points. One is flapping and one is the link between them
and another ISP (i can't even reach it now) where pkts get seriously
delayed (from 100ms to more than 350ms) probably due to a slow link.
But what is seriously annoying is that xs26.net keeps announcing a network
that it can't reach, fscking the entire routing.

Fabio

