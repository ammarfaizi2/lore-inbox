Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261765AbSJIO3q>; Wed, 9 Oct 2002 10:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbSJIO3q>; Wed, 9 Oct 2002 10:29:46 -0400
Received: from air-2.osdl.org ([65.172.181.6]:2486 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261765AbSJIO3p>;
	Wed, 9 Oct 2002 10:29:45 -0400
Date: Wed, 9 Oct 2002 07:34:04 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Brendan J Simon <brendan.simon@bigpond.com>
cc: Roman Zippel <zippel@linux-m68k.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: linux kernel conf 0.8
In-Reply-To: <3DA43C3A.2060608@bigpond.com>
Message-ID: <Pine.LNX.4.33L2.0210090730450.1001-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2002, Brendan J Simon wrote:

| Roman Zippel wrote:
|
| >>But the fact that xconfig depends on QT is going to make some people hate
| >>it.
| >>
| >>
| >This should be rather easily fixable, but it has to be done by someone who
| >is more familiar with whatever prefered toolkit. I'm familiar with QT and
| >it's absolutely great to get quickly reasonable results, if someone wants
| >something else I gladly will help, but I can't do it myself.
| >The interface to the back end is quite simple so it should be no real
| >problem to add a different user interface.
| >
|
| This is a difficult one.  GUI's toolkits are a bit of religion
| (fundamentalist types too).
|
[good descriptions snipped]
|
| I'm pretty sure there is no one solution and it comes down to the
| politics and preferences of the final decision makers up the heirarchy.
|
| Good luck,

stick with TCL/TK, like xconfig currently uses ?
or is it not sufficient?  or just too ugly?

-- 
~Randy
  "In general, avoiding problems is better than solving them."
  -- from "#ifdef Considered Harmful", Spencer & Collyer, USENIX 1992.

