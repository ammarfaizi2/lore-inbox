Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265521AbSJaXpq>; Thu, 31 Oct 2002 18:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265526AbSJaXpq>; Thu, 31 Oct 2002 18:45:46 -0500
Received: from dp.samba.org ([66.70.73.150]:61382 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265522AbSJaXpp>;
	Thu, 31 Oct 2002 18:45:45 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's left over. 
In-reply-to: Your message of "Thu, 31 Oct 2002 10:15:58 -0000."
             <20021031101558.GB7487@fib011235813.fsnet.co.uk> 
Date: Fri, 01 Nov 2002 08:14:16 +1100
Message-Id: <20021031235212.F0B952C0FC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021031101558.GB7487@fib011235813.fsnet.co.uk> you write:
> On Thu, Oct 31, 2002 at 02:00:31PM +1100, Rusty Russell wrote:
> > They have, IIRC.  Interestingly, it was less invasive (existing source
> > touched) than the LVM2/DM patch you merged.
> 
> FUD.  I added to three areas of existing code:

[ 40-line detailed explanation snipped ]

Woah!  War's over dude!  We won!

I used Rusty's Unreliable Intrusiveness-o-meter (number of existing
non-config files touched), as I said.

I didn't read code or anything so unscientific or accurate.  But both
DM and EVMS were way down on the "intrusiveness" list.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
