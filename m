Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314034AbSEFBKm>; Sun, 5 May 2002 21:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314035AbSEFBKl>; Sun, 5 May 2002 21:10:41 -0400
Received: from [195.223.140.120] ([195.223.140.120]:21032 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314034AbSEFBKk>; Sun, 5 May 2002 21:10:40 -0400
Date: Mon, 6 May 2002 03:09:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020506030944.E6712@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E173LwB-00027n-00@starship> <20020503071554.P11414@dualathlon.random> <E174Vq8-0004BK-00@starship> <20020506015505.B14956@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 01:55:05AM +0100, Russell King wrote:
> I see no problem with the above with the existing discontigmem stuff.
> discontigmem does *not* require a linear relationship between kernel
> virtual and physical memory.  I've been running kernels for a while
> on such systems.

Indeed.

Andrea
