Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131281AbRCHGWC>; Thu, 8 Mar 2001 01:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131283AbRCHGVw>; Thu, 8 Mar 2001 01:21:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10135 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131281AbRCHGVs>;
	Thu, 8 Mar 2001 01:21:48 -0500
Date: Thu, 8 Mar 2001 01:21:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ben Greear <greearb@candelatech.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened
 ?(No
In-Reply-To: <3AA7276B.DB9AEC11@candelatech.com>
Message-ID: <Pine.GSO.4.21.0103080107350.5588-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Mar 2001, Ben Greear wrote:

> I see it differently:  If it's possible for the driver to protect the
> user, and it does not, then it strikes me as irresponsible programming.  If
> there is a reason other than 'only elite users are cool enough to tune
> their system, and they never make mistakes', then that's ok, but I have
> not heard that argument yet.

*users* have no business changing the system configuration. End of story.
Again, if somebody doesn't read manpages before doing stuff under root -
no point trying to protect him. He will find a way to fsck up, no matter
how many "safety" checks you put in. BTW, that's the first time I've seen
"elite" used as a term for "able to understand the meaning of words 'use
with extreme caution'". Oh, well...
							Cheers,
								Al

