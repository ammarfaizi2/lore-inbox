Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312364AbSDEIFu>; Fri, 5 Apr 2002 03:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312370AbSDEIFk>; Fri, 5 Apr 2002 03:05:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5943 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312364AbSDEIFh>; Fri, 5 Apr 2002 03:05:37 -0500
To: <robert@schwebel.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: moving some boot code out of arch directories
In-Reply-To: <Pine.LNX.4.33.0204050920180.16178-100000@callisto.local>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Apr 2002 00:59:04 -0700
Message-ID: <m1ofgypodz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel <robert@schwebel.de> writes:

> On 4 Apr 2002, Eric W. Biederman wrote:
> > A have some thoughts but nothing to concrete right now.  On every
> > architecture booting seems to be a completely roll your own solution.
> > Which I find very annoying.  This one of the reasons I am also working
> > on general linux booting linux support.  If we could get as far as a
> > bootloader that works on multiple architectures perhaps we could start
> > to unify some of these things.
> 
> You might want to have a look at PPCboot / ARMboot (the latter one is a
> recent port to ARM) which seems to be very interesting! Only a port to x86
> is missing (or, better, a unified project...)

Do you have any pointers?

Eric
