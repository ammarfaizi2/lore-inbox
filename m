Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130285AbRBKUwh>; Sun, 11 Feb 2001 15:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130289AbRBKUw0>; Sun, 11 Feb 2001 15:52:26 -0500
Received: from ns.suse.de ([213.95.15.193]:19983 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130285AbRBKUwI>;
	Sun, 11 Feb 2001 15:52:08 -0500
Date: Sun, 11 Feb 2001 21:51:33 +0100
From: Andi Kleen <ak@suse.de>
To: Chris Evans <chris@scary.beasts.org>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: BUG: SO_LINGER + shutdown() does not block?
Message-ID: <20010211215133.A11396@gruyere.muc.suse.de>
In-Reply-To: <200102112021.XAA15811@ms2.inr.ac.ru> <Pine.LNX.4.30.0102112035230.16987-100000@ferret.lmh.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0102112035230.16987-100000@ferret.lmh.ox.ac.uk>; from chris@scary.beasts.org on Sun, Feb 11, 2001 at 08:41:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2001 at 08:41:04PM +0000, Chris Evans wrote:
> 
> [cc: Andi]

Missing context..

> 
> On Sun, 11 Feb 2001 kuznet@ms2.inr.ac.ru wrote:
> 
> > Hello!
> >
> > > I'm not seeing shutdown(2) block on a TCP socket. This is Linux kernel
> > > 2.2.16 (RH7.0). Is this a kernel bug, a documentation bug,
> >
> > Man page is wrong.
> 
> Yes, man socket(7) seems to be wrong.

What do you exactly think is wrong?


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
