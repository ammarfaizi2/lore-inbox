Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261779AbSJIOj2>; Wed, 9 Oct 2002 10:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261815AbSJIOj2>; Wed, 9 Oct 2002 10:39:28 -0400
Received: from smtp09.iddeo.es ([62.81.186.19]:49317 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S261779AbSJIOjX>;
	Wed, 9 Oct 2002 10:39:23 -0400
Date: Wed, 9 Oct 2002 16:45:02 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Brendan J Simon <brendan.simon@bigpond.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: linux kernel conf 0.8
Message-ID: <20021009144502.GD2954@werewolf.able.es>
References: <Pine.LNX.4.33L2.0210090730450.1001-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33L2.0210090730450.1001-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Wed, Oct 09, 2002 at 16:34:04 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.09 Randy.Dunlap wrote:
>On Thu, 10 Oct 2002, Brendan J Simon wrote:
>
>| Roman Zippel wrote:
>|
>| >>But the fact that xconfig depends on QT is going to make some people hate
>| >>it.
>| >>
...
>| This is a difficult one.  GUI's toolkits are a bit of religion
>| (fundamentalist types too).
>|
...
>
>stick with TCL/TK, like xconfig currently uses ?
>or is it not sufficient?  or just too ugly?
>

What is linux kernel conf written in ?
- perl: use perl-gtk (I think there is also a perl-qt)
- python: use py-gtk...

Use whatever the language gives. I never undestook why use tcl/tk
on a perl/python config system.


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre10-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
