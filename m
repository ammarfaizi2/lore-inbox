Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262823AbSI3S0D>; Mon, 30 Sep 2002 14:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262825AbSI3S0D>; Mon, 30 Sep 2002 14:26:03 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:62339 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S262823AbSI3SZ7>;
	Mon, 30 Sep 2002 14:25:59 -0400
Date: Mon, 30 Sep 2002 13:29:34 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mikael Pettersson <mikpe@csd.uu.se>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 Kernel Problem Reports as of 27 Sep
In-Reply-To: <1033403382.16918.16.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209301328480.3692-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Sep 2002, Alan Cox wrote:

> On Mon, 2002-09-30 at 01:10, Mikael Pettersson wrote:
> > On Fri, 27 Sep 2002 19:54:16 -0500 (CDT), Thomas Molina wrote:
> > >------------------------------------------------------------------------
> > >  24. http://marc.theaimsgroup.com/?l=linux-kernel&m=103277899317468&w=2
> > >   IDE problems on prePCI                 open               23 Sep 2002
> > >
> > >This was reported by Mikael Pettersson <mikpe@csd.uu.se>, but never 
> > >responded to, and never followed up.  Should this be kept open?
> > 
> > The hang in INIT with 2.5.38 is gone with 2.5.39, but the instant
> > reboot when I pass the "ide0=qd65xx" kernel option is still there.
> 
> This seems to be working ok on the 2.4.20pre8-ac IDE branch.

The concern in the original message was specifically with 2.5 stuff, not 
2.4.  Has anyone looked at his patch for pci-less systems?

