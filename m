Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263553AbRFNSD5>; Thu, 14 Jun 2001 14:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263574AbRFNSDr>; Thu, 14 Jun 2001 14:03:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:32820 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263553AbRFNSDb>; Thu, 14 Jun 2001 14:03:31 -0400
Date: Thu, 14 Jun 2001 20:03:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@redhat.com>
Subject: Re: unregistered changes to the user<->kernel API
Message-ID: <20010614200328.A2115@athlon.random>
In-Reply-To: <20010614191219.A30567@athlon.random> <3B28F376.1F528D5A@mandrakesoft.com> <20010614194419.A715@athlon.random> <3B28F9EC.D08D3D52@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B28F9EC.D08D3D52@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Jun 14, 2001 at 01:52:44PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 01:52:44PM -0400, Jeff Garzik wrote:
> You're missing the point -- it's a bad precedent.
> 
> How many kernel forks and patches exist out there on the net?

How many of them are applied to 90% of kernels running out there? How
many of them will get merged eventually? How many of them makes
modifications to the kernel that are visible to userspace in any
possibly configuration of the kernel?

> Tangent:  Why is this webserver-specific crap in kernel_stat anyway?  It
> Even when merging Tux, I would hope Linus would not apply this
> particular change.

Indeed, I also said this in my first email :)

Andrea
