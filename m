Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312358AbSDCTZe>; Wed, 3 Apr 2002 14:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312363AbSDCTZX>; Wed, 3 Apr 2002 14:25:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43274 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312364AbSDCTZD>; Wed, 3 Apr 2002 14:25:03 -0500
Date: Wed, 3 Apr 2002 11:24:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.33.0204032017150.1163-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.33.0204031124170.3004-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Apr 2002, Tigran Aivazian wrote:
>
> Ok, but isn't it easier to rename _GPL -> _KERNEL (or _INTERNAL) if,
> indeed, that is the meaning thereof? Then, in the future, one wouldn't
> have to decide on a case by case basis like we had now (and appeal to
> Caesar :) because the intention would be clear from the name?

I agree, that is really the meaning of the _GPL thing, and it would 
probably also make people react less rabidly to the whole thing.

		Linus

