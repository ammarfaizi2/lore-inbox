Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135636AbREFMTc>; Sun, 6 May 2001 08:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135635AbREFMTW>; Sun, 6 May 2001 08:19:22 -0400
Received: from smarty.smart.net ([207.176.80.102]:10515 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S135636AbREFMTD>;
	Sun, 6 May 2001 08:19:03 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200105061221.IAA29984@smarty.smart.net>
Subject: Re: inserting a Forth-like language into the Linux kernel
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Sun, 6 May 2001 08:21:26 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200105060652.f466qwH316756@saturn.cs.uml.edu> from "Albert D. Cahalan" at May 06, 2001 02:52:57 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > I don't know about H1 S&M, but the ability to open a tty
> > normally directly into kernelspace may prove popular, particularly 
> > with a Forth on that tty in that kernelspace. Persons with actual 
> 
> With anything other than Forth, LISP, and COBOL... yes.

Nice little sensibility scale for kspamd-like things,

	Forth 1.0     Lisp  0.5     COBOL   0.0

> 
> > If someone knows of another example of interpreter-like behavior 
> > directly in a unix in-kernel thread I'd like to know about it.  
> 
> kdb
> 

That runs in trap handlers doesn't it? I don't think it's a kernel daemon.


Rick Hohensee
www.clienux.com
