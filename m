Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbTLJQef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 11:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbTLJQef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 11:34:35 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:12723 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263745AbTLJQed
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 11:34:33 -0500
Date: Wed, 10 Dec 2003 08:34:25 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Andre Hedrick <andre@linux-ide.org>,
       Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031210163425.GF6896@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Andre Hedrick <andre@linux-ide.org>,
	Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
	Kendall Bennett <KendallB@scitechsoft.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org> <Pine.LNX.4.58.0312100714390.29676@home.osdl.org> <20031210153254.GC6896@work.bitmover.com> <Pine.LNX.4.58.0312100809150.29676@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312100809150.29676@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 08:21:52AM -0800, Linus Torvalds wrote:
> There's a fundamental difference between "plugins" and "kernel modules":
> intent.

Which is?  How is it that you can spend a page of text saying a judge doesn't
care about technicalities and then base the rest of your argument on the
distinction between a "plugin" and a "kernel module"?

    "Yes, your honor, I know you don't care about technicalities but let
    me explain how a kernel model, which is a wad of code that may be
    plugged into a program called the kernel and which provides some
    additional functionality or feature, is legally different than a
    plugin, which is a wad of code that may be plugged into some other
    program not called the kernel and which provides some additional
    functionality or feature.  These are not all the same things, your
    honor, you see that, right?"

Gimme a break, Linus.  You can't have it both ways.

> But when you have the GPL, and you have documented for years and years
> that it is NOT a stable API, and that it is NOT a boundary for the license
> and that you do NOT get an automatic waiver when you compile against this
> boundary, then things are different.

You need to reread your own postings on the topic over the years.  There are
documents all the web citing you as saying that binary drivers and modules 
are fine.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
