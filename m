Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbSJ3ICx>; Wed, 30 Oct 2002 03:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbSJ3ICx>; Wed, 30 Oct 2002 03:02:53 -0500
Received: from codepoet.org ([166.70.99.138]:34715 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S262663AbSJ3ICw>;
	Wed, 30 Oct 2002 03:02:52 -0500
Date: Wed, 30 Oct 2002 01:09:14 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux kernel conf 1.3
Message-ID: <20021030080914.GA7371@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3DBF4D6B.364A6DCC@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBF4D6B.364A6DCC@linux-m68k.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 30, 2002 at 04:09:31AM +0100, Roman Zippel wrote:
> Hi,
> 
> At http://www.xs4all.nl/~zippel/lc/ you can find as usual the latest
> version of the new config system.
> Changes:
> - Update to 2.5.45

It seems that 2.5.45 does not exist.  Is this vs a BK snapshot?
Attempting to install vs 2.5.44 fails rather spectacularly.
There was even a segfault in lkcc at one point while doing
a make install KERNELSRC=<blah>/linux-2.5.44

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
