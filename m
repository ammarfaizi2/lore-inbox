Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263357AbRFTQQC>; Wed, 20 Jun 2001 12:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263374AbRFTQPw>; Wed, 20 Jun 2001 12:15:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61660 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263357AbRFTQPh>;
	Wed, 20 Jun 2001 12:15:37 -0400
Date: Wed, 20 Jun 2001 12:15:35 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: bert hubert <ahu@ds9a.nl>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Threads are processes that share more
In-Reply-To: <20010620175937.A8159@home.ds9a.nl>
Message-ID: <Pine.GSO.4.21.0106201204140.24658-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Jun 2001, bert hubert wrote:

> Rounding up, it may be worth repeating what I think Alan said some months
> ago:
> 
>                     Threads are processes that share more

... and for absolute majority of programmers additional shared objects mean
additional fsckup sources.  I don't trust them to write correct async code.
OK, so I don't trust the majority of programmers to find their dicks if
you take their Visual Masturbation Aid++ away, but that's another story -
I'm talking about otherwise clued people, not burger-flippers armed with
Foo For Complete Dummies in 24 Hours.

> And if we just keep bearing that out to everybody a lot of the myths will go
> away. I would suggest that the pthreads manpages get this attitude.

