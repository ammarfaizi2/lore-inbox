Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSJIQXq>; Wed, 9 Oct 2002 12:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261876AbSJIQXq>; Wed, 9 Oct 2002 12:23:46 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:24587 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261874AbSJIQXp>; Wed, 9 Oct 2002 12:23:45 -0400
Date: Wed, 9 Oct 2002 18:29:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Brendan J Simon <brendan.simon@bigpond.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: linux kernel conf 0.8
In-Reply-To: <Pine.LNX.4.33L2.0210090816560.1001-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210091818160.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Oct 2002, Randy.Dunlap wrote:

> So I think that you and Roman are close to agreement, when Roman
> has the library backend ready.  Of course someone needs to do a
> "reference implementation" with it also, but it doesn't need to
> ship with the kernel.

We ship BK documentation, so shipping a small QT app can't be that
problematic. :)
Creating the library isn't that difficult (kbuild is currently my
problem here) and I'll still have to write some API documentation for it
and some glue code to load the library.

bye, Roman

