Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135782AbRDYBMr>; Tue, 24 Apr 2001 21:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135786AbRDYBMi>; Tue, 24 Apr 2001 21:12:38 -0400
Received: from stanis.onastick.net ([207.96.1.49]:26122 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S135782AbRDYBMc>; Tue, 24 Apr 2001 21:12:32 -0400
Date: Tue, 24 Apr 2001 21:12:32 -0400
From: Disconnect <lkml@sigkill.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
Message-ID: <20010424211232.A18781@sigkill.net>
In-Reply-To: <20010424225841.D5803@piro.kabuki.openfridge.net> <Pine.LNX.4.33.0104242018410.16215-100000@tessy.trustix.co.id> <20010424233801.A6067@piro.kabuki.openfridge.net> <20010424170118.F19171@vitelus.com> <20010425100748.A11099@piro.kabuki.openfridge.net> <20010424172027.G19171@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010424172027.G19171@vitelus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2001, Aaron Lehmann did have cause to say:

> On Wed, Apr 25, 2001 at 10:07:48AM +1000, Daniel Stone wrote:
> > What real value does it have, apart from the geek "look at me, I'm using
> > bash" value?
> 
> I don't really want to get into it at the moment, but imagine hacking
> netfilter without lugging a laptop around. PDA's are sleek and cool,
> and using UNIX on them lets you write shell scripts to sort your
> addresses and stuff like that. Basically it's everything that's cool
> about Unix as a workstation OS scaled down to PDA-size.

Two (not quite exclusive ;) ..) points:

First, most pda's have apps like telnet/ssh/etc available. (And even more
specific apps are available for various uses - I recall a palm pilot app
that talked to cisco gear and gave a nice gui for 90% of the config, plus
a terminal for the rest.)

And second, I agree that there are some great advantages to small linux
(my ipaq runs linux, and my barely larger libretto is a full debian
mirror) but all of these (even pocketlinux, which is basically not linux)
work with the concept of multiple users.  Whether for profiles or for
system vs user, they all use it.  This patch is trash.



-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P- L+++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t
5--- X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
