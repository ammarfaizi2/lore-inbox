Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261560AbSKCAAO>; Sat, 2 Nov 2002 19:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbSKCAAN>; Sat, 2 Nov 2002 19:00:13 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:38390 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S261560AbSKCAAL>;
	Sat, 2 Nov 2002 19:00:11 -0500
Date: Sun, 3 Nov 2002 01:06:41 +0100
From: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Message-ID: <20021103000641.GA5284@werewolf.able.es>
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com> <20021102232836.GD731@gallifrey> <200211030943.13730.neroz@iinet.net.au> <Pine.LNX.4.44.0211030052410.13258-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0211030052410.13258-100000@serv>; from zippel@linux-m68k.org on Sun, Nov 03, 2002 at 00:59:49 +0100
X-Mailer: Balsa 2.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.11.03 Roman Zippel wrote:
> Hi,
> 
> On Sun, 3 Nov 2002, Nero wrote:
> 
> > OR, we could use the logical choice. GTK+ is on most systems, has hardly any 
> > dependancies, is relatively small (compared to Qt) and doesn't require a C++ 
> > compiler. Really, I think the only people being religious here are the ones 
> > voting for Qt, as it just doesn't make sense to use it for such a thing.
> 
> Show me the source and we can continue this discussion. Right now qconf is 
> included as replacement for the old xconfig. It shouldn't take to much 
> effort to package it seperately. As soon as someone is interested in doing 
> this for a distribtion I'll add the few missing bits.
> 

As I see it, the onle thing that should be included in a standard kernel
would be something like a kconfig-xaw, that is sure to be on every box that
has X, and could be a reference implementation.

And you could face one other religious war: qt2 or qt3 ? So as gtk1 or gtk2...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-rc1-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
