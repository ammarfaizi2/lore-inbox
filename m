Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267371AbTBNT7o>; Fri, 14 Feb 2003 14:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbTBNT7o>; Fri, 14 Feb 2003 14:59:44 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:56840 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267371AbTBNT7n>; Fri, 14 Feb 2003 14:59:43 -0500
Date: Fri, 14 Feb 2003 21:09:18 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Werner Almesberger <wa@almesberger.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <kuznet@ms2.inr.ac.ru>,
       <davem@redhat.com>, <kronos@kronoz.cjb.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Migrating net/sched to new module interface
In-Reply-To: <20030214153039.G2092@almesberger.net>
Message-ID: <Pine.LNX.4.44.0302142106140.1336-100000@serv>
References: <20030214120628.208112C464@lists.samba.org>
 <Pine.LNX.4.44.0302141410540.1336-100000@serv> <20030214105338.E2092@almesberger.net>
 <Pine.LNX.4.44.0302141500540.1336-100000@serv> <20030214153039.G2092@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Feb 2003, Werner Almesberger wrote:

> > Please try work with me here and we might find a more general solution.
> > I could just post possible solutions, but as long nobody understands the 
> > problem, they will be rejected anyway.
> 
> Step one is to fix those "unfixable" problems. That's independent
> of modules, and I'm convinced that it needs to be done.

Step one is still to understand the problem. I described a very real 
problem, once this problem is solved (which can be done in different 
ways), I can explain how this can be applied to modules. It's not really 
independent of modules.

bye, Roman

