Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312379AbSDCTaZ>; Wed, 3 Apr 2002 14:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312381AbSDCTaF>; Wed, 3 Apr 2002 14:30:05 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8733 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312386AbSDCT33>; Wed, 3 Apr 2002 14:29:29 -0500
Date: Wed, 3 Apr 2002 21:29:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020403212909.K10959@dualathlon.random>
In-Reply-To: <Pine.LNX.4.33.0204031947210.1163-100000@einstein.homenet> <Pine.LNX.4.33.0204031106420.3004-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2002 at 11:10:19AM -0800, Linus Torvalds wrote:
> reasons mentioned, but simply because even Ingo agreed that it shouldn't 
> be _GPL since it's explicitly meant for drivers that shouldn't have any 
> knowledge whatsoever about the VM internals. GPL or not.

I told exactly that in the first email, when I was still talking about
technical things.

Andrea
