Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVAGX54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVAGX54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVAGXz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:55:56 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:61122 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261775AbVAGXxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:53:52 -0500
Subject: Re: grsecurity 2.1.0 release / 5 Linux kernel advisories (fwd)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       marado@student.dei.uc.pt
In-Reply-To: <20050107134014.3ac297f3.akpm@osdl.org>
References: <Pine.LNX.4.61.0501071954130.361@student.dei.uc.pt>
	 <4d8e3fd305010713032aeaa75c@mail.gmail.com>
	 <20050107134014.3ac297f3.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105136300.7628.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 07 Jan 2005 22:49:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-07 at 21:40, Andrew Morton wrote:
> Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> >
> > the below email seems to be very intersting.
> 
> An unprivileged local user can DoS a Linux box to death with malloc and
> memset, so the RLIMIT_MEMLOCK bug isn't particularly exceptional.  All the
> others require root anyway.

The moxa one is insufficient too.

All in -ac7 just brewing now

