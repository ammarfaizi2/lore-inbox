Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbRGWW1k>; Mon, 23 Jul 2001 18:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbRGWW1U>; Mon, 23 Jul 2001 18:27:20 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16134 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263149AbRGWW1J>; Mon, 23 Jul 2001 18:27:09 -0400
Date: Tue, 24 Jul 2001 00:27:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rob Landley <landley@webofficenow.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: user-mode port 0.44-2.4.7
Message-ID: <20010724002742.J16919@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0107231259520.13272-100000@penguin.transmeta.com> <200107232150.f6NLosh13126@vindaloo.ras.ucalgary.ca> <20010724000933.I16919@athlon.random> <01072309203206.00996@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01072309203206.00996@localhost.localdomain>; from landley@webofficenow.com on Mon, Jul 23, 2001 at 09:20:32AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 09:20:32AM -0400, Rob Landley wrote:
> On Monday 23 July 2001 18:09, Andrea Arcangeli wrote:
> 
> > GCC will obviously _never_ introduce a BUG(), I never said that, the
> > above example is only meant to show what GCC is _allowed_ to do and what
> > we have to do to write correct C code.
> 
> "Correct" C code as in portable C code?  Standards compliant so it's portable 

correct C code _mainly_ for gcc which is very aggressive.

Andrea
