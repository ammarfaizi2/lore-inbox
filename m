Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132207AbQKJXkz>; Fri, 10 Nov 2000 18:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132191AbQKJXkp>; Fri, 10 Nov 2000 18:40:45 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:53508 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S132186AbQKJXkd>; Fri, 10 Nov 2000 18:40:33 -0500
Date: Fri, 10 Nov 2000 18:40:31 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: George Anzinger <george@mvista.com>
Cc: "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Re: Where is it written?
Message-ID: <20001110184031.A2704@munchkin.spectacle-pond.org>
In-Reply-To: <3A0C2464.A7CDEFAB@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A0C2464.A7CDEFAB@mvista.com>; from george@mvista.com on Fri, Nov 10, 2000 at 08:37:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 08:37:56AM -0800, George Anzinger wrote:
> I thought this would be simple, but...
> 
> Could someone point me at the info on calling conventions to be used
> with
> x86 processors.  I need this to write asm code correctly and I suspect
> that it is a bit more formal than the various comments I have found in
> the sources.  Is it, perhaps an Intel doc?  Or a gcc thing?

It may be out of print by now, but the original reference for the x86 ABI, is
the:

	System V Application Binary Interface
	Intel386 (tm) Processor Supplement

When Cygnus purchased the manual I have, many moons ago, it was published by
AT&T, with a copyright date of 1991, published by Prentice Hall, with an ISBN
number of 0-13-877689-X.  It most recently was published by SCO (possibly even
Caldera, which just bought SCO).  You can get an online version from:

	http://www.sco.com/developer/devspecs/abi386-4.pdf

-- 
Michael Meissner, Red Hat, Inc.
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
