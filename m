Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317858AbSIOGC4>; Sun, 15 Sep 2002 02:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317859AbSIOGC4>; Sun, 15 Sep 2002 02:02:56 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:63114 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317858AbSIOGC4>; Sun, 15 Sep 2002 02:02:56 -0400
Date: Sun, 15 Sep 2002 02:07:39 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020915020739.A22101@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com> <E17qRfU-0001qz-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17qRfU-0001qz-00@starship>; from phillips@arcor.de on Sun, Sep 15, 2002 at 07:10:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Phillips <phillips@arcor.de>
> Date: Sun, 15 Sep 2002 07:10:00 +0200

>[...]
> Let's try a different show of hands: How many users would be happier if
> they knew that kernel developers are using modern techniques to improve
> the quality of the kernel?

I do not see how using a debugger improves a quality of the kernel.
Good thinking and coding does improve kernel quality. Debugger
certainly does not help if someone cannot code.

A debugger can do some good things. Some people argue that it
improves productivity, which I think may be true under some
circomstances. If your build system sucks and/or slow, and
if you work with a binary only software, debugger helps.
If you work with something like Linux, and compile on something
better than a 333MHz x86, it probably does not help your
productivity. This is all wonderful, but has nothing to do
with the code quality.

And to think that your users would be happier with a crap produced
by a debugger touting Windows graduate than with a quality code
debugged with observation simply defies any reason.

-- Pete
