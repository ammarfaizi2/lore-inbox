Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbSJMQZ5>; Sun, 13 Oct 2002 12:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSJMQZ4>; Sun, 13 Oct 2002 12:25:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40822 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261528AbSJMQZ4>; Sun, 13 Oct 2002 12:25:56 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexander Kellett <lypanov@kde.org>, jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
References: <3DA1CF36.19659.13D4209@localhost>
	<3DA2BD70.14919.2C6951@localhost> <20021008112719.GC6537@pegasys.ws>
	<20021009073725.GA22778@groucho.verza.com>
	<1034164188.1253.5.camel@irongate.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2002 10:30:16 -0600
In-Reply-To: <1034164188.1253.5.camel@irongate.swansea.linux.org.uk>
Message-ID: <m1vg46mhd3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Wed, 2002-10-09 at 08:37, Alexander Kellett wrote: 
> > This talk of adeos reminds me of something that i'd
> > "dreamed" of a while back. Whats the feasability of
> > having a 70kb kernel that barely even provides support 
> > for user space apps and is basically just an hardware 
> > abstraction layer for "applications" that can be 
> > written as kernel modules?
> 
> Its called FreeDOS,

A 70KB kernel without device drivers, or anything much compiled
in is a reasonable target.   The whole "applications as modules"
thing is an entirely different animal.

The initial complaint about the size growth of the 
Anything is better that 200+KB compressed as a minimal size.

Eric
