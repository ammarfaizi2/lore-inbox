Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267271AbTBDOk6>; Tue, 4 Feb 2003 09:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267273AbTBDOk6>; Tue, 4 Feb 2003 09:40:58 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:58375 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267271AbTBDOk5>; Tue, 4 Feb 2003 09:40:57 -0500
Date: Tue, 4 Feb 2003 15:49:37 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       <linux-kernel@vger.kernel.org>, <greg@kroah.com>, <jgarzik@pobox.com>
Subject: Re: [PATCH] Module alias and device table support. 
In-Reply-To: <200302040805.h1485lhI002898@eeyore.valparaiso.cl>
Message-ID: <Pine.LNX.4.44.0302041451370.1358-100000@serv>
References: <200302040805.h1485lhI002898@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 4 Feb 2003, Horst von Brand wrote:

> People
> backward compatibility and minimal upgrading pain (to get your random BOFH
> to recompile a kernel is _not_ trivial today!) is much more important than
> code backward compatibility, IMHO. [I'm speaking from the perspective of
> the user/sysadmin, _not_ the kernel hacker here].

I can only agree and I hope more people realize the importance of this.
My main problem with the module fiasco are the complete new user space 
tools. I urge anyone who only cares a little bit about modules to compare 
modules.conf(5) with modprobe.conf(5) and to tell me whether _all_ the
removed options are really unnecessary? What happened to deprecating 
features _first_?

bye, Roman

