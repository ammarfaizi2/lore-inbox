Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVA0ACY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVA0ACY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVAZX74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:59:56 -0500
Received: from mail.tmr.com ([216.238.38.203]:11525 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262323AbVAZUIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 15:08:07 -0500
Date: Wed, 26 Jan 2005 14:56:22 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jesse Pollard <jesse@cats-chateau.net>
cc: linux-os <linux-os@analogic.com>,
       John Richard Moser <nigelenki@comcast.net>, dtor_core@ameritech.net,
       Linus Torvalds <torvalds@osdl.org>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <05012609151500.16556@tabby>
Message-ID: <Pine.LNX.3.96.1050126143205.24013A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005, Jesse Pollard wrote:

> On Tuesday 25 January 2005 15:05, linux-os wrote:

> > This isn't relevant at all. The Navy doesn't have any secure
> > systems connected to a network to which any hackers could connect.
> > The TDRS communications satellites provide secure channels
> > that are disassembled on-board. Some ATM-slot, after decryption
> > is fed to a LAN so the sailors can have an Internet connection
> > for their lap-tops. The data took the same paths, but it's
> > completely independent and can't get mixed up no matter how
> > hard a hacker tries.
> 
> Obviously you didn't hear about the secure network being hit by the "I love 
> you" virus.
> 
> The Navy doesn't INTEND to have any secure systems connected to a network to 
> which any hackers could connect.

What's hard about that? Matter of physical network topology, absolutely no
physical connection, no machines with a 2nd NIC, no access to/from I'net.
Yes, it's a PITA, add logging to a physical printer which can't be erased
if you want to make your CSO happy (corporate security officer).
> 
> Unfortunately, there will ALWAYS be a path, either direct, or indirect between
> the secure net and the internet.

Other than letting people use secure computers after they have seen the
Internet, a good setup has no indirect paths.
> 
> The problem exists. The only to protect is to apply layers of protection.
> 
> And covering the possible unknown errors is a good way to add protection.
> 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

