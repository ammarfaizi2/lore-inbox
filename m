Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTELWLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTELWLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:11:08 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:38548 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262855AbTELWLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:11:05 -0400
Date: Mon, 12 May 2003 15:23:39 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: MPPE in kernel?
Message-ID: <20030512152339.E30310@google.com>
References: <20030512045929.C29781@google.com> <200305121504.h4CF4EJ5007017@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305121504.h4CF4EJ5007017@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Mon, May 12, 2003 at 11:04:14AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 11:04:14AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 12 May 2003 04:59:29 PDT, Frank Cusack <fcusack@fcusack.com>  said:
> > I've written a public domain implementation, which I'd be willing to
> > relicense under GPL (although I don't see the point), but in any case
> 
> Well.. there's a very good reason to relicense under GPL, or BSD, or X11-style.
> 
> And that's to cover your ass from being sued.
> 
> If you release it as "public domain", you waive *all* rights to it, including:
> 
> 1) The right to prohibit or control what people do with it, including taking
> it private and closed and making lots of money off it and basically ripping
> you off.

The code is trivial (compared to the effort required to use it in any
larger application).  I understand the value of this for the general
case, though.

> 2) You can't attach a "hold harmless" clause to it.  So if you put it in
> the public domain, since you don't have copyright on it anymore, you can't
> say "as a condition of copying, you promise not to sue me if this software
> turns your hair green".

I thought public domain explicitly meant that you get what you pay for.
Kind of like good samaritan laws.  It'd be interesting to hear from any
lawyers, are any on lkml?

/fc
