Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136072AbRD0PCx>; Fri, 27 Apr 2001 11:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136073AbRD0PCo>; Fri, 27 Apr 2001 11:02:44 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:20996 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S136072AbRD0PC0>;
	Fri, 27 Apr 2001 11:02:26 -0400
Message-ID: <20010426214745.C803@bug.ucw.cz>
Date: Thu, 26 Apr 2001 21:47:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: Aaron Lehmann <aaronl@vitelus.com>, imel96@trustix.co.id,
        Daniel Stone <daniel@kabuki.openfridge.net>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <20010424225841.D5803@piro.kabuki.openfridge.net> <Pine.LNX.4.33.0104242018410.16215-100000@tessy.trustix.co.id> <20010424233801.A6067@piro.kabuki.openfridge.net> <20010424170118.F19171@vitelus.com> <20010425100748.A11099@piro.kabuki.openfridge.net> <20010424172027.G19171@vitelus.com> <20010425103246.C11099@piro.kabuki.openfridge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010425103246.C11099@piro.kabuki.openfridge.net>; from Daniel Stone on Wed, Apr 25, 2001 at 10:32:46AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > What real value does it have, apart from the geek "look at me, I'm using
> > > bash" value?
> > 
> > I don't really want to get into it at the moment, but imagine hacking
> > netfilter without lugging a laptop around. PDA's are sleek and cool,
> > and using UNIX on them lets you write shell scripts to sort your
> > addresses and stuff like that. Basically it's everything that's cool
> > about Unix as a workstation OS scaled down to PDA-size.
> 
> True, but then imagine trying to hack C (no, that's a CURLY BRACE, and a
> tab! not space! you just broke my makefiles! aargh!), and compiling

So you telnet to your PDA from some real machine. And you don't need
to write C code in order for unix environment to be usable. 50% of
unix users I know use it for pine/mutt emacs/vi talk/irc/mud kind of
stuff.

> Netfilter (it takes HOW MANY hours to compile init/main.c?!?) on a PDA.
> Hrmz.

How many hours? I'd say less than minute. In todays PDAs, 80MHz mips
cpu is *slow*.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
