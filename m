Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292323AbSBYWTp>; Mon, 25 Feb 2002 17:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292352AbSBYWTg>; Mon, 25 Feb 2002 17:19:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22433 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292351AbSBYWTT>;
	Mon, 25 Feb 2002 17:19:19 -0500
Date: Mon, 25 Feb 2002 14:16:50 -0800 (PST)
Message-Id: <20020225.141650.36651183.davem@redhat.com>
To: Thomas.Duffy.99@alumni.brown.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1014675271.12310.36.camel@tduffy-lnx.afara.com>
In-Reply-To: <Pine.LNX.4.21.0202251631170.31542-100000@freak.distro.conectiva>
	<20020225.140851.31656207.davem@redhat.com>
	<1014675271.12310.36.camel@tduffy-lnx.afara.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
   Date: 25 Feb 2002 14:14:30 -0800
   
   the problem with that is the top level Makefile still needs to be
   changed.  the last thing I want is to be running a 2.4.18-rc3 kernel and
   have uname tell me it is 2.4.18.

I think the benefits of not screwing up the real release
are larger than this inconvenience.

As a side note I also think it's silly that we can't just "fix up"
when a slight error is made like this.  In the worst possible case one
could make a real quick "2.4.18a" release that had things fixed.

Personally I'd just put fixed files up and say "sorry the original one
didn't have the holy penguin pee on it, this one does" and tell
people to simply cope.
