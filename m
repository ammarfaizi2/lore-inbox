Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312363AbSDCT1o>; Wed, 3 Apr 2002 14:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312374AbSDCT1h>; Wed, 3 Apr 2002 14:27:37 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11548 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312379AbSDCT1O>; Wed, 3 Apr 2002 14:27:14 -0500
Date: Wed, 3 Apr 2002 21:26:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjanv@redhat.com>,
        Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020403212633.J10959@dualathlon.random>
In-Reply-To: <E16soms-0004Au-00@the-village.bc.nu> <Pine.LNX.4.33.0204031947210.1163-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2002 at 08:03:52PM +0100, Tigran Aivazian wrote:
> On Wed, 3 Apr 2002, Alan Cox wrote:
> > >  EXPORT_SYMBOL(vfree);
> > >  EXPORT_SYMBOL(__vmalloc);
> > > -EXPORT_SYMBOL_GPL(vmalloc_to_page);
> > > +EXPORT_SYMBOL(vmalloc_to_page);
> >
> > The authors of that code made it GPL. You have no right to change that. Its
> > exactly the same as someone taking all your code and making it binary only.
> 
> Dear Alan,
> 
> You know how much I respect you and your words so I don't need to write
> long a apologetic introduction if I wish to correct your statement.
> 
> Namely, you are saying that Andrea changed some code from being GPL to
> non-GPL. That is so obviously not true that I am even surprized that I
> need to point this out explicitly (especially to you; as Jesus said to

200% agreed. thanks for making the facts clear,

Andrea
