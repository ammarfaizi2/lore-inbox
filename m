Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSIAK7K>; Sun, 1 Sep 2002 06:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSIAK7K>; Sun, 1 Sep 2002 06:59:10 -0400
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:51924 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S316667AbSIAK7I>; Sun, 1 Sep 2002 06:59:08 -0400
Date: Sun, 1 Sep 2002 13:02:07 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [Oops]: Kernel BUG at dcache.c:345 (kernel 2.4.19)
Message-ID: <20020901110207.GA317@orga.eichstaetter-triathlon.de>
References: <20020830134115.GA1711@orga.eichstaetter-triathlon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830134115.GA1711@orga.eichstaetter-triathlon.de>
User-Agent: Mutt/1.3.28i
From: Markus Blatt <Markus.Blatt@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 03:41:15PM +0200, mblatt wrote:
> Hi,
> 
> Starting from kernel version 2.4.18 I irregularly get kernel oopses
> which do not seem to depend on using special applications but rather
> on the amount auf memory used.
> 
> [snip]

As I got quite some unmotivated sigs in the last time, I also made some
Hardware tests.

According to memtest my ram seems to be Ok. Unfortnately after heavy use 
even building the kernel crashes while it succeeds directly after booting.

So I fear that there is Problem with the cooling of my cpu.

Maybe those kernel oopses could be due to that problem too.

I apologize bothering you maybe for nothing.

Regards,

Markus Blatt
